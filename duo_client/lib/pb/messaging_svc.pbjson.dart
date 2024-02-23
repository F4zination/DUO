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

import 'empty.pbjson.dart' as $0;
import 'request.pbjson.dart' as $1;

const $core.Map<$core.String, $core.dynamic> MessagingServiceBase$json = {
  '1': 'MessagingService',
  '2': [
    {'1': 'connect', '2': '.pb.Empty', '3': '.pb.Request', '6': true},
    {'1': 'send', '2': '.pb.Request', '3': '.pb.Empty'},
  ],
};

@$core.Deprecated('Use messagingServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> MessagingServiceBase$messageJson = {
  '.pb.Empty': $0.Empty$json,
  '.pb.Request': $1.Request$json,
};

/// Descriptor for `MessagingService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List messagingServiceDescriptor = $convert.base64Decode(
    'ChBNZXNzYWdpbmdTZXJ2aWNlEiMKB2Nvbm5lY3QSCS5wYi5FbXB0eRoLLnBiLlJlcXVlc3QwAR'
    'IeCgRzZW5kEgsucGIuUmVxdWVzdBoJLnBiLkVtcHR5');

