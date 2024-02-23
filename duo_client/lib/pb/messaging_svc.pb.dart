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

import 'request.pb.dart' as $0;

class MessagingServiceApi {
  $pb.RpcClient _client;
  MessagingServiceApi(this._client);

  $async.Future<$0.Request> send($pb.ClientContext? ctx, $0.Request request) =>
    _client.invoke<$0.Request>(ctx, 'MessagingService', 'Send', request, $0.Request())
  ;
}

