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
    {'1': 'card_on_top', '3': 2, '4': 1, '5': 11, '6': '.game.Card', '10': 'cardOnTop'},
  ],
};

/// Descriptor for `PlaceStackState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List placeStackStateDescriptor = $convert.base64Decode(
    'Cg9QbGFjZVN0YWNrU3RhdGUSIQoMYW1vdW50X2NhcmRzGAEgASgFUgthbW91bnRDYXJkcxIqCg'
    'tjYXJkX29uX3RvcBgCIAEoCzIKLmdhbWUuQ2FyZFIJY2FyZE9uVG9w');

@$core.Deprecated('Use drawStackStateDescriptor instead')
const DrawStackState$json = {
  '1': 'DrawStackState',
  '2': [
    {'1': 'stack_id', '3': 1, '4': 1, '5': 5, '10': 'stackId'},
    {'1': 'stack_size', '3': 2, '4': 1, '5': 5, '10': 'stackSize'},
    {'1': 'stack_type', '3': 3, '4': 1, '5': 5, '10': 'stackType'},
    {'1': 'cards', '3': 4, '4': 3, '5': 11, '6': '.game.Card', '10': 'cards'},
  ],
};

/// Descriptor for `DrawStackState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List drawStackStateDescriptor = $convert.base64Decode(
    'Cg5EcmF3U3RhY2tTdGF0ZRIZCghzdGFja19pZBgBIAEoBVIHc3RhY2tJZBIdCgpzdGFja19zaX'
    'plGAIgASgFUglzdGFja1NpemUSHQoKc3RhY2tfdHlwZRgDIAEoBVIJc3RhY2tUeXBlEiAKBWNh'
    'cmRzGAQgAygLMgouZ2FtZS5DYXJkUgVjYXJkcw==');

