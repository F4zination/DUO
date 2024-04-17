//
//  Generated code. Do not modify.
//  source: game_statistic.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use playerBoardItemDescriptor instead')
const PlayerBoardItem$json = {
  '1': 'PlayerBoardItem',
  '2': [
    {'1': 'rank', '3': 1, '4': 1, '5': 5, '10': 'rank'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `PlayerBoardItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerBoardItemDescriptor = $convert.base64Decode(
    'Cg9QbGF5ZXJCb2FyZEl0ZW0SEgoEcmFuaxgBIAEoBVIEcmFuaxISCgRuYW1lGAIgASgJUgRuYW'
    '1l');

@$core.Deprecated('Use gameStatisticDescriptor instead')
const GameStatistic$json = {
  '1': 'GameStatistic',
  '2': [
    {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'playedAt', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'playedAt'},
    {'1': 'scoreBilance', '3': 3, '4': 1, '5': 5, '10': 'scoreBilance'},
    {'1': 'playerBoard', '3': 4, '4': 3, '5': 11, '6': '.gameStatistic.PlayerBoardItem', '10': 'playerBoard'},
    {'1': 'gameTitle', '3': 5, '4': 1, '5': 9, '10': 'gameTitle'},
  ],
};

/// Descriptor for `GameStatistic`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameStatisticDescriptor = $convert.base64Decode(
    'Cg1HYW1lU3RhdGlzdGljEhIKBHV1aWQYASABKAlSBHV1aWQSNgoIcGxheWVkQXQYAiABKAsyGi'
    '5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghwbGF5ZWRBdBIiCgxzY29yZUJpbGFuY2UYAyAB'
    'KAVSDHNjb3JlQmlsYW5jZRJACgtwbGF5ZXJCb2FyZBgEIAMoCzIeLmdhbWVTdGF0aXN0aWMuUG'
    'xheWVyQm9hcmRJdGVtUgtwbGF5ZXJCb2FyZBIcCglnYW1lVGl0bGUYBSABKAlSCWdhbWVUaXRs'
    'ZQ==');

