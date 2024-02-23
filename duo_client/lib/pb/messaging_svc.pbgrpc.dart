//
//  Generated code. Do not modify.
//  source: messaging_svc.proto
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

import 'empty.pb.dart' as $0;
import 'request.pb.dart' as $1;

export 'messaging_svc.pb.dart';

@$pb.GrpcServiceName('pb.MessagingService')
class MessagingServiceClient extends $grpc.Client {
  static final _$connect = $grpc.ClientMethod<$0.Empty, $1.Request>(
      '/pb.MessagingService/connect',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Request.fromBuffer(value));
  static final _$send = $grpc.ClientMethod<$1.Request, $0.Empty>(
      '/pb.MessagingService/send',
      ($1.Request value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  MessagingServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$1.Request> connect($0.Empty request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$connect, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$0.Empty> send($1.Request request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$send, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.MessagingService')
abstract class MessagingServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.MessagingService';

  MessagingServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.Request>(
        'connect',
        connect_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.Request value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Request, $0.Empty>(
        'send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Request.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Stream<$1.Request> connect_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* connect(call, await request);
  }

  $async.Future<$0.Empty> send_Pre($grpc.ServiceCall call, $async.Future<$1.Request> request) async {
    return send(call, await request);
  }

  $async.Stream<$1.Request> connect($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Empty> send($grpc.ServiceCall call, $1.Request request);
}
