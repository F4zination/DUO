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

import 'package:protobuf/protobuf.dart' as $pb;

import 'empty.pb.dart' as $0;
import 'request.pb.dart' as $1;

class MessagingServiceApi {
  $pb.RpcClient _client;
  MessagingServiceApi(this._client);

  $async.Future<$1.Request> connect($pb.ClientContext? ctx, $0.Empty request) =>
    _client.invoke<$1.Request>(ctx, 'MessagingService', 'connect', request, $1.Request())
  ;
  $async.Future<$0.Empty> send($pb.ClientContext? ctx, $1.Request request) =>
    _client.invoke<$0.Empty>(ctx, 'MessagingService', 'send', request, $0.Empty())
  ;
}

