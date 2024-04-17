//
//  Generated code. Do not modify.
//  source: friend.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use friendStateDescriptor instead')
const FriendState$json = {
  '1': 'FriendState',
  '2': [
    {'1': 'offline', '2': 0},
    {'1': 'inGame', '2': 1},
    {'1': 'inLobby', '2': 2},
    {'1': 'online', '2': 3},
  ],
};

/// Descriptor for `FriendState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List friendStateDescriptor = $convert.base64Decode(
    'CgtGcmllbmRTdGF0ZRILCgdvZmZsaW5lEAASCgoGaW5HYW1lEAESCwoHaW5Mb2JieRACEgoKBm'
    '9ubGluZRAD');

@$core.Deprecated('Use friendDescriptor instead')
const Friend$json = {
  '1': 'Friend',
  '2': [
    {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'score', '3': 3, '4': 1, '5': 5, '10': 'score'},
    {'1': 'state', '3': 4, '4': 1, '5': 14, '6': '.friend.FriendState', '10': 'state'},
  ],
};

/// Descriptor for `Friend`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendDescriptor = $convert.base64Decode(
    'CgZGcmllbmQSEgoEdXVpZBgBIAEoCVIEdXVpZBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBXNjb3'
    'JlGAMgASgFUgVzY29yZRIpCgVzdGF0ZRgEIAEoDjITLmZyaWVuZC5GcmllbmRTdGF0ZVIFc3Rh'
    'dGU=');

