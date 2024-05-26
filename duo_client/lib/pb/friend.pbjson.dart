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
    {'1': 'state', '3': 4, '4': 1, '5': 14, '6': '.pb.FriendState', '10': 'state'},
  ],
};

/// Descriptor for `Friend`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendDescriptor = $convert.base64Decode(
    'CgZGcmllbmQSEgoEdXVpZBgBIAEoCVIEdXVpZBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBXNjb3'
    'JlGAMgASgFUgVzY29yZRIlCgVzdGF0ZRgEIAEoDjIPLnBiLkZyaWVuZFN0YXRlUgVzdGF0ZQ==');

@$core.Deprecated('Use friendListDescriptor instead')
const FriendList$json = {
  '1': 'FriendList',
  '2': [
    {'1': 'friends', '3': 2, '4': 3, '5': 11, '6': '.pb.Friend', '10': 'friends'},
  ],
};

/// Descriptor for `FriendList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendListDescriptor = $convert.base64Decode(
    'CgpGcmllbmRMaXN0EiQKB2ZyaWVuZHMYAiADKAsyCi5wYi5GcmllbmRSB2ZyaWVuZHM=');

@$core.Deprecated('Use friendRequestRequestDescriptor instead')
const FriendRequestRequest$json = {
  '1': 'FriendRequestRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'target_id', '3': 2, '4': 1, '5': 9, '10': 'targetId'},
    {'1': 'requester_name', '3': 3, '4': 1, '5': 9, '10': 'requesterName'},
  ],
};

/// Descriptor for `FriendRequestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendRequestRequestDescriptor = $convert.base64Decode(
    'ChRGcmllbmRSZXF1ZXN0UmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SGwoJdGFyZ2V0X2'
    'lkGAIgASgJUgh0YXJnZXRJZBIlCg5yZXF1ZXN0ZXJfbmFtZRgDIAEoCVINcmVxdWVzdGVyTmFt'
    'ZQ==');

@$core.Deprecated('Use friendRequestDescriptor instead')
const FriendRequest$json = {
  '1': 'FriendRequest',
  '2': [
    {'1': 'requester_uuid', '3': 1, '4': 1, '5': 9, '10': 'requesterUuid'},
    {'1': 'requester_name', '3': 2, '4': 1, '5': 9, '10': 'requesterName'},
    {'1': 'target_uuid', '3': 3, '4': 1, '5': 9, '10': 'targetUuid'},
  ],
};

/// Descriptor for `FriendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendRequestDescriptor = $convert.base64Decode(
    'Cg1GcmllbmRSZXF1ZXN0EiUKDnJlcXVlc3Rlcl91dWlkGAEgASgJUg1yZXF1ZXN0ZXJVdWlkEi'
    'UKDnJlcXVlc3Rlcl9uYW1lGAIgASgJUg1yZXF1ZXN0ZXJOYW1lEh8KC3RhcmdldF91dWlkGAMg'
    'ASgJUgp0YXJnZXRVdWlk');

@$core.Deprecated('Use friendRequestListDescriptor instead')
const FriendRequestList$json = {
  '1': 'FriendRequestList',
  '2': [
    {'1': 'requests', '3': 2, '4': 3, '5': 11, '6': '.pb.FriendRequest', '10': 'requests'},
  ],
};

/// Descriptor for `FriendRequestList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendRequestListDescriptor = $convert.base64Decode(
    'ChFGcmllbmRSZXF1ZXN0TGlzdBItCghyZXF1ZXN0cxgCIAMoCzIRLnBiLkZyaWVuZFJlcXVlc3'
    'RSCHJlcXVlc3Rz');

@$core.Deprecated('Use friendRequestResponseDescriptor instead')
const FriendRequestResponse$json = {
  '1': 'FriendRequestResponse',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'requester_id', '3': 2, '4': 1, '5': 9, '10': 'requesterId'},
    {'1': 'accept', '3': 3, '4': 1, '5': 8, '10': 'accept'},
  ],
};

/// Descriptor for `FriendRequestResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendRequestResponseDescriptor = $convert.base64Decode(
    'ChVGcmllbmRSZXF1ZXN0UmVzcG9uc2USFAoFdG9rZW4YASABKAlSBXRva2VuEiEKDHJlcXVlc3'
    'Rlcl9pZBgCIAEoCVILcmVxdWVzdGVySWQSFgoGYWNjZXB0GAMgASgIUgZhY2NlcHQ=');

@$core.Deprecated('Use deleteFriendRequestDescriptor instead')
const DeleteFriendRequest$json = {
  '1': 'DeleteFriendRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'target_id', '3': 2, '4': 1, '5': 9, '10': 'targetId'},
  ],
};

/// Descriptor for `DeleteFriendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteFriendRequestDescriptor = $convert.base64Decode(
    'ChNEZWxldGVGcmllbmRSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIbCgl0YXJnZXRfaW'
    'QYAiABKAlSCHRhcmdldElk');

