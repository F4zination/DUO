//
//  Generated code. Do not modify.
//  source: auth_messages.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use registerRequestDescriptor instead')
const RegisterRequest$json = {
  '1': 'RegisterRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'public_key', '3': 2, '4': 1, '5': 9, '10': 'publicKey'},
  ],
};

/// Descriptor for `RegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerRequestDescriptor = $convert.base64Decode(
    'Cg9SZWdpc3RlclJlcXVlc3QSGgoIdXNlcm5hbWUYASABKAlSCHVzZXJuYW1lEh0KCnB1YmxpY1'
    '9rZXkYAiABKAlSCXB1YmxpY0tleQ==');

@$core.Deprecated('Use registerResponseDescriptor instead')
const RegisterResponse$json = {
  '1': 'RegisterResponse',
  '2': [
    {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'auth_token', '3': 2, '4': 1, '5': 9, '10': 'authToken'},
  ],
};

/// Descriptor for `RegisterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerResponseDescriptor = $convert.base64Decode(
    'ChBSZWdpc3RlclJlc3BvbnNlEhIKBHV1aWQYASABKAlSBHV1aWQSHQoKYXV0aF90b2tlbhgCIA'
    'EoCVIJYXV0aFRva2Vu');

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode(
    'CgxMb2dpblJlcXVlc3QSEgoEdXVpZBgBIAEoCVIEdXVpZA==');

@$core.Deprecated('Use loginChallengeRequestDescriptor instead')
const LoginChallengeRequest$json = {
  '1': 'LoginChallengeRequest',
  '2': [
    {'1': 'challenge', '3': 1, '4': 1, '5': 9, '10': 'challenge'},
  ],
};

/// Descriptor for `LoginChallengeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginChallengeRequestDescriptor = $convert.base64Decode(
    'ChVMb2dpbkNoYWxsZW5nZVJlcXVlc3QSHAoJY2hhbGxlbmdlGAEgASgJUgljaGFsbGVuZ2U=');

@$core.Deprecated('Use loginChallengeResponseDescriptor instead')
const LoginChallengeResponse$json = {
  '1': 'LoginChallengeResponse',
  '2': [
    {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'decryptedChallenge', '3': 2, '4': 1, '5': 9, '10': 'decryptedChallenge'},
  ],
};

/// Descriptor for `LoginChallengeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginChallengeResponseDescriptor = $convert.base64Decode(
    'ChZMb2dpbkNoYWxsZW5nZVJlc3BvbnNlEhIKBHV1aWQYASABKAlSBHV1aWQSLgoSZGVjcnlwdG'
    'VkQ2hhbGxlbmdlGAIgASgJUhJkZWNyeXB0ZWRDaGFsbGVuZ2U=');

@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = {
  '1': 'LoginResponse',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'expires_at', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode(
    'Cg1Mb2dpblJlc3BvbnNlEhQKBXRva2VuGAEgASgJUgV0b2tlbhI5CgpleHBpcmVzX2F0GAIgAS'
    'gLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJZXhwaXJlc0F0');

