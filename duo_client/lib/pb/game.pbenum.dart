//
//  Generated code. Do not modify.
//  source: game.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Direction extends $pb.ProtobufEnum {
  static const Direction CLOCKWISE = Direction._(0, _omitEnumNames ? '' : 'CLOCKWISE');
  static const Direction COUNTER_CLOCKWISE = Direction._(1, _omitEnumNames ? '' : 'COUNTER_CLOCKWISE');

  static const $core.List<Direction> values = <Direction> [
    CLOCKWISE,
    COUNTER_CLOCKWISE,
  ];

  static final $core.Map<$core.int, Direction> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Direction? valueOf($core.int value) => _byValue[value];

  const Direction._($core.int v, $core.String n) : super(v, n);
}

class PlayerAction_ActionType extends $pb.ProtobufEnum {
  static const PlayerAction_ActionType DRAW = PlayerAction_ActionType._(0, _omitEnumNames ? '' : 'DRAW');
  static const PlayerAction_ActionType PLACE = PlayerAction_ActionType._(1, _omitEnumNames ? '' : 'PLACE');
  static const PlayerAction_ActionType SKIP = PlayerAction_ActionType._(2, _omitEnumNames ? '' : 'SKIP');
  static const PlayerAction_ActionType INIT = PlayerAction_ActionType._(3, _omitEnumNames ? '' : 'INIT');

  static const $core.List<PlayerAction_ActionType> values = <PlayerAction_ActionType> [
    DRAW,
    PLACE,
    SKIP,
    INIT,
  ];

  static final $core.Map<$core.int, PlayerAction_ActionType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PlayerAction_ActionType? valueOf($core.int value) => _byValue[value];

  const PlayerAction_ActionType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
