//
//  Generated code. Do not modify.
//  source: notification.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class NotificationType extends $pb.ProtobufEnum {
  static const NotificationType FRIEND_REQUEST = NotificationType._(0, _omitEnumNames ? '' : 'FRIEND_REQUEST');
  static const NotificationType SIMPLE_MESSAGE = NotificationType._(1, _omitEnumNames ? '' : 'SIMPLE_MESSAGE');

  static const $core.List<NotificationType> values = <NotificationType> [
    FRIEND_REQUEST,
    SIMPLE_MESSAGE,
  ];

  static final $core.Map<$core.int, NotificationType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NotificationType? valueOf($core.int value) => _byValue[value];

  const NotificationType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
