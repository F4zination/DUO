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
import 'game.pb.dart' as $2;
import 'lobby.pb.dart' as $1;
import 'void.pb.dart' as $3;

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
  static final _$createLobby = $grpc.ClientMethod<$1.CreateLobbyRequest, $1.LobbyStatus>(
      '/pb.DUOService/CreateLobby',
      ($1.CreateLobbyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.LobbyStatus.fromBuffer(value));
  static final _$joinLobby = $grpc.ClientMethod<$1.JoinLobbyRequest, $1.LobbyStatus>(
      '/pb.DUOService/JoinLobby',
      ($1.JoinLobbyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.LobbyStatus.fromBuffer(value));
  static final _$disconnectLobby = $grpc.ClientMethod<$1.DisconnectLobbyRequest, $1.DisconnectLobbyResponse>(
      '/pb.DUOService/DisconnectLobby',
      ($1.DisconnectLobbyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DisconnectLobbyResponse.fromBuffer(value));
  static final _$startGame = $grpc.ClientMethod<$2.StartGameRequest, $2.GameState>(
      '/pb.DUOService/StartGame',
      ($2.StartGameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GameState.fromBuffer(value));
  static final _$getPlayerStream = $grpc.ClientMethod<$2.GetPlayerStateRequest, $2.PlayerState>(
      '/pb.DUOService/GetPlayerStream',
      ($2.GetPlayerStateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.PlayerState.fromBuffer(value));
  static final _$getStackStream = $grpc.ClientMethod<$2.GetStackStateRequest, $2.StackState>(
      '/pb.DUOService/GetStackStream',
      ($2.GetStackStateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.StackState.fromBuffer(value));
  static final _$streamPlayerActions = $grpc.ClientMethod<$2.PlayerAction, $3.void_>(
      '/pb.DUOService/StreamPlayerActions',
      ($2.PlayerAction value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.void_.fromBuffer(value));

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

  $grpc.ResponseStream<$1.LobbyStatus> createLobby($1.CreateLobbyRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createLobby, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.LobbyStatus> joinLobby($1.JoinLobbyRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$joinLobby, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.DisconnectLobbyResponse> disconnectLobby($1.DisconnectLobbyRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disconnectLobby, request, options: options);
  }

  $grpc.ResponseStream<$2.GameState> startGame($2.StartGameRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$startGame, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$2.PlayerState> getPlayerStream($2.GetPlayerStateRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getPlayerStream, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$2.StackState> getStackStream($2.GetStackStateRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getStackStream, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$3.void_> streamPlayerActions($async.Stream<$2.PlayerAction> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamPlayerActions, request, options: options).single;
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
    $addMethod($grpc.ServiceMethod<$1.CreateLobbyRequest, $1.LobbyStatus>(
        'CreateLobby',
        createLobby_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.CreateLobbyRequest.fromBuffer(value),
        ($1.LobbyStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.JoinLobbyRequest, $1.LobbyStatus>(
        'JoinLobby',
        joinLobby_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.JoinLobbyRequest.fromBuffer(value),
        ($1.LobbyStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DisconnectLobbyRequest, $1.DisconnectLobbyResponse>(
        'DisconnectLobby',
        disconnectLobby_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.DisconnectLobbyRequest.fromBuffer(value),
        ($1.DisconnectLobbyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.StartGameRequest, $2.GameState>(
        'StartGame',
        startGame_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $2.StartGameRequest.fromBuffer(value),
        ($2.GameState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetPlayerStateRequest, $2.PlayerState>(
        'GetPlayerStream',
        getPlayerStream_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $2.GetPlayerStateRequest.fromBuffer(value),
        ($2.PlayerState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetStackStateRequest, $2.StackState>(
        'GetStackStream',
        getStackStream_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $2.GetStackStateRequest.fromBuffer(value),
        ($2.StackState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.PlayerAction, $3.void_>(
        'StreamPlayerActions',
        streamPlayerActions,
        true,
        false,
        ($core.List<$core.int> value) => $2.PlayerAction.fromBuffer(value),
        ($3.void_ value) => value.writeToBuffer()));
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

  $async.Stream<$1.LobbyStatus> createLobby_Pre($grpc.ServiceCall call, $async.Future<$1.CreateLobbyRequest> request) async* {
    yield* createLobby(call, await request);
  }

  $async.Stream<$1.LobbyStatus> joinLobby_Pre($grpc.ServiceCall call, $async.Future<$1.JoinLobbyRequest> request) async* {
    yield* joinLobby(call, await request);
  }

  $async.Future<$1.DisconnectLobbyResponse> disconnectLobby_Pre($grpc.ServiceCall call, $async.Future<$1.DisconnectLobbyRequest> request) async {
    return disconnectLobby(call, await request);
  }

  $async.Stream<$2.GameState> startGame_Pre($grpc.ServiceCall call, $async.Future<$2.StartGameRequest> request) async* {
    yield* startGame(call, await request);
  }

  $async.Stream<$2.PlayerState> getPlayerStream_Pre($grpc.ServiceCall call, $async.Future<$2.GetPlayerStateRequest> request) async* {
    yield* getPlayerStream(call, await request);
  }

  $async.Stream<$2.StackState> getStackStream_Pre($grpc.ServiceCall call, $async.Future<$2.GetStackStateRequest> request) async* {
    yield* getStackStream(call, await request);
  }

  $async.Future<$0.RegisterResponse> register($grpc.ServiceCall call, $0.RegisterRequest request);
  $async.Future<$0.LoginChallengeRequest> requestLoginChallenge($grpc.ServiceCall call, $0.LoginRequest request);
  $async.Future<$0.LoginResponse> submitLoginChallenge($grpc.ServiceCall call, $0.LoginChallengeResponse request);
  $async.Stream<$1.LobbyStatus> createLobby($grpc.ServiceCall call, $1.CreateLobbyRequest request);
  $async.Stream<$1.LobbyStatus> joinLobby($grpc.ServiceCall call, $1.JoinLobbyRequest request);
  $async.Future<$1.DisconnectLobbyResponse> disconnectLobby($grpc.ServiceCall call, $1.DisconnectLobbyRequest request);
  $async.Stream<$2.GameState> startGame($grpc.ServiceCall call, $2.StartGameRequest request);
  $async.Stream<$2.PlayerState> getPlayerStream($grpc.ServiceCall call, $2.GetPlayerStateRequest request);
  $async.Stream<$2.StackState> getStackStream($grpc.ServiceCall call, $2.GetStackStateRequest request);
  $async.Future<$3.void_> streamPlayerActions($grpc.ServiceCall call, $async.Stream<$2.PlayerAction> request);
}
