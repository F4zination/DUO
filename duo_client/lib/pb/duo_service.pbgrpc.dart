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
import 'session_messages.pb.dart' as $1;

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
  static final _$createSession = $grpc.ClientMethod<$1.CreateSessionRequest, $1.CreateSessionResponse>(
      '/pb.DUOService/CreateSession',
      ($1.CreateSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.CreateSessionResponse.fromBuffer(value));
  static final _$joinSession = $grpc.ClientMethod<$1.JoinSessionRequest, $1.SessionStream>(
      '/pb.DUOService/JoinSession',
      ($1.JoinSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.SessionStream.fromBuffer(value));
  static final _$disconnectSession = $grpc.ClientMethod<$1.DisconnectSessionRequest, $1.DisconnectSessionResponse>(
      '/pb.DUOService/DisconnectSession',
      ($1.DisconnectSessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DisconnectSessionResponse.fromBuffer(value));

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

  $grpc.ResponseFuture<$1.CreateSessionResponse> createSession($1.CreateSessionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSession, request, options: options);
  }

  $grpc.ResponseStream<$1.SessionStream> joinSession($1.JoinSessionRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$joinSession, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.DisconnectSessionResponse> disconnectSession($1.DisconnectSessionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disconnectSession, request, options: options);
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
    $addMethod($grpc.ServiceMethod<$1.CreateSessionRequest, $1.CreateSessionResponse>(
        'CreateSession',
        createSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CreateSessionRequest.fromBuffer(value),
        ($1.CreateSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.JoinSessionRequest, $1.SessionStream>(
        'JoinSession',
        joinSession_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.JoinSessionRequest.fromBuffer(value),
        ($1.SessionStream value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DisconnectSessionRequest, $1.DisconnectSessionResponse>(
        'DisconnectSession',
        disconnectSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.DisconnectSessionRequest.fromBuffer(value),
        ($1.DisconnectSessionResponse value) => value.writeToBuffer()));
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

  $async.Future<$1.CreateSessionResponse> createSession_Pre($grpc.ServiceCall call, $async.Future<$1.CreateSessionRequest> request) async {
    return createSession(call, await request);
  }

  $async.Stream<$1.SessionStream> joinSession_Pre($grpc.ServiceCall call, $async.Future<$1.JoinSessionRequest> request) async* {
    yield* joinSession(call, await request);
  }

  $async.Future<$1.DisconnectSessionResponse> disconnectSession_Pre($grpc.ServiceCall call, $async.Future<$1.DisconnectSessionRequest> request) async {
    return disconnectSession(call, await request);
  }

  $async.Future<$0.RegisterResponse> register($grpc.ServiceCall call, $0.RegisterRequest request);
  $async.Future<$0.LoginChallengeRequest> requestLoginChallenge($grpc.ServiceCall call, $0.LoginRequest request);
  $async.Future<$0.LoginResponse> submitLoginChallenge($grpc.ServiceCall call, $0.LoginChallengeResponse request);
  $async.Future<$1.CreateSessionResponse> createSession($grpc.ServiceCall call, $1.CreateSessionRequest request);
  $async.Stream<$1.SessionStream> joinSession($grpc.ServiceCall call, $1.JoinSessionRequest request);
  $async.Future<$1.DisconnectSessionResponse> disconnectSession($grpc.ServiceCall call, $1.DisconnectSessionRequest request);
}
