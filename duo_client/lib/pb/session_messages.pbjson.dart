//
//  Generated code. Do not modify.
//  source: session_messages.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use gameStateDescriptor instead')
const GameState$json = {
  '1': 'GameState',
};

/// Descriptor for `GameState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameStateDescriptor = $convert.base64Decode(
    'CglHYW1lU3RhdGU=');

@$core.Deprecated('Use sessionStateDescriptor instead')
const SessionState$json = {
  '1': 'SessionState',
  '2': [
    {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.user.User', '10': 'users'},
    {'1': 'max_players', '3': 2, '4': 1, '5': 5, '10': 'maxPlayers'},
  ],
};

/// Descriptor for `SessionState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionStateDescriptor = $convert.base64Decode(
    'CgxTZXNzaW9uU3RhdGUSIAoFdXNlcnMYASADKAsyCi51c2VyLlVzZXJSBXVzZXJzEh8KC21heF'
    '9wbGF5ZXJzGAIgASgFUgptYXhQbGF5ZXJz');

@$core.Deprecated('Use createSessionRequestDescriptor instead')
const CreateSessionRequest$json = {
  '1': 'CreateSessionRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'max_players', '3': 3, '4': 1, '5': 5, '10': 'maxPlayers'},
  ],
};

/// Descriptor for `CreateSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSessionRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVTZXNzaW9uUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SEAoDcGluGAIgAS'
    'gJUgNwaW4SHwoLbWF4X3BsYXllcnMYAyABKAVSCm1heFBsYXllcnM=');

@$core.Deprecated('Use createSessionResponseDescriptor instead')
const CreateSessionResponse$json = {
  '1': 'CreateSessionResponse',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 5, '10': 'sessionId'},
    {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `CreateSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSessionResponseDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVTZXNzaW9uUmVzcG9uc2USHQoKc2Vzc2lvbl9pZBgBIAEoBVIJc2Vzc2lvbklkEh'
    'AKA3BpbhgCIAEoCVIDcGlu');

@$core.Deprecated('Use joinSessionRequestDescriptor instead')
const JoinSessionRequest$json = {
  '1': 'JoinSessionRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'session_id', '3': 2, '4': 1, '5': 5, '10': 'sessionId'},
    {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `JoinSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinSessionRequestDescriptor = $convert.base64Decode(
    'ChJKb2luU2Vzc2lvblJlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2VuEh0KCnNlc3Npb25faW'
    'QYAiABKAVSCXNlc3Npb25JZBIQCgNwaW4YAyABKAlSA3Bpbg==');

@$core.Deprecated('Use sessionStreamDescriptor instead')
const SessionStream$json = {
  '1': 'SessionStream',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 5, '10': 'sessionId'},
    {'1': 'game_state', '3': 2, '4': 1, '5': 11, '6': '.pb.GameState', '10': 'gameState'},
    {'1': 'session_state', '3': 3, '4': 1, '5': 11, '6': '.pb.SessionState', '10': 'sessionState'},
  ],
};

/// Descriptor for `SessionStream`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionStreamDescriptor = $convert.base64Decode(
    'Cg1TZXNzaW9uU3RyZWFtEh0KCnNlc3Npb25faWQYASABKAVSCXNlc3Npb25JZBIsCgpnYW1lX3'
    'N0YXRlGAIgASgLMg0ucGIuR2FtZVN0YXRlUglnYW1lU3RhdGUSNQoNc2Vzc2lvbl9zdGF0ZRgD'
    'IAEoCzIQLnBiLlNlc3Npb25TdGF0ZVIMc2Vzc2lvblN0YXRl');

@$core.Deprecated('Use disconnectSessionRequestDescriptor instead')
const DisconnectSessionRequest$json = {
  '1': 'DisconnectSessionRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'session_id', '3': 2, '4': 1, '5': 5, '10': 'sessionId'},
  ],
};

/// Descriptor for `DisconnectSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectSessionRequestDescriptor = $convert.base64Decode(
    'ChhEaXNjb25uZWN0U2Vzc2lvblJlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2VuEh0KCnNlc3'
    'Npb25faWQYAiABKAVSCXNlc3Npb25JZA==');

@$core.Deprecated('Use disconnectSessionResponseDescriptor instead')
const DisconnectSessionResponse$json = {
  '1': 'DisconnectSessionResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DisconnectSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectSessionResponseDescriptor = $convert.base64Decode(
    'ChlEaXNjb25uZWN0U2Vzc2lvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3M=');

