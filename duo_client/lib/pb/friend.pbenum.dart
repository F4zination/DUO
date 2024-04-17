//
//  Generated code. Do not modify.
//  source: friend.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class FriendState extends $pb.ProtobufEnum {
  static const FriendState offline = FriendState._(0, _omitEnumNames ? '' : 'offline');
  static const FriendState inGame = FriendState._(1, _omitEnumNames ? '' : 'inGame');
  static const FriendState inLobby = FriendState._(2, _omitEnumNames ? '' : 'inLobby');
  static const FriendState online = FriendState._(3, _omitEnumNames ? '' : 'online');

  static const $core.List<FriendState> values = <FriendState> [
    offline,
    inGame,
    inLobby,
    online,
  ];

  static final $core.Map<$core.int, FriendState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FriendState? valueOf($core.int value) => _byValue[value];

  const FriendState._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
