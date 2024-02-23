//
//  Generated code. Do not modify.
//  source: messaging_svc.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import 'request.pbjson.dart' as $0;

const $core.Map<$core.String, $core.dynamic> MessagingServiceBase$json = {
  '1': 'MessagingService',
  '2': [
    {'1': 'Send', '2': '.pb.Request', '3': '.pb.Request', '5': true, '6': true},
  ],
};

@$core.Deprecated('Use messagingServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> MessagingServiceBase$messageJson = {
  '.pb.Request': $0.Request$json,
};

/// Descriptor for `MessagingService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List messagingServiceDescriptor = $convert.base64Decode(
    'ChBNZXNzYWdpbmdTZXJ2aWNlEiQKBFNlbmQSCy5wYi5SZXF1ZXN0GgsucGIuUmVxdWVzdCgBMA'
    'E=');

