//
//  Generated code. Do not modify.
//  source: messaging_svc.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'empty.pb.dart' as $0;
import 'messaging_svc.pbjson.dart';
import 'request.pb.dart' as $1;

export 'messaging_svc.pb.dart';

abstract class MessagingServiceBase extends $pb.GeneratedService {
  $async.Future<$1.Request> connect($pb.ServerContext ctx, $0.Empty request);
  $async.Future<$0.Empty> send($pb.ServerContext ctx, $1.Request request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'connect': return $0.Empty();
      case 'send': return $1.Request();
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'connect': return this.connect(ctx, request as $0.Empty);
      case 'send': return this.send(ctx, request as $1.Request);
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => MessagingServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => MessagingServiceBase$messageJson;
}

