package api

import (
	"context"
	"database/sql"
	"log"

	db "github.com/duo/db/sqlc"
	"github.com/duo/pb"
	"github.com/google/uuid"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func toFriendState(dbState db.Userstatus) pb.FriendState {
	switch dbState {
	case db.UserstatusOnline:
		return pb.FriendState_online
	case db.UserstatusOffline:
		return pb.FriendState_offline
	case db.UserstatusInGame:
		return pb.FriendState_inGame
	case db.UserstatusInLobby:
		return pb.FriendState_inLobby
	default:
		return pb.FriendState_offline
	}
}

func toUserState(friendState pb.FriendState) db.Userstatus {
	switch friendState {
	case pb.FriendState_online:
		return db.UserstatusOnline
	case pb.FriendState_offline:
		return db.UserstatusOffline
	case pb.FriendState_inGame:
		return db.UserstatusInGame
	case pb.FriendState_inLobby:
		return db.UserstatusInLobby
	default:
		return db.UserstatusOffline
	}
}

func (server *Server) SendFriendRequest(context context.Context, req *pb.FriendRequestRequest) (*pb.Void, error) {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		log.Printf("error verifying token: %v", tokenErr)
		return nil, status.Errorf(codes.Unauthenticated, "invalid token")
	}

	targetUuid, uuidErr := uuid.Parse(req.TargetId)
	if uuidErr != nil {
		log.Printf("error parsing target id: %v", uuidErr)
		return nil, status.Errorf(codes.InvalidArgument, "invalid target id")
	}

	_, dbErr := server.Store.AddFriendRequest(context, db.AddFriendRequestParams{
		RequesterID: payload.UserID,
		RequesteeID: targetUuid,
	})

	if dbErr != nil {
		log.Printf("error adding friend request: %v", dbErr)
		return nil, status.Errorf(codes.Internal, "error adding friend request to db")
	}

	return &pb.Void{}, nil
}

func (server *Server) SendFriendRequestResponse(context context.Context, req *pb.FriendRequestResponse) (*pb.Void, error) {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		log.Printf("error verifying token: %v", tokenErr)
		return nil, status.Errorf(codes.Unauthenticated, "invalid token")
	}

	requesterUuid, uuidErr := uuid.Parse(req.RequesterId)
	if uuidErr != nil {
		log.Printf("error parsing target id: %v", uuidErr)
		return nil, status.Errorf(codes.InvalidArgument, "invalid target id")
	}

	if req.Accept {
		//accepted
		_, addFriendErr := server.Store.AddFriendship(context, db.AddFriendshipParams{
			Column1: requesterUuid,
			Column2: payload.UserID,
		})
		if addFriendErr != nil {
			log.Printf("error adding friendship: %v", addFriendErr)
			return nil, status.Errorf(codes.Internal, "error adding friendship to db")
		}
		_, delFriendRequestErr := server.Store.DeleteFriendRequest(context, db.DeleteFriendRequestParams{
			RequesterID: requesterUuid,
			RequesteeID: payload.UserID,
		})
		if delFriendRequestErr != nil {
			log.Printf("error deleting friend request: %v", delFriendRequestErr)
			return nil, status.Errorf(codes.Internal, "error deleting friend request from db")
		}
	} else {
		//blocked
		_, delFriendRequestErr := server.Store.DeleteFriendRequest(context, db.DeleteFriendRequestParams{
			RequesterID: requesterUuid,
			RequesteeID: payload.UserID,
		})
		if delFriendRequestErr != nil {
			log.Printf("error deleting friend request: %v", delFriendRequestErr)
			return nil, status.Errorf(codes.Internal, "error deleting friend request from db")
		}
	}

	return &pb.Void{}, nil
}

func (server *Server) GetFriendRequests(context context.Context, req *pb.TokenOnlyRequest) (*pb.FriendRequestList, error) {

	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		log.Printf("error verifying token: %v", tokenErr)
		return nil, status.Errorf(codes.Unauthenticated, "invalid token")
	}

	requests, dbErr := server.Store.GetOpenFriendRequestByRequesteeId(context, payload.UserID)
	if dbErr != nil {
		if dbErr == sql.ErrNoRows {
			return &pb.FriendRequestList{}, nil
		}
		log.Printf("error getting friend requests: %v", dbErr)
		return nil, status.Errorf(codes.Internal, "error getting friend requests")
	}

	friendRequests := make([]*pb.FriendRequest, len(requests))
	for i, request := range requests {
		//get requester name
		reqUser, getErr := server.Store.GetUserByUUID(context, request.RequesterID)
		if getErr != nil {
			log.Printf("error getting requester: %v", getErr)
			return nil, status.Errorf(codes.Internal, "error getting requester")
		}
		friendRequests[i] = &pb.FriendRequest{
			RequesterUuid: request.RequesterID.String(),
			TargetUuid:    request.RequesteeID.String(),
			RequesterName: reqUser.Username,
		}
	}
	return &pb.FriendRequestList{
		Requests: friendRequests,
	}, nil
}

func (server *Server) GetFriendList(context context.Context, req *pb.TokenOnlyRequest) (*pb.FriendList, error) {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		log.Printf("error verifying token: %v", tokenErr)
		return nil, status.Errorf(codes.Unauthenticated, "invalid token")
	}

	friends, dbErr := server.Store.GetFriendsByUserId(context, payload.UserID)
	if dbErr != nil {
		if dbErr == sql.ErrNoRows {
			return &pb.FriendList{}, nil
		}
		log.Printf("error getting friends: %v", dbErr)
		return nil, status.Errorf(codes.Internal, "error getting friends")
	}

	friendList := make([]*pb.Friend, len(friends))
	for i, friend := range friends {

		friendUuid := friend.User1ID
		if friend.User1ID == payload.UserID {
			friendUuid = friend.User2ID
		}
		friendList[i] = &pb.Friend{
			Uuid:  friendUuid.String(),
			Name:  friend.Username,
			Score: friend.Score,
			State: toFriendState(friend.UserStatus),
		}
	}

	return &pb.FriendList{
		Friends: friendList,
	}, nil
}

func (server *Server) DeleteFriend(context context.Context, req *pb.DeleteFriendRequest) (*pb.Void, error) {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		log.Printf("error verifying token: %v", tokenErr)
		return nil, status.Errorf(codes.Unauthenticated, "invalid token")
	}

	_, delErr := server.Store.DeleteFriendship(context, db.DeleteFriendshipParams{
		Column1: payload.UserID,
		Column2: req.TargetId,
	})

	if delErr != nil {
		log.Printf("error deleting friendship %v", delErr)
		return nil, status.Errorf(codes.Internal, "error deleting token")
	}

	return &pb.Void{}, nil
}
