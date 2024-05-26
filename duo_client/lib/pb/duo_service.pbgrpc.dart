//
//  Generated code. Do not modify.
//  source: duo_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'auth_messages.pb.dart' as $0;
import 'friend.pb.dart' as $1;
import 'game.pb.dart' as $3;
import 'lobby.pb.dart' as $5;
import 'user_state.pb.dart' as $4;
import 'void.pb.dart' as $2;

export 'duo_service.pb.dart';

@$pb.GrpcServiceName('pb.DUOService')
class DUOServiceClient extends $grpc.Client {
  static final _$register = $grpc.ClientMethod<$0.RegisterRequest, $0.RegisterResponse>(
      '/pb.DUOService/Register',
      ($0.RegisterRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RegisterResponse.fromBuffer(value));
  static final _$requestLoginChallenge = $grpc.ClientMethod<$0.LoginRequest, $0.LoginChallengeRequest>(
      '/pb.DUOService/RequestLoginChallenge',
      ($0.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LoginChallengeRequest.fromBuffer(value));
  static final _$submitLoginChallenge = $grpc.ClientMethod<$0.LoginChallengeResponse, $0.LoginResponse>(
      '/pb.DUOService/SubmitLoginChallenge',
      ($0.LoginChallengeResponse value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LoginResponse.fromBuffer(value));
  static final _$sendFriendRequest = $grpc.ClientMethod<$1.FriendRequestRequest, $2.void_>(
      '/pb.DUOService/SendFriendRequest',
      ($1.FriendRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.void_.fromBuffer(value));
  static final _$sendFriendRequestResponse = $grpc.ClientMethod<$1.FriendRequestResponse, $2.void_>(
      '/pb.DUOService/SendFriendRequestResponse',
      ($1.FriendRequestResponse value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.void_.fromBuffer(value));
  static final _$getFriendRequests = $grpc.ClientMethod<$3.TokenOnlyRequest, $1.FriendRequestList>(
      '/pb.DUOService/GetFriendRequests',
      ($3.TokenOnlyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.FriendRequestList.fromBuffer(value));
  static final _$getFriendList = $grpc.ClientMethod<$3.TokenOnlyRequest, $1.FriendList>(
      '/pb.DUOService/GetFriendList',
      ($3.TokenOnlyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.FriendList.fromBuffer(value));
  static final _$deleteFriend = $grpc.ClientMethod<$1.DeleteFriendRequest, $2.void_>(
      '/pb.DUOService/DeleteFriend',
      ($1.DeleteFriendRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.void_.fromBuffer(value));
  static final _$statusChangeStream = $grpc.ClientMethod<$4.StatusChangeRequest, $2.void_>(
      '/pb.DUOService/StatusChangeStream',
      ($4.StatusChangeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.void_.fromBuffer(value));
  static final _$createLobby = $grpc.ClientMethod<$5.CreateLobbyRequest, $5.LobbyStatus>(
      '/pb.DUOService/CreateLobby',
      ($5.CreateLobbyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.LobbyStatus.fromBuffer(value));
  static final _$changeStackDevice = $grpc.ClientMethod<$5.ChangeStackDeviceRequest, $2.void_>(
      '/pb.DUOService/ChangeStackDevice',
      ($5.ChangeStackDeviceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.void_.fromBuffer(value));
  static final _$joinLobby = $grpc.ClientMethod<$5.JoinLobbyRequest, $5.LobbyStatus>(
      '/pb.DUOService/JoinLobby',
      ($5.JoinLobbyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.LobbyStatus.fromBuffer(value));
  static final _$disconnectLobby = $grpc.ClientMethod<$5.DisconnectLobbyRequest, $5.DisconnectLobbyResponse>(
      '/pb.DUOService/DisconnectLobby',
      ($5.DisconnectLobbyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.DisconnectLobbyResponse.fromBuffer(value));
  static final _$startGame = $grpc.ClientMethod<$3.TokenOnlyRequest, $2.void_>(
      '/pb.DUOService/StartGame',
      ($3.TokenOnlyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.void_.fromBuffer(value));
  static final _$getGameState = $grpc.ClientMethod<$3.GetGameStateRequest, $3.GameState>(
      '/pb.DUOService/GetGameState',
      ($3.GetGameStateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GameState.fromBuffer(value));
  static final _$getPlayerStream = $grpc.ClientMethod<$3.PlayerAction, $3.PlayerState>(
      '/pb.DUOService/GetPlayerStream',
      ($3.PlayerAction value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.PlayerState.fromBuffer(value));
  static final _$getStackStream = $grpc.ClientMethod<$3.StackRequest, $3.StackState>(
      '/pb.DUOService/GetStackStream',
      ($3.StackRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.StackState.fromBuffer(value));

  DUOServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.RegisterResponse> register($0.RegisterRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$0.LoginChallengeRequest> requestLoginChallenge($0.LoginRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestLoginChallenge, request, options: options);
  }

  $grpc.ResponseFuture<$0.LoginResponse> submitLoginChallenge($0.LoginChallengeResponse request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitLoginChallenge, request, options: options);
  }

  $grpc.ResponseFuture<$2.void_> sendFriendRequest($1.FriendRequestRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendFriendRequest, request, options: options);
  }

  $grpc.ResponseFuture<$2.void_> sendFriendRequestResponse($1.FriendRequestResponse request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendFriendRequestResponse, request, options: options);
  }

  $grpc.ResponseFuture<$1.FriendRequestList> getFriendRequests($3.TokenOnlyRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFriendRequests, request, options: options);
  }

  $grpc.ResponseFuture<$1.FriendList> getFriendList($3.TokenOnlyRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFriendList, request, options: options);
  }

  $grpc.ResponseFuture<$2.void_> deleteFriend($1.DeleteFriendRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteFriend, request, options: options);
  }

  $grpc.ResponseStream<$2.void_> statusChangeStream($async.Stream<$4.StatusChangeRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$statusChangeStream, request, options: options);
  }

  $grpc.ResponseStream<$5.LobbyStatus> createLobby($5.CreateLobbyRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createLobby, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$2.void_> changeStackDevice($5.ChangeStackDeviceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$changeStackDevice, request, options: options);
  }

  $grpc.ResponseStream<$5.LobbyStatus> joinLobby($5.JoinLobbyRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$joinLobby, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$5.DisconnectLobbyResponse> disconnectLobby($5.DisconnectLobbyRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disconnectLobby, request, options: options);
  }

  $grpc.ResponseFuture<$2.void_> startGame($3.TokenOnlyRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startGame, request, options: options);
  }

  $grpc.ResponseStream<$3.GameState> getGameState($3.GetGameStateRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getGameState, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$3.PlayerState> getPlayerStream($async.Stream<$3.PlayerAction> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getPlayerStream, request, options: options);
  }

  $grpc.ResponseStream<$3.StackState> getStackStream($3.StackRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getStackStream, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('pb.DUOService')
abstract class DUOServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.DUOService';

  DUOServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RegisterRequest, $0.RegisterResponse>(
        'Register',
        register_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RegisterRequest.fromBuffer(value),
        ($0.RegisterResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LoginRequest, $0.LoginChallengeRequest>(
        'RequestLoginChallenge',
        requestLoginChallenge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LoginRequest.fromBuffer(value),
        ($0.LoginChallengeRequest value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LoginChallengeResponse, $0.LoginResponse>(
        'SubmitLoginChallenge',
        submitLoginChallenge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LoginChallengeResponse.fromBuffer(value),
        ($0.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.FriendRequestRequest, $2.void_>(
        'SendFriendRequest',
        sendFriendRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.FriendRequestRequest.fromBuffer(value),
        ($2.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.FriendRequestResponse, $2.void_>(
        'SendFriendRequestResponse',
        sendFriendRequestResponse_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.FriendRequestResponse.fromBuffer(value),
        ($2.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.TokenOnlyRequest, $1.FriendRequestList>(
        'GetFriendRequests',
        getFriendRequests_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.TokenOnlyRequest.fromBuffer(value),
        ($1.FriendRequestList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.TokenOnlyRequest, $1.FriendList>(
        'GetFriendList',
        getFriendList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.TokenOnlyRequest.fromBuffer(value),
        ($1.FriendList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteFriendRequest, $2.void_>(
        'DeleteFriend',
        deleteFriend_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.DeleteFriendRequest.fromBuffer(value),
        ($2.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.StatusChangeRequest, $2.void_>(
        'StatusChangeStream',
        statusChangeStream,
        true,
        true,
        ($core.List<$core.int> value) => $4.StatusChangeRequest.fromBuffer(value),
        ($2.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.CreateLobbyRequest, $5.LobbyStatus>(
        'CreateLobby',
        createLobby_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $5.CreateLobbyRequest.fromBuffer(value),
        ($5.LobbyStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.ChangeStackDeviceRequest, $2.void_>(
        'ChangeStackDevice',
        changeStackDevice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.ChangeStackDeviceRequest.fromBuffer(value),
        ($2.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.JoinLobbyRequest, $5.LobbyStatus>(
        'JoinLobby',
        joinLobby_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $5.JoinLobbyRequest.fromBuffer(value),
        ($5.LobbyStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.DisconnectLobbyRequest, $5.DisconnectLobbyResponse>(
        'DisconnectLobby',
        disconnectLobby_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.DisconnectLobbyRequest.fromBuffer(value),
        ($5.DisconnectLobbyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.TokenOnlyRequest, $2.void_>(
        'StartGame',
        startGame_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.TokenOnlyRequest.fromBuffer(value),
        ($2.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetGameStateRequest, $3.GameState>(
        'GetGameState',
        getGameState_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $3.GetGameStateRequest.fromBuffer(value),
        ($3.GameState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.PlayerAction, $3.PlayerState>(
        'GetPlayerStream',
        getPlayerStream,
        true,
        true,
        ($core.List<$core.int> value) => $3.PlayerAction.fromBuffer(value),
        ($3.PlayerState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.StackRequest, $3.StackState>(
        'GetStackStream',
        getStackStream_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $3.StackRequest.fromBuffer(value),
        ($3.StackState value) => value.writeToBuffer()));
  }

  $async.Future<$0.RegisterResponse> register_Pre($grpc.ServiceCall call, $async.Future<$0.RegisterRequest> request) async {
    return register(call, await request);
  }

  $async.Future<$0.LoginChallengeRequest> requestLoginChallenge_Pre($grpc.ServiceCall call, $async.Future<$0.LoginRequest> request) async {
    return requestLoginChallenge(call, await request);
  }

  $async.Future<$0.LoginResponse> submitLoginChallenge_Pre($grpc.ServiceCall call, $async.Future<$0.LoginChallengeResponse> request) async {
    return submitLoginChallenge(call, await request);
  }

  $async.Future<$2.void_> sendFriendRequest_Pre($grpc.ServiceCall call, $async.Future<$1.FriendRequestRequest> request) async {
    return sendFriendRequest(call, await request);
  }

  $async.Future<$2.void_> sendFriendRequestResponse_Pre($grpc.ServiceCall call, $async.Future<$1.FriendRequestResponse> request) async {
    return sendFriendRequestResponse(call, await request);
  }

  $async.Future<$1.FriendRequestList> getFriendRequests_Pre($grpc.ServiceCall call, $async.Future<$3.TokenOnlyRequest> request) async {
    return getFriendRequests(call, await request);
  }

  $async.Future<$1.FriendList> getFriendList_Pre($grpc.ServiceCall call, $async.Future<$3.TokenOnlyRequest> request) async {
    return getFriendList(call, await request);
  }

  $async.Future<$2.void_> deleteFriend_Pre($grpc.ServiceCall call, $async.Future<$1.DeleteFriendRequest> request) async {
    return deleteFriend(call, await request);
  }

  $async.Stream<$5.LobbyStatus> createLobby_Pre($grpc.ServiceCall call, $async.Future<$5.CreateLobbyRequest> request) async* {
    yield* createLobby(call, await request);
  }

  $async.Future<$2.void_> changeStackDevice_Pre($grpc.ServiceCall call, $async.Future<$5.ChangeStackDeviceRequest> request) async {
    return changeStackDevice(call, await request);
  }

  $async.Stream<$5.LobbyStatus> joinLobby_Pre($grpc.ServiceCall call, $async.Future<$5.JoinLobbyRequest> request) async* {
    yield* joinLobby(call, await request);
  }

  $async.Future<$5.DisconnectLobbyResponse> disconnectLobby_Pre($grpc.ServiceCall call, $async.Future<$5.DisconnectLobbyRequest> request) async {
    return disconnectLobby(call, await request);
  }

  $async.Future<$2.void_> startGame_Pre($grpc.ServiceCall call, $async.Future<$3.TokenOnlyRequest> request) async {
    return startGame(call, await request);
  }

  $async.Stream<$3.GameState> getGameState_Pre($grpc.ServiceCall call, $async.Future<$3.GetGameStateRequest> request) async* {
    yield* getGameState(call, await request);
  }

  $async.Stream<$3.StackState> getStackStream_Pre($grpc.ServiceCall call, $async.Future<$3.StackRequest> request) async* {
    yield* getStackStream(call, await request);
  }

  $async.Future<$0.RegisterResponse> register($grpc.ServiceCall call, $0.RegisterRequest request);
  $async.Future<$0.LoginChallengeRequest> requestLoginChallenge($grpc.ServiceCall call, $0.LoginRequest request);
  $async.Future<$0.LoginResponse> submitLoginChallenge($grpc.ServiceCall call, $0.LoginChallengeResponse request);
  $async.Future<$2.void_> sendFriendRequest($grpc.ServiceCall call, $1.FriendRequestRequest request);
  $async.Future<$2.void_> sendFriendRequestResponse($grpc.ServiceCall call, $1.FriendRequestResponse request);
  $async.Future<$1.FriendRequestList> getFriendRequests($grpc.ServiceCall call, $3.TokenOnlyRequest request);
  $async.Future<$1.FriendList> getFriendList($grpc.ServiceCall call, $3.TokenOnlyRequest request);
  $async.Future<$2.void_> deleteFriend($grpc.ServiceCall call, $1.DeleteFriendRequest request);
  $async.Stream<$2.void_> statusChangeStream($grpc.ServiceCall call, $async.Stream<$4.StatusChangeRequest> request);
  $async.Stream<$5.LobbyStatus> createLobby($grpc.ServiceCall call, $5.CreateLobbyRequest request);
  $async.Future<$2.void_> changeStackDevice($grpc.ServiceCall call, $5.ChangeStackDeviceRequest request);
  $async.Stream<$5.LobbyStatus> joinLobby($grpc.ServiceCall call, $5.JoinLobbyRequest request);
  $async.Future<$5.DisconnectLobbyResponse> disconnectLobby($grpc.ServiceCall call, $5.DisconnectLobbyRequest request);
  $async.Future<$2.void_> startGame($grpc.ServiceCall call, $3.TokenOnlyRequest request);
  $async.Stream<$3.GameState> getGameState($grpc.ServiceCall call, $3.GetGameStateRequest request);
  $async.Stream<$3.PlayerState> getPlayerStream($grpc.ServiceCall call, $async.Stream<$3.PlayerAction> request);
  $async.Stream<$3.StackState> getStackStream($grpc.ServiceCall call, $3.StackRequest request);
}
