package api

import (
	"context"
	"database/sql"
	"fmt"
	"io"
	"log"
	"math/rand"
	"sync"

	db "github.com/duo/db/sqlc"
	"github.com/duo/pb"
	"github.com/google/uuid"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

var duoCards []string = []string{
	"red_1",
	"red_1",
	"red_2",
	"red_2",
	"red_3",
	"red_3",
	"red_4",
	"red_4",
	"red_5",
	"red_5",
	"red_6",
	"red_6",
	"red_7",
	"red_7",
	"red_8",
	"red_8",
	"red_9",
	"red_9",
	"green_1",
	"green_1",
	"green_2",
	"green_2",
	"green_3",
	"green_3",
	"green_4",
	"green_4",
	"green_5",
	"green_5",
	"green_6",
	"green_6",
	"green_7",
	"green_7",
	"green_8",
	"green_8",
	"green_9",
	"green_9",
	"purple_1",
	"purple_1",
	"purple_2",
	"purple_2",
	"purple_3",
	"purple_3",
	"purple_4",
	"purple_4",
	"purple_5",
	"purple_5",
	"purple_6",
	"purple_6",
	"purple_7",
	"purple_7",
	"purple_8",
	"purple_8",
	"purple_9",
	"purple_9",
	"yellow_1",
	"yellow_1",
	"yellow_2",
	"yellow_2",
	"yellow_3",
	"yellow_3",
	"yellow_4",
	"yellow_4",
	"yellow_5",
	"yellow_5",
	"yellow_6",
	"yellow_6",
	"yellow_7",
	"yellow_7",
	"yellow_8",
	"yellow_8",
	"yellow_9",
	"yellow_9",
	"draw_4",
	"draw_4",
	"draw_4",
	"draw_4",
	"green_change_directions",
	"green_change_directions",
	"green_draw_2",
	"green_draw_2",
	"green_suspend",
	"green_suspend",
	"purple_change_directions",
	"purple_change_directions",
	"purple_draw_2",
	"purple_draw_2",
	"purple_suspend",
	"purple_suspend",
	"red_change_directions",
	"red_change_directions",
	"red_draw_2",
	"red_draw_2",
	"red_suspend",
	"red_suspend",
	"yellow_change_directions",
	"yellow_change_directions",
	"yellow_draw_2",
	"yellow_draw_2",
	"yellow_suspend",
	"yellow_suspend",
	"select_color",
	"select_color",
	"select_color",
	"select_color",
}

type GameUserStreams struct {
	PlayersCards    []string
	GameStateStream pb.DUOService_GetGameStateServer
	PlayerStream    pb.DUOService_GetPlayerStreamServer
	UserId          uuid.UUID
}

func NewGameUserStream(userId uuid.UUID) *GameUserStreams {
	return &GameUserStreams{
		PlayersCards: []string{},
		UserId:       userId,
	}
}

type Game struct {
	StackStream         pb.DUOService_GetStackStreamServer
	CardsOnDrawStack    []string //last card is on top
	CardsOnPlaceStack   []string //last card is on top
	UserStreams         []GameUserStreams
	WaitingForDrawCount int32
	Mu                  sync.RWMutex
}

func NewGame(cardIds []string) *Game {
	return &Game{
		CardsOnDrawStack:    cardIds,
		UserStreams:         []GameUserStreams{},
		StackStream:         nil,
		WaitingForDrawCount: 0,
		Mu:                  sync.RWMutex{},
	}
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
	gm.GameStreams[int(dbGame.ID)] = NewGame(duoCards) //TODO make dynamic
	gm.Mu.Unlock()

	shuffleErr := gm.shuffleDrawStack(int(dbGame.ID), true)
	if shuffleErr != nil {
		log.Printf("error shuffling place stack: %v", shuffleErr)
		return 0, shuffleErr
	}

	topCardFromDrawStack, drawErr := gm.DrawCardsFromStack(int(dbGame.ID), 1)
	if drawErr != nil {
		log.Printf("error drawing card from stack: %v", drawErr)
		return 0, drawErr
	}

	game, exists := gm.GetGame(int(dbGame.ID))
	if !exists {
		log.Printf("game does not exist")
		return 0, fmt.Errorf("game does not exist")
	}

	game.Mu.Lock()
	game.CardsOnPlaceStack = append(game.CardsOnPlaceStack, topCardFromDrawStack[0])
	game.Mu.Unlock()

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

	game.Mu.RLock()
	if isCardOnTopOfStack {
		//Send data to stackStream
		if game.StackStream != nil {
			sendErr := game.StackStream.Send(&pb.StackState{
				PlaceStack: &pb.PlaceStackState{
					AmountCards: int32(len(game.CardsOnPlaceStack)),
					CardIdOnTop: state.CardOnTopOfDiscard,
				},
				DrawStack: &pb.DrawStackState{
					StackId: int32(gameId),
					CardIds: game.CardsOnDrawStack,
				},
				Direction: state.Direction,
			})
			if sendErr != nil {
				log.Printf("error sending card on top of stack to game %d: %v", gameId, sendErr)
				return []error{sendErr}
			}
		}
	}
	game.Mu.RUnlock()

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

func (gm *GameManager) onStackDisconnected(gameId int) error {
	log.Printf("stack stream of game: %d disconnected", gameId)
	return gm.DeleteGame(gameId, true, "stack stream disconnected")
}

func (gm *GameManager) SetStackStream(gameId int, userId uuid.UUID, stream pb.DUOService_GetStackStreamServer) error {
	game, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("[stack stream] game does not exist")
		return fmt.Errorf("game does not exist")
	}

	log.Printf("[stack stream] setting stack stream of game: %d", gameId)

	//Stack stream mustn't be set
	if game.StackStream != nil {
		log.Printf("[stack stream] stack stream already set")
		return fmt.Errorf("stack stream already set")
	}

	dbGame, getErr := gm.store.GetGameStateById(context.Background(), int32(gameId))
	if getErr != nil {
		log.Printf("[stack stream] error getting game: %v", getErr)
		return getErr
	}

	if dbGame.StackID != userId {
		log.Printf("[stack stream] user %v is not the stack owner", userId)
		return fmt.Errorf("user %v is not the stack owner", userId)
	}

	game.Mu.Lock()
	game.StackStream = stream
	game.Mu.Unlock()

	sendErr := gm.SendFirstGameStateIfAllPlayersAreReady(gameId)
	if sendErr != nil {
		log.Printf("[stack stream] error sending first game state: %v", sendErr)
		return sendErr
	}

	log.Printf(" [stack stream]stack stream of game: %d connected", gameId)

	for {
		select {
		case <-stream.Context().Done():
			return gm.onStackDisconnected(gameId)
		default: // Add default case for non-blocking Recv()
			if stream == nil {
				return status.Errorf(codes.Internal, "Stream not initialized")
			}
			msg, err := stream.Recv()
			if err != nil {
				if msg.GameId != int32(gameId) {
					return status.Errorf(codes.InvalidArgument, "Wrong gameId")
				}
				if err == io.EOF {
					return gm.onStackDisconnected(gameId)
				} else if status.Code(err) == codes.Canceled { // Check for context cancellation
					log.Printf("[stack stream] Context canceled for stack: %v", userId)
					err := gm.onStackDisconnected(gameId)
					return err // Or handle it differently as needed
				}
				log.Printf("[stack stream] Error receiving message from stack %v: %v", userId, err)
				err := gm.onStackDisconnected(gameId)
				return err
			}

			log.Printf("[stack stream] Received message from stack %v: %v", userId, msg)
			if !msg.DrawingCard {
				//INIT MESSAGE
				game.Mu.Lock()
				sendErr := game.StackStream.Send(&pb.StackState{
					PlaceStack: &pb.PlaceStackState{
						AmountCards: int32(len(game.CardsOnPlaceStack)),
						CardIdOnTop: game.CardsOnPlaceStack[len(game.CardsOnPlaceStack)-1],
					},
					DrawStack: &pb.DrawStackState{
						StackId: int32(gameId),
						CardIds: game.CardsOnDrawStack,
					},
				})
				if sendErr != nil {
					log.Printf("[stack stream] error sending init message to stack %v: %v", userId, sendErr)
					game.Mu.Unlock()
					return sendErr
				}
				game.Mu.Unlock()
			} else {
				//CARD DRAW MESSAGE
				//TODO
			}
		}
	}
}

func (gm *GameManager) AddGameStateStream(gameId int, userId uuid.UUID, stream pb.DUOService_GetGameStateServer) error {
	game, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("[GameState stream] game does not exist")
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
			log.Printf("[GameState stream] game state stream already set")
			game.Mu.Unlock()
			return fmt.Errorf("[GameState stream] game state stream already set")
		}
		game.UserStreams[index].GameStateStream = stream
	}
	game.Mu.Unlock()

	sendErr := gm.SendFirstGameStateIfAllPlayersAreReady(gameId)
	if sendErr != nil {
		log.Printf("[GameState stream] error sending first game state: %v", sendErr)
		return sendErr
	}

	log.Printf("[GameState stream] game state stream of game: %d connected", gameId)

	<-stream.Context().Done()

	log.Printf("[GameState stream] game state stream of game: %d disconnected", gameId)

	gm.RemovePlayerFromGame(gameId, userId)

	return nil
}

func (gm *GameManager) AddPlayerStream(gameId int, userId uuid.UUID, stream pb.DUOService_GetPlayerStreamServer) error {
	game, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("[Player stream] game does not exist")
		return fmt.Errorf("game does not exist")
	}

	log.Printf("[Player stream] setting player stream of game: %d", gameId)

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
			log.Printf("[Player stream] player stream already set")
			game.Mu.Unlock()
			return fmt.Errorf("[Player stream] player stream already set")
		}
		game.UserStreams[index].PlayerStream = stream
	}
	game.Mu.Unlock()

	playersCards, getErr := gm.DrawCardsFromStack(gameId, 7) //TODO: make dynamic
	if getErr != nil {
		log.Printf("[Player stream] error drawing cards: %v", getErr)
		return getErr
	}

	updateErr := gm.UpdatePlayersCards(gameId, userId.String(), playersCards)
	if updateErr != nil {
		log.Printf("[Player stream] error updating players cards: %v", updateErr)
		return updateErr
	}

	sendErr := gm.SendFirstGameStateIfAllPlayersAreReady(gameId)
	if sendErr != nil {
		log.Printf("[Player stream] error sending first game state: %v", sendErr)
		return sendErr
	}

	log.Printf("[Player stream] player stream of game: %d connected", gameId)

	//Listen for player stream disconnect or messages
	for {
		recvMsg, recvErr := stream.Recv()
		if recvErr != nil {
			log.Printf("[Player stream] error receiving player stream: %v", recvErr)
			break
		}

		dbGame, getErr := gm.store.GetGameStateById(context.Background(), int32(gameId))
		if getErr != nil {
			log.Printf("[Player stream] error getting game: %v", getErr)
		}

		var direction pb.Direction
		if dbGame.IsClockwise {
			direction = pb.Direction_CLOCKWISE
		} else {
			direction = pb.Direction_COUNTER_CLOCKWISE
		}

		nextPlayerUuid, nextPlayerName, nextPlayerErr := gm.GetNextPlayer(gameId, dbGame.IsClockwise)
		if nextPlayerErr != nil {
			log.Printf("[Player stream] error getting next player: %v", nextPlayerErr)
		}

		allPlayersReady, readyErr := gm.HasEveryoneJoined(gameId)
		if readyErr != nil {
			log.Printf("[Player stream] error checking if everyone is ready: %v", readyErr)
		}

		if !allPlayersReady {
			log.Printf("[Player stream] not all players are ready")
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
				log.Printf("[Player stream] error placing card: %v", placeErr)
				break
			}
		}

	}

	log.Printf("[Player stream] player stream of game: %d disconnected", gameId)

	removeErr := gm.RemovePlayerFromGame(gameId, userId)
	if removeErr != nil {
		log.Printf("[Player stream] error removing player from game: %v", removeErr)
		return removeErr
	}

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

	//TODO db

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

	log.Printf("game %d deleted", gameId)

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

		//Send data to stackStream
		game, exists := gm.GetGame(gameId)
		if !exists {
			log.Printf("game does not exist")
			return fmt.Errorf("game does not exist")
		}
		game.Mu.RLock()
		if game.StackStream != nil {

			sendErr := game.StackStream.Send(&pb.StackState{
				PlaceStack: &pb.PlaceStackState{
					AmountCards: int32(len(game.CardsOnPlaceStack)),
					CardIdOnTop: game.CardsOnPlaceStack[len(game.CardsOnPlaceStack)-1],
				},
				DrawStack: &pb.DrawStackState{
					StackId: int32(gameId),
					CardIds: game.CardsOnDrawStack,
				},
				Direction: direction,
			})
			if sendErr != nil {
				log.Printf("error sending card on top of stack to game %d: %v", gameId, sendErr)
				return sendErr
			}
		}
		game.Mu.RUnlock()

		//Send
		err := gm.UpdateGameState(gameId, &pb.GameState{
			CardOnTopOfDiscard: game.CardsOnPlaceStack[len(game.CardsOnPlaceStack)-1],
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

func (gm *GameManager) UpdatePlayersCards(gameId int, userId string, cards []string) error {
	game, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("game does not exist")
		return fmt.Errorf("game does not exist")
	}

	game.Mu.Lock()
	for _, user := range game.UserStreams {
		if user.UserId.String() == userId {
			if user.PlayerStream != nil {
				user.PlayersCards = cards
				sendErr := user.PlayerStream.Send(&pb.PlayerState{
					Hand:  cards,
					Alert: &pb.Alert{},
				})
				if sendErr != nil {
					log.Printf("error sending player state to user %v: %v", userId, sendErr)
					game.Mu.RUnlock()
					return sendErr
				}
			}
		}
	}
	game.Mu.Unlock()

	return nil
}

func (gm *GameManager) DrawCardsFromStack(gameId int, amount int32) ([]string, error) {
	game, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("game does not exist")
		return []string{}, fmt.Errorf("game does not exist")
	}

	if len(game.CardsOnDrawStack) < int(amount) {
		shuffleErr := gm.shufflePlaceStackInDrawStack(gameId)
		if shuffleErr != nil {
			log.Printf("error shuffling place stack in draw stack: %v", shuffleErr)
			return []string{}, shuffleErr
		}
	}

	game.Mu.Lock()
	drawnCards := game.CardsOnDrawStack[len(game.CardsOnDrawStack)-int(amount):]
	game.CardsOnDrawStack = game.CardsOnDrawStack[:len(game.CardsOnDrawStack)-int(amount)]
	game.Mu.Unlock()

	return drawnCards, nil

}

func (gm *GameManager) shuffleDrawStack(gameId int, shuffleTopCardToo bool) error {
	game, exists := gm.GetGame(gameId)
	if !exists {
		log.Printf("game does not exist")
		return fmt.Errorf("game does not exist")
	}

	var length int
	if shuffleTopCardToo {
		length = len(game.CardsOnDrawStack)
	} else {
		length = len(game.CardsOnDrawStack) - 1
	}

	game.Mu.Lock()
	for i := 0; i < length; i++ {
		j := rand.Intn(length)
		game.CardsOnDrawStack[i], game.CardsOnDrawStack[j] = game.CardsOnDrawStack[j], game.CardsOnDrawStack[i]
	}
	game.Mu.Unlock()

	return nil

}

func (gm *GameManager) shufflePlaceStackInDrawStack(gameId int) error {
	game, exists := gm.GetGame(int(gameId))
	if !exists {
		log.Printf("game does not exist")
		return fmt.Errorf("game does not exist")
	}

	game.Mu.Lock()
	for i := 0; i < len(game.CardsOnPlaceStack)-1; i++ {
		j := rand.Intn(len(game.CardsOnPlaceStack) - 1)
		game.CardsOnPlaceStack[i], game.CardsOnPlaceStack[j] = game.CardsOnPlaceStack[j], game.CardsOnPlaceStack[i]
		game.CardsOnDrawStack = append(game.CardsOnDrawStack, game.CardsOnPlaceStack[i])
		game.CardsOnPlaceStack = []string{game.CardsOnPlaceStack[len(game.CardsOnPlaceStack)-1]}
	}
	game.Mu.Unlock()

	return nil
}
