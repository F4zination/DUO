//
//  Generated code. Do not modify.
//  source: lobby.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use lobbyStatusDescriptor instead')
const LobbyStatus$json = {
  '1': 'LobbyStatus',
  '2': [
    {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.user.User', '10': 'users'},
    {'1': 'isStarting', '3': 2, '4': 1, '5': 8, '10': 'isStarting'},
    {'1': 'lobby_id', '3': 3, '4': 1, '5': 5, '10': 'lobbyId'},
    {'1': 'max_players', '3': 4, '4': 1, '5': 5, '10': 'maxPlayers'},
  ],
};

/// Descriptor for `LobbyStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lobbyStatusDescriptor = $convert.base64Decode(
    'CgtMb2JieVN0YXR1cxIgCgV1c2VycxgBIAMoCzIKLnVzZXIuVXNlclIFdXNlcnMSHgoKaXNTdG'
    'FydGluZxgCIAEoCFIKaXNTdGFydGluZxIZCghsb2JieV9pZBgDIAEoBVIHbG9iYnlJZBIfCgtt'
    'YXhfcGxheWVycxgEIAEoBVIKbWF4UGxheWVycw==');

@$core.Deprecated('Use createLobbyRequestDescriptor instead')
const CreateLobbyRequest$json = {
  '1': 'CreateLobbyRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'max_players', '3': 2, '4': 1, '5': 5, '10': 'maxPlayers'},
  ],
};

/// Descriptor for `CreateLobbyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLobbyRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVMb2JieVJlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2VuEh8KC21heF9wbGF5ZX'
    'JzGAIgASgFUgptYXhQbGF5ZXJz');

@$core.Deprecated('Use joinLobbyRequestDescriptor instead')
const JoinLobbyRequest$json = {
  '1': 'JoinLobbyRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'lobby_id', '3': 2, '4': 1, '5': 5, '10': 'lobbyId'},
  ],
};

/// Descriptor for `JoinLobbyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinLobbyRequestDescriptor = $convert.base64Decode(
    'ChBKb2luTG9iYnlSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIZCghsb2JieV9pZBgCIA'
    'EoBVIHbG9iYnlJZA==');

@$core.Deprecated('Use disconnectLobbyRequestDescriptor instead')
const DisconnectLobbyRequest$json = {
  '1': 'DisconnectLobbyRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'lobby_id', '3': 2, '4': 1, '5': 5, '10': 'lobbyId'},
  ],
};

/// Descriptor for `DisconnectLobbyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectLobbyRequestDescriptor = $convert.base64Decode(
    'ChZEaXNjb25uZWN0TG9iYnlSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIZCghsb2JieV'
    '9pZBgCIAEoBVIHbG9iYnlJZA==');

@$core.Deprecated('Use disconnectLobbyResponseDescriptor instead')
const DisconnectLobbyResponse$json = {
  '1': 'DisconnectLobbyResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DisconnectLobbyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectLobbyResponseDescriptor = $convert.base64Decode(
    'ChdEaXNjb25uZWN0TG9iYnlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

