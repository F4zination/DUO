//
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'score', '3': 3, '4': 1, '5': 9, '10': 'score'},
    {'1': 'is_admin', '3': 4, '4': 1, '5': 8, '10': 'isAdmin'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEhIKBHV1aWQYASABKAlSBHV1aWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIUCgVzY29yZR'
    'gDIAEoCVIFc2NvcmUSGQoIaXNfYWRtaW4YBCABKAhSB2lzQWRtaW4=');

