//
//  Generated code. Do not modify.
//  source: game.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use directionDescriptor instead')
const Direction$json = {
  '1': 'Direction',
  '2': [
    {'1': 'CLOCKWISE', '2': 0},
    {'1': 'COUNTER_CLOCKWISE', '2': 1},
  ],
};

/// Descriptor for `Direction`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List directionDescriptor = $convert.base64Decode(
    'CglEaXJlY3Rpb24SDQoJQ0xPQ0tXSVNFEAASFQoRQ09VTlRFUl9DTE9DS1dJU0UQAQ==');

@$core.Deprecated('Use startGameRequestDescriptor instead')
const StartGameRequest$json = {
  '1': 'StartGameRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `StartGameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startGameRequestDescriptor = $convert.base64Decode(
    'ChBTdGFydEdhbWVSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbg==');

@$core.Deprecated('Use getGameStateRequestDescriptor instead')
const GetGameStateRequest$json = {
  '1': 'GetGameStateRequest',
  '2': [
    {'1': 'game_id', '3': 1, '4': 1, '5': 5, '10': 'gameId'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `GetGameStateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGameStateRequestDescriptor = $convert.base64Decode(
    'ChNHZXRHYW1lU3RhdGVSZXF1ZXN0EhcKB2dhbWVfaWQYASABKAVSBmdhbWVJZBIUCgV0b2tlbh'
    'gCIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use gameStateDescriptor instead')
const GameState$json = {
  '1': 'GameState',
  '2': [
    {'1': 'game_id', '3': 1, '4': 1, '5': 5, '10': 'gameId'},
    {'1': 'current_player_uuid', '3': 2, '4': 1, '5': 9, '10': 'currentPlayerUuid'},
    {'1': 'current_player_name', '3': 3, '4': 1, '5': 9, '10': 'currentPlayerName'},
    {'1': 'card_on_top_of_discard', '3': 4, '4': 1, '5': 9, '10': 'cardOnTopOfDiscard'},
    {'1': 'is_game_over', '3': 5, '4': 1, '5': 8, '10': 'isGameOver'},
    {'1': 'game_over_reason', '3': 6, '4': 1, '5': 9, '10': 'gameOverReason'},
    {'1': 'direction', '3': 7, '4': 1, '5': 14, '6': '.pb.Direction', '10': 'direction'},
    {'1': 'allPlayersReady', '3': 8, '4': 1, '5': 8, '10': 'allPlayersReady'},
  ],
};

/// Descriptor for `GameState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameStateDescriptor = $convert.base64Decode(
    'CglHYW1lU3RhdGUSFwoHZ2FtZV9pZBgBIAEoBVIGZ2FtZUlkEi4KE2N1cnJlbnRfcGxheWVyX3'
    'V1aWQYAiABKAlSEWN1cnJlbnRQbGF5ZXJVdWlkEi4KE2N1cnJlbnRfcGxheWVyX25hbWUYAyAB'
    'KAlSEWN1cnJlbnRQbGF5ZXJOYW1lEjIKFmNhcmRfb25fdG9wX29mX2Rpc2NhcmQYBCABKAlSEm'
    'NhcmRPblRvcE9mRGlzY2FyZBIgCgxpc19nYW1lX292ZXIYBSABKAhSCmlzR2FtZU92ZXISKAoQ'
    'Z2FtZV9vdmVyX3JlYXNvbhgGIAEoCVIOZ2FtZU92ZXJSZWFzb24SKwoJZGlyZWN0aW9uGAcgAS'
    'gOMg0ucGIuRGlyZWN0aW9uUglkaXJlY3Rpb24SKAoPYWxsUGxheWVyc1JlYWR5GAggASgIUg9h'
    'bGxQbGF5ZXJzUmVhZHk=');

@$core.Deprecated('Use playerStateDescriptor instead')
const PlayerState$json = {
  '1': 'PlayerState',
  '2': [
    {'1': 'hand', '3': 1, '4': 3, '5': 9, '10': 'hand'},
    {'1': 'alert', '3': 2, '4': 1, '5': 11, '6': '.pb.Alert', '10': 'alert'},
  ],
};

/// Descriptor for `PlayerState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerStateDescriptor = $convert.base64Decode(
    'CgtQbGF5ZXJTdGF0ZRISCgRoYW5kGAEgAygJUgRoYW5kEh8KBWFsZXJ0GAIgASgLMgkucGIuQW'
    'xlcnRSBWFsZXJ0');

@$core.Deprecated('Use stackStateDescriptor instead')
const StackState$json = {
  '1': 'StackState',
  '2': [
    {'1': 'place_stack', '3': 1, '4': 1, '5': 11, '6': '.pb.PlaceStackState', '10': 'placeStack'},
    {'1': 'draw_stack', '3': 2, '4': 1, '5': 11, '6': '.pb.DrawStackState', '10': 'drawStack'},
    {'1': 'direction', '3': 3, '4': 1, '5': 14, '6': '.pb.Direction', '10': 'direction'},
  ],
};

/// Descriptor for `StackState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stackStateDescriptor = $convert.base64Decode(
    'CgpTdGFja1N0YXRlEjQKC3BsYWNlX3N0YWNrGAEgASgLMhMucGIuUGxhY2VTdGFja1N0YXRlUg'
    'pwbGFjZVN0YWNrEjEKCmRyYXdfc3RhY2sYAiABKAsyEi5wYi5EcmF3U3RhY2tTdGF0ZVIJZHJh'
    'd1N0YWNrEisKCWRpcmVjdGlvbhgDIAEoDjINLnBiLkRpcmVjdGlvblIJZGlyZWN0aW9u');

@$core.Deprecated('Use playerActionDescriptor instead')
const PlayerAction$json = {
  '1': 'PlayerAction',
  '2': [
    {'1': 'action', '3': 1, '4': 1, '5': 14, '6': '.pb.PlayerAction.ActionType', '10': 'action'},
    {'1': 'card_id', '3': 2, '4': 1, '5': 9, '10': 'cardId'},
    {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
  ],
  '4': [PlayerAction_ActionType$json],
};

@$core.Deprecated('Use playerActionDescriptor instead')
const PlayerAction_ActionType$json = {
  '1': 'ActionType',
  '2': [
    {'1': 'DRAW', '2': 0},
    {'1': 'PLACE', '2': 1},
    {'1': 'SKIP', '2': 2},
  ],
};

/// Descriptor for `PlayerAction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerActionDescriptor = $convert.base64Decode(
    'CgxQbGF5ZXJBY3Rpb24SMwoGYWN0aW9uGAEgASgOMhsucGIuUGxheWVyQWN0aW9uLkFjdGlvbl'
    'R5cGVSBmFjdGlvbhIXCgdjYXJkX2lkGAIgASgJUgZjYXJkSWQSFAoFdG9rZW4YAyABKAlSBXRv'
    'a2VuIisKCkFjdGlvblR5cGUSCAoERFJBVxAAEgkKBVBMQUNFEAESCAoEU0tJUBAC');

@$core.Deprecated('Use stackRequestDescriptor instead')
const StackRequest$json = {
  '1': 'StackRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'game_id', '3': 2, '4': 1, '5': 5, '10': 'gameId'},
  ],
};

/// Descriptor for `StackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stackRequestDescriptor = $convert.base64Decode(
    'CgxTdGFja1JlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2VuEhcKB2dhbWVfaWQYAiABKAVSBm'
    'dhbWVJZA==');

@$core.Deprecated('Use alertDescriptor instead')
const Alert$json = {
  '1': 'Alert',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Alert`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List alertDescriptor = $convert.base64Decode(
    'CgVBbGVydBIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use placeStackStateDescriptor instead')
const PlaceStackState$json = {
  '1': 'PlaceStackState',
  '2': [
    {'1': 'amount_cards', '3': 1, '4': 1, '5': 5, '10': 'amountCards'},
    {'1': 'card_id_on_top', '3': 2, '4': 1, '5': 9, '10': 'cardIdOnTop'},
  ],
};

/// Descriptor for `PlaceStackState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List placeStackStateDescriptor = $convert.base64Decode(
    'Cg9QbGFjZVN0YWNrU3RhdGUSIQoMYW1vdW50X2NhcmRzGAEgASgFUgthbW91bnRDYXJkcxIjCg'
    '5jYXJkX2lkX29uX3RvcBgCIAEoCVILY2FyZElkT25Ub3A=');

@$core.Deprecated('Use drawStackStateDescriptor instead')
const DrawStackState$json = {
  '1': 'DrawStackState',
  '2': [
    {'1': 'stack_id', '3': 1, '4': 1, '5': 5, '10': 'stackId'},
    {'1': 'card_ids', '3': 4, '4': 3, '5': 9, '10': 'cardIds'},
  ],
};

/// Descriptor for `DrawStackState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List drawStackStateDescriptor = $convert.base64Decode(
    'Cg5EcmF3U3RhY2tTdGF0ZRIZCghzdGFja19pZBgBIAEoBVIHc3RhY2tJZBIZCghjYXJkX2lkcx'
    'gEIAMoCVIHY2FyZElkcw==');

