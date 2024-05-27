//
//  Generated code. Do not modify.
//  source: notification.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use notificationTypeDescriptor instead')
const NotificationType$json = {
  '1': 'NotificationType',
  '2': [
    {'1': 'FRIEND_REQUEST', '2': 0},
    {'1': 'SIMPLE_MESSAGE', '2': 1},
  ],
};

/// Descriptor for `NotificationType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List notificationTypeDescriptor = $convert.base64Decode(
    'ChBOb3RpZmljYXRpb25UeXBlEhIKDkZSSUVORF9SRVFVRVNUEAASEgoOU0lNUExFX01FU1NBR0'
    'UQAQ==');

@$core.Deprecated('Use notificationDescriptor instead')
const Notification$json = {
  '1': 'Notification',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.pb.NotificationType', '10': 'type'},
    {'1': 'data', '3': 2, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `Notification`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationDescriptor = $convert.base64Decode(
    'CgxOb3RpZmljYXRpb24SKAoEdHlwZRgBIAEoDjIULnBiLk5vdGlmaWNhdGlvblR5cGVSBHR5cG'
    'USEgoEZGF0YRgCIAEoCVIEZGF0YQ==');

