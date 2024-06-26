package api

import (
	"context"
	"database/sql"
	"log"
	"time"

	db "github.com/duo/db/sqlc"
	"github.com/duo/pb"
	"github.com/duo/util"
	"github.com/google/uuid"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/timestamppb"
)

func (server *Server) Register(ctx context.Context, req *pb.RegisterRequest) (*pb.RegisterResponse, error) {
	dbUser, createErr := server.Store.CreateUser(ctx, db.CreateUserParams{
		Username:  req.Username,
		PublicKey: req.PublicKey,
	})
	if createErr != nil {
		log.Printf("[Register] Error creating user: %s", createErr)
		return nil, status.Errorf(codes.Internal, "An error occurred while creating the user")
	}

	accessToken, _, tokenErr := server.Maker.CreateToken(dbUser.Uuid, dbUser.Username, server.Config.AccessTokenDuration)
	if tokenErr != nil {
		log.Printf("[Register] Error creating token: %s", tokenErr)
		return nil, status.Errorf(codes.Internal, "An error occurred while creating the access token")
	}

	return &pb.RegisterResponse{
		Uuid:      dbUser.Uuid.String(),
		AuthToken: accessToken,
	}, nil
}

func (server *Server) RequestLoginChallenge(ctx context.Context, req *pb.LoginRequest) (*pb.LoginChallengeRequest, error) {
	actualUUID, uuidErr := uuid.Parse(req.Uuid)
	if uuidErr != nil {
		log.Printf("[Request Login Challenge] Error parsing UUID: %s", uuidErr)
		return nil, status.Errorf(codes.InvalidArgument, "Invalid UUID")
	}

	dbUser, getErr := server.Store.GetUserByUUID(ctx, actualUUID)
	if getErr != nil {
		log.Printf("[Request Login Challenge] Error getting user by uuid: %s", getErr)
		if getErr == sql.ErrNoRows {
			return nil, status.Errorf(codes.NotFound, "User not found")
		}
		return nil, status.Errorf(codes.Internal, "An error occurred while getting the user from the db")
	}
	plainChallenge, encryptedChallenge, encryptErr := util.CreateLoginChallenge(dbUser.PublicKey)
	//TODO delete
	log.Printf("Created Challenge Plain: %s", plainChallenge)
	log.Printf("Created Challenge Encrypted: %s", encryptedChallenge)

	if encryptErr != nil {
		log.Printf("[Request Login Challenge] Error creating login challenge: %s", encryptErr)
		return nil, status.Errorf(codes.Internal, "An error occurred while creating the login challenge")
	}

	_, createErr := server.Store.CreateUserLogin(ctx, db.CreateUserLoginParams{
		UserUuid:  actualUUID,
		Challenge: plainChallenge,
	})
	if createErr != nil {
		log.Printf("[Request Login Challenge] Error creating user login: %s", createErr)
		return nil, status.Errorf(codes.Internal, "An error occurred while creating the user login")
	}

	return &pb.LoginChallengeRequest{
		Challenge: encryptedChallenge,
	}, nil
}

func (server *Server) SubmitLoginChallenge(ctx context.Context, req *pb.LoginChallengeResponse) (*pb.LoginResponse, error) {
	actualUUID, uuidErr := uuid.Parse(req.Uuid)
	if uuidErr != nil {
		log.Printf("[Submit Login Challenge] Error parsing UUID: %s", uuidErr)
		return nil, status.Errorf(codes.InvalidArgument, "Invalid UUID")
	}

	dbUserLogin, getErr := server.Store.DeleteUserLoginByUUID(ctx, actualUUID)
	if getErr != nil {
		log.Printf("[Submit Login Challenge] Error getting user login: %s", getErr)
		if getErr == sql.ErrNoRows {
			return nil, status.Errorf(codes.NotFound, "User login not found")
		}
		return nil, status.Errorf(codes.Internal, "An error occurred while getting the user login from the db")
	}

	dbUser, getErr := server.Store.GetUserByUUID(ctx, actualUUID)
	if getErr != nil {
		log.Printf("[Submit Login Challenge] Error getting user by uuid: %s", getErr)
		if getErr == sql.ErrNoRows {
			return nil, status.Errorf(codes.NotFound, "User not found")
		}
		return nil, status.Errorf(codes.Internal, "An error occurred while getting the user from the db")
	}

	if dbUserLogin.Challenge != req.DecryptedChallenge {
		log.Printf("[Submit Login Challenge] Challenge mismatch: %s != %s", dbUserLogin.Challenge, req.DecryptedChallenge)
		return nil, status.Errorf(codes.PermissionDenied, "Invalid challenge")
	}

	accessToken, _, tokenErr := server.Maker.CreateToken(dbUser.Uuid, dbUser.Username, server.Config.AccessTokenDuration)
	if tokenErr != nil {
		log.Printf("[Submit Login Challenge] Error creating token: %s", tokenErr)
		return nil, status.Errorf(codes.Internal, "An error occurred while creating the access token")
	}

	return &pb.LoginResponse{
		Token: accessToken,
		ExpiresAt: &timestamppb.Timestamp{
			Seconds: time.Now().Unix() + int64(server.Config.AccessTokenDuration.Seconds()),
		},
	}, nil
}
