package api

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"sync"

	db "github.com/duo/db/sqlc"
	"github.com/duo/pb"
	"github.com/google/uuid"
)

type GameUserStreams struct {
	GameStateStream pb.DUOService_GetGameStateServer
	PlayerStream    pb.DUOService_GetPlayerStreamServer
	UserId          uuid.UUID
}

func NewGameUserStream(userId uuid.UUID) *GameUserStreams {
	return &GameUserStreams{
		UserId: userId,
	}
}

type Game struct {
	StackStream pb.DUOService_GetStackStreamServer
	UserStreams []GameUserStreams
	Mu          sync.RWMutex
}

type GameManager struct {
	GameStreams map[int]*Game
	store       db.Store
	Mu          sync.RWMutex
}

func NewGameManager(store db.Store) *GameManager {
	return &GameManager{
		GameStreams: make(map[int]*Game),
		store:       store,
		Mu:          sync.RWMutex{},
	}
}

// Returns the game id and the game object
func (gm *GameManager) CreateGame(lobby *Lobby, lobbyId int32) (int, error) {
	dbLobby, getErr := gm.store.GetLobbyByID(context.Background(), lobbyId)
	if getErr != nil {
		log.Printf("error getting lobby: %v", getErr)
		return 0, getErr
	}

	dbGame, createErr := gm.store.CreateGameState(context.Background(), db.CreateGameStateParams{
		CurrentPlayerID:  dbLobby.OwnerID,
		OwnerID:          dbLobby.OwnerID,
		StackID:          dbLobby.StackID,
		CardOnTopOfStack: sql.NullString{Valid: false},
	})
	if createErr != nil {
		log.Printf("error creating game: %v", createErr)
		return 0, fmt.Errorf("error creating game: %v", createErr)
	}

	//Create game in db as a transaction
	// var dbGame db.GameState
	txErr := gm.store.ExecTx(context.Background(), sql.LevelDefault, func(q *db.Queries) error {
		//Add all expected users to db
		for i, user := range lobby.UserStreams {
			_, addErr := gm.store.AddPlayerToGame(context.Background(), db.AddPlayerToGameParams{
				GameID:         int32(dbGame.ID),
				PlayerID:       user.UserId,
				PlayerPosition: int32(i),
			})
			if addErr != nil {
				log.Printf("error adding player to game: %v", addErr)
				return addErr
			}
		}
		return nil
	})
	if txErr != nil {
		return 0, txErr
	}

	gm.Mu.Lock()
	gm.GameStreams[int(dbGame.ID)] = &Game{}
	gm.Mu.Unlock()

	return int(dbGame.ID), nil
}

func (gm *GameManager) GetGame(gameId int) (*Game, bool) {
	gm.Mu.RLock()
	game, exists := gm.GameStreams[gameId]
	gm.Mu.RUnlock()
	if !exists {
		return nil, exists
	}
	return game, exists
}

func (gm *GameManager) HasEveryoneJoined(gameId int) (bool, error) {
	game, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("game does not exist")
		return false, fmt.Errorf("game does not exist")
	}

	dbUsers, getErr := gm.store.GetPlayersInGame(context.Background(), int32(gameId))
	if getErr != nil {
		log.Printf("error getting players in game: %v", getErr)
		return false, getErr
	}

	if len(game.UserStreams) != len(dbUsers) {
		return false, nil
	}

	game.Mu.RLock()
	for _, user := range game.UserStreams {
		if user.GameStateStream == nil {
			game.Mu.RUnlock()
			return false, nil
		}
		if user.PlayerStream == nil {
			game.Mu.RUnlock()
			return false, nil
		}
	}
	game.Mu.RUnlock()

	if game.StackStream == nil {
		return false, nil
	}

	return true, nil
}

func (gm *GameManager) UpdateGameState(gameId int, state *pb.GameState) []error {
	game, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("game does not exist")
		return []error{fmt.Errorf("game does not exist")}
	}

	isCardOnTopOfStack := len(state.CardOnTopOfDiscard) != 0

	if isCardOnTopOfStack {
		placeStack, placeErr := gm.store.GetGamePlaceStack(context.Background(), int64(gameId))
		if placeErr != nil && placeErr != sql.ErrNoRows {
			log.Printf("error getting place stack: %v", placeErr)
			return []error{placeErr}
		}
		drawStack, drawErr := gm.store.GetGameDrawStack(context.Background(), int64(gameId))
		if drawErr != nil && drawErr != sql.ErrNoRows {
			log.Printf("error getting draw stack: %v", drawErr)
			return []error{drawErr}
		}
		drawStackIds := make([]string, len(drawStack))
		for i, card := range drawStack {
			drawStackIds[i] = card.CardID
		}
		//Send data to stackStream
		if game.StackStream != nil {
			sendErr := game.StackStream.Send(&pb.StackState{
				PlaceStack: &pb.PlaceStackState{
					AmountCards: int32(len(placeStack)),
					CardIdOnTop: state.CardOnTopOfDiscard,
				},
				DrawStack: &pb.DrawStackState{
					StackId: int32(gameId),
					CardIds: drawStackIds,
				},
				Direction: state.Direction,
			})
			if sendErr != nil {
				log.Printf("error sending card on top of stack to game %d: %v", gameId, sendErr)
				return []error{sendErr}
			}
		}
	}

	_, updateErr := gm.store.UpdateGameState(context.Background(), db.UpdateGameStateParams{
		ID: int32(gameId),
		CurrentPlayerID: uuid.NullUUID{
			UUID:  uuid.MustParse(state.CurrentPlayerUuid),
			Valid: true,
		},
		IsClockwise: sql.NullBool{
			Bool:  state.Direction == pb.Direction_CLOCKWISE,
			Valid: true,
		},
		CardOnTopOfStack: sql.NullString{String: state.CardOnTopOfDiscard, Valid: isCardOnTopOfStack},
	})

	if updateErr != nil {
		log.Printf("error updating game state: %v", updateErr)
		return []error{updateErr}
	}

	game.Mu.Lock()
	errs := []error{}
	for _, user := range game.UserStreams {
		if user.GameStateStream != nil {
			sendErr := user.GameStateStream.Send(state)
			if sendErr != nil {
				errs = append(errs, sendErr)
				log.Printf("error sending game state to user %v: %v", user.UserId, sendErr)
			}
		}
	}
	game.Mu.Unlock()

	if len(errs) > 0 {
		return errs
	}

	return nil
}

func (gm *GameManager) SetStackStream(gameId int, userId uuid.UUID, stream pb.DUOService_GetStackStreamServer) error {
	game, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("game does not exist")
		return fmt.Errorf("game does not exist")
	}

	//Stack stream mustn't be set
	if game.StackStream != nil {
		log.Printf("stack stream already set")
		return fmt.Errorf("stack stream already set")
	}

	dbGame, getErr := gm.store.GetGameStateById(context.Background(), int32(gameId))
	if getErr != nil {
		log.Printf("error getting game: %v", getErr)
		return getErr
	}

	if dbGame.StackID != userId {
		log.Printf("user %v is not the stack owner", userId)
		return fmt.Errorf("user %v is not the stack owner", userId)
	}

	game.Mu.Lock()
	game.StackStream = stream
	game.Mu.Unlock()

	sendErr := gm.SendFirstGameStateIfAllPlayersAreReady(gameId)
	if sendErr != nil {
		log.Printf("error sending first game state: %v", sendErr)
		return sendErr
	}

	log.Printf("stack stream of game: %d connected", gameId)

	<-stream.Context().Done()

	log.Printf("stack stream of game: %d disconnected", gameId)

	gm.DeleteGame(gameId, true, "stack stream disconnected")

	return nil
}

func (gm *GameManager) AddGameStateStream(gameId int, userId uuid.UUID, stream pb.DUOService_GetGameStateServer) error {
	game, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("game does not exist")
		return fmt.Errorf("game does not exist")
	}

	game.Mu.Lock()
	index := -1
	for i, user := range game.UserStreams {
		if user.UserId == userId {
			index = i
			break
		}
	}
	if index == -1 {
		game.UserStreams = append(game.UserStreams, GameUserStreams{
			GameStateStream: stream,
			UserId:          userId,
		})
	} else {
		if game.UserStreams[index].GameStateStream != nil {
			log.Printf("game state stream already set")
			game.Mu.Unlock()
			return fmt.Errorf("game state stream already set")
		}
		game.UserStreams[index].GameStateStream = stream
	}
	game.Mu.Unlock()

	sendErr := gm.SendFirstGameStateIfAllPlayersAreReady(gameId)
	if sendErr != nil {
		log.Printf("error sending first game state: %v", sendErr)
		return sendErr
	}

	log.Printf("game state stream of game: %d connected", gameId)

	<-stream.Context().Done()

	log.Printf("game state stream of game: %d disconnected", gameId)

	gm.RemovePlayerFromGame(gameId, userId)

	return nil
}

func (gm *GameManager) AddPlayerStream(gameId int, userId uuid.UUID, stream pb.DUOService_GetPlayerStreamServer) error {
	game, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("game does not exist")
		return fmt.Errorf("game does not exist")
	}

	game.Mu.Lock()
	index := -1
	for i, user := range game.UserStreams {
		if user.UserId == userId {
			index = i
			break
		}
	}
	if index == -1 {
		game.UserStreams = append(game.UserStreams, GameUserStreams{
			PlayerStream: stream,
			UserId:       userId,
		})
	} else {
		if game.UserStreams[index].PlayerStream != nil {
			log.Printf("player stream already set")
			game.Mu.Unlock()
			return fmt.Errorf("player stream already set")
		}
		game.UserStreams[index].PlayerStream = stream
	}

	game.Mu.Unlock()

	sendErr := gm.SendFirstGameStateIfAllPlayersAreReady(gameId)
	if sendErr != nil {
		log.Printf("error sending first game state: %v", sendErr)
		return sendErr
	}

	log.Printf("player stream of game: %d connected", gameId)

	//Listen for player stream disconnect or messages
	for {
		recvMsg, recvErr := stream.Recv()
		if recvErr != nil {
			log.Printf("error receiving player stream: %v", recvErr)
			break
		}

		dbGame, getErr := gm.store.GetGameStateById(context.Background(), int32(gameId))
		if getErr != nil {
			log.Printf("error getting game: %v", getErr)
		}

		var direction pb.Direction
		if dbGame.IsClockwise {
			direction = pb.Direction_CLOCKWISE
		} else {
			direction = pb.Direction_COUNTER_CLOCKWISE
		}

		nextPlayerUuid, nextPlayerName, nextPlayerErr := gm.GetNextPlayer(gameId, dbGame.IsClockwise)
		if nextPlayerErr != nil {
			log.Printf("error getting next player: %v", nextPlayerErr)
		}

		allPlayersReady, readyErr := gm.HasEveryoneJoined(gameId)
		if readyErr != nil {
			log.Printf("error checking if everyone is ready: %v", readyErr)
		}

		if !allPlayersReady {
			log.Printf("not all players are ready")
		}

		//Handle player stream messages
		if recvMsg.Action == pb.PlayerAction_PLACE {
			//Place card
			placeErr := gm.UpdateGameState(gameId, &pb.GameState{
				CardOnTopOfDiscard: recvMsg.CardId,
				CurrentPlayerUuid:  nextPlayerUuid.String(),
				CurrentPlayerName:  nextPlayerName,
				Direction:          direction,
				GameId:             int32(gameId),
				AllPlayersReady:    allPlayersReady,
				IsGameOver:         false,
			})
			if placeErr != nil {
				log.Printf("error placing card: %v", placeErr)
				break
			}
		}

	}

	log.Printf("player stream of game: %d disconnected", gameId)

	gm.RemovePlayerFromGame(gameId, userId)

	return nil
}

func (gm *GameManager) RemovePlayerFromGame(gameId int, userId uuid.UUID) error {
	game, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("game does not exist")
		return fmt.Errorf("game does not exist")
	}

	game.Mu.RLock()
	newStreams := []GameUserStreams{}
	for _, user := range game.UserStreams {
		if user.UserId != userId {
			newStreams = append(newStreams, user)
		}
	}
	game.Mu.RUnlock()
	game.Mu.Lock()
	game.UserStreams = newStreams
	game.Mu.Unlock()

	log.Printf("player %v removed from game: %d", userId, gameId)

	return nil
}

func (gm *GameManager) DeleteGame(gameId int, sendGameOverMessage bool, gameOverReason string) error {
	_, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("game does not exist")
		return fmt.Errorf("game does not exist")
	}

	if sendGameOverMessage {

		gm.UpdateGameState(gameId, &pb.GameState{
			IsGameOver:     true,
			GameOverReason: gameOverReason,
			GameId:         int32(gameId),
		})
	}
	log.Printf("deleting game %d", gameId)

	_, delErr := gm.store.DeleteGameState(context.Background(), int32(gameId))
	if delErr != nil {
		log.Printf("error deleting game: %v", delErr)
		return delErr
	}

	gm.Mu.Lock()
	delete(gm.GameStreams, gameId)
	gm.Mu.Unlock()

	return nil
}

func (gm *GameManager) GetNextPlayer(gameId int, clockwise bool) (uuid.UUID, string, error) {
	game, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("game does not exist")
		return uuid.UUID{}, "", fmt.Errorf("game does not exist")
	}

	dbGame, getErr := gm.store.GetGameStateById(context.Background(), int32(gameId))
	if getErr != nil {
		log.Printf("error getting game: %v", getErr)
		return uuid.UUID{}, "", getErr
	}

	positionOfCurrentPlayer := -1
	for i, user := range game.UserStreams {
		if user.UserId == dbGame.CurrentPlayerID {
			positionOfCurrentPlayer = i
			break
		}
	}

	if positionOfCurrentPlayer == -1 {
		log.Printf("current player not found")
		return uuid.UUID{}, "", fmt.Errorf("current player not found")
	}

	if clockwise {
		positionOfCurrentPlayer++
	} else {
		positionOfCurrentPlayer--
	}

	if positionOfCurrentPlayer < 0 {
		positionOfCurrentPlayer = len(game.UserStreams) - 1
	} else if positionOfCurrentPlayer >= len(game.UserStreams) {
		positionOfCurrentPlayer = 0
	}

	game.Mu.RLock()
	if game.UserStreams[positionOfCurrentPlayer].UserId == dbGame.StackID {
		game.Mu.RUnlock()
		return gm.GetNextPlayer(gameId, clockwise)
	}

	uuid := game.UserStreams[positionOfCurrentPlayer].UserId
	game.Mu.RUnlock()

	user, getErr := gm.store.GetUserByUUID(context.Background(), uuid)
	if getErr != nil {
		log.Printf("error getting user: %v", getErr)
		return uuid, "", getErr
	}

	return uuid, user.Username, nil
}

func (gm *GameManager) SendFirstGameStateIfAllPlayersAreReady(gameId int) error {
	allPlayersReady, readyErr := gm.HasEveryoneJoined(gameId)
	if readyErr != nil {
		log.Printf("error checking if everyone is ready: %v", readyErr)
		return readyErr
	}

	if allPlayersReady {
		dbGame, getErr := gm.store.GetGameStateById(context.Background(), int32(gameId))
		if getErr != nil {
			log.Printf("error getting game: %v", getErr)
			return getErr
		}

		var direction pb.Direction
		if dbGame.IsClockwise {
			direction = pb.Direction_CLOCKWISE
		} else {
			direction = pb.Direction_COUNTER_CLOCKWISE
		}

		nextPlayerUuid, nextPlayerName, nextPlayerErr := gm.GetNextPlayer(gameId, dbGame.IsClockwise)
		if nextPlayerErr != nil {
			log.Printf("error getting next player: %v", nextPlayerErr)
			return nextPlayerErr
		}

		drawStack, drawErr := gm.store.GetGameDrawStack(context.Background(), int64(gameId))
		if drawErr != nil && drawErr != sql.ErrNoRows {
			log.Printf("error getting draw stack: %v", drawErr)
			return drawErr
		}
		drawStackIds := make([]string, len(drawStack))
		for i, card := range drawStack {
			drawStackIds[i] = card.CardID
		}

		//Send data to stackStream
		game, exists := gm.GetGame(gameId)
		if !exists {
			log.Printf("game does not exist")
			return fmt.Errorf("game does not exist")
		}

		if game.StackStream != nil {
			sendErr := game.StackStream.Send(&pb.StackState{
				PlaceStack: &pb.PlaceStackState{
					AmountCards: 0,
					CardIdOnTop: "",
				},
				DrawStack: &pb.DrawStackState{
					StackId: int32(gameId),
					CardIds: drawStackIds,
				},
				Direction: direction,
			})
			if sendErr != nil {
				log.Printf("error sending card on top of stack to game %d: %v", gameId, sendErr)
				return sendErr
			}
		}

		//Send
		err := gm.UpdateGameState(gameId, &pb.GameState{
			CardOnTopOfDiscard: "",
			CurrentPlayerUuid:  nextPlayerUuid.String(),
			CurrentPlayerName:  nextPlayerName,
			Direction:          direction,
			GameId:             int32(gameId),
			AllPlayersReady:    allPlayersReady,
			IsGameOver:         false,
		})
		if err != nil {
			log.Printf("error updating game state: %v", err)
			return err[0]
		}
		return nil
	}
	return nil
}
