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

@$core.Deprecated('Use startGameRequestDescriptor instead')
const StartGameRequest$json = {
  '1': 'StartGameRequest',
  '2': [
    {'1': 'game_id', '3': 1, '4': 1, '5': 9, '10': 'gameId'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `StartGameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startGameRequestDescriptor = $convert.base64Decode(
    'ChBTdGFydEdhbWVSZXF1ZXN0EhcKB2dhbWVfaWQYASABKAlSBmdhbWVJZBIUCgV0b2tlbhgCIA'
    'EoCVIFdG9rZW4=');

@$core.Deprecated('Use getPlayerStateRequestDescriptor instead')
const GetPlayerStateRequest$json = {
  '1': 'GetPlayerStateRequest',
  '2': [
    {'1': 'game_id', '3': 1, '4': 1, '5': 9, '10': 'gameId'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `GetPlayerStateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlayerStateRequestDescriptor = $convert.base64Decode(
    'ChVHZXRQbGF5ZXJTdGF0ZVJlcXVlc3QSFwoHZ2FtZV9pZBgBIAEoCVIGZ2FtZUlkEhQKBXRva2'
    'VuGAIgASgJUgV0b2tlbg==');

@$core.Deprecated('Use getStackStateRequestDescriptor instead')
const GetStackStateRequest$json = {
  '1': 'GetStackStateRequest',
  '2': [
    {'1': 'game_id', '3': 1, '4': 1, '5': 9, '10': 'gameId'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `GetStackStateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStackStateRequestDescriptor = $convert.base64Decode(
    'ChRHZXRTdGFja1N0YXRlUmVxdWVzdBIXCgdnYW1lX2lkGAEgASgJUgZnYW1lSWQSFAoFdG9rZW'
    '4YAiABKAlSBXRva2Vu');

@$core.Deprecated('Use gameStateDescriptor instead')
const GameState$json = {
  '1': 'GameState',
  '2': [
    {'1': 'current_player', '3': 1, '4': 1, '5': 9, '10': 'currentPlayer'},
    {'1': 'card_on_top_of_discard', '3': 2, '4': 1, '5': 11, '6': '.pb.Card', '10': 'cardOnTopOfDiscard'},
  ],
};

/// Descriptor for `GameState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameStateDescriptor = $convert.base64Decode(
    'CglHYW1lU3RhdGUSJQoOY3VycmVudF9wbGF5ZXIYASABKAlSDWN1cnJlbnRQbGF5ZXISPAoWY2'
    'FyZF9vbl90b3Bfb2ZfZGlzY2FyZBgCIAEoCzIILnBiLkNhcmRSEmNhcmRPblRvcE9mRGlzY2Fy'
    'ZA==');

@$core.Deprecated('Use playerStateDescriptor instead')
const PlayerState$json = {
  '1': 'PlayerState',
  '2': [
    {'1': 'hand', '3': 1, '4': 3, '5': 11, '6': '.pb.Card', '10': 'hand'},
    {'1': 'alert', '3': 2, '4': 1, '5': 11, '6': '.pb.Alert', '10': 'alert'},
  ],
};

/// Descriptor for `PlayerState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerStateDescriptor = $convert.base64Decode(
    'CgtQbGF5ZXJTdGF0ZRIcCgRoYW5kGAEgAygLMggucGIuQ2FyZFIEaGFuZBIfCgVhbGVydBgCIA'
    'EoCzIJLnBiLkFsZXJ0UgVhbGVydA==');

@$core.Deprecated('Use stackStateDescriptor instead')
const StackState$json = {
  '1': 'StackState',
  '2': [
    {'1': 'place_stack', '3': 1, '4': 1, '5': 11, '6': '.pb.PlaceStackState', '10': 'placeStack'},
    {'1': 'draw_stack', '3': 2, '4': 1, '5': 11, '6': '.pb.DrawStackState', '10': 'drawStack'},
    {'1': 'direction', '3': 3, '4': 1, '5': 14, '6': '.pb.StackState.Direction', '10': 'direction'},
  ],
  '4': [StackState_Direction$json],
};

@$core.Deprecated('Use stackStateDescriptor instead')
const StackState_Direction$json = {
  '1': 'Direction',
  '2': [
    {'1': 'CLOCKWISE', '2': 0},
    {'1': 'COUNTER_CLOCKWISE', '2': 1},
  ],
};

/// Descriptor for `StackState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stackStateDescriptor = $convert.base64Decode(
    'CgpTdGFja1N0YXRlEjQKC3BsYWNlX3N0YWNrGAEgASgLMhMucGIuUGxhY2VTdGFja1N0YXRlUg'
    'pwbGFjZVN0YWNrEjEKCmRyYXdfc3RhY2sYAiABKAsyEi5wYi5EcmF3U3RhY2tTdGF0ZVIJZHJh'
    'd1N0YWNrEjYKCWRpcmVjdGlvbhgDIAEoDjIYLnBiLlN0YWNrU3RhdGUuRGlyZWN0aW9uUglkaX'
    'JlY3Rpb24iMQoJRGlyZWN0aW9uEg0KCUNMT0NLV0lTRRAAEhUKEUNPVU5URVJfQ0xPQ0tXSVNF'
    'EAE=');

@$core.Deprecated('Use playerActionDescriptor instead')
const PlayerAction$json = {
  '1': 'PlayerAction',
  '2': [
    {'1': 'action', '3': 1, '4': 1, '5': 14, '6': '.pb.PlayerAction.ActionType', '10': 'action'},
    {'1': 'card_id', '3': 2, '4': 1, '5': 9, '10': 'cardId'},
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
    'R5cGVSBmFjdGlvbhIXCgdjYXJkX2lkGAIgASgJUgZjYXJkSWQiKwoKQWN0aW9uVHlwZRIICgRE'
    'UkFXEAASCQoFUExBQ0UQARIICgRTS0lQEAI=');

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

@$core.Deprecated('Use cardDescriptor instead')
const Card$json = {
  '1': 'Card',
  '2': [
    {'1': 'card_id', '3': 1, '4': 1, '5': 9, '10': 'cardId'},
    {'1': 'is_face_up', '3': 2, '4': 1, '5': 8, '10': 'isFaceUp'},
  ],
};

/// Descriptor for `Card`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardDescriptor = $convert.base64Decode(
    'CgRDYXJkEhcKB2NhcmRfaWQYASABKAlSBmNhcmRJZBIcCgppc19mYWNlX3VwGAIgASgIUghpc0'
    'ZhY2VVcA==');

@$core.Deprecated('Use placeStackStateDescriptor instead')
const PlaceStackState$json = {
  '1': 'PlaceStackState',
  '2': [
    {'1': 'amount_cards', '3': 1, '4': 1, '5': 5, '10': 'amountCards'},
    {'1': 'card_on_top', '3': 2, '4': 1, '5': 11, '6': '.pb.Card', '10': 'cardOnTop'},
  ],
};

/// Descriptor for `PlaceStackState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List placeStackStateDescriptor = $convert.base64Decode(
    'Cg9QbGFjZVN0YWNrU3RhdGUSIQoMYW1vdW50X2NhcmRzGAEgASgFUgthbW91bnRDYXJkcxIoCg'
    'tjYXJkX29uX3RvcBgCIAEoCzIILnBiLkNhcmRSCWNhcmRPblRvcA==');

@$core.Deprecated('Use drawStackStateDescriptor instead')
const DrawStackState$json = {
  '1': 'DrawStackState',
  '2': [
    {'1': 'stack_id', '3': 1, '4': 1, '5': 5, '10': 'stackId'},
    {'1': 'cards', '3': 4, '4': 3, '5': 11, '6': '.pb.Card', '10': 'cards'},
  ],
};

/// Descriptor for `DrawStackState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List drawStackStateDescriptor = $convert.base64Decode(
    'Cg5EcmF3U3RhY2tTdGF0ZRIZCghzdGFja19pZBgBIAEoBVIHc3RhY2tJZBIeCgVjYXJkcxgEIA'
    'MoCzIILnBiLkNhcmRSBWNhcmRz');

