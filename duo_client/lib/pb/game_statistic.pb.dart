//
//  Generated code. Do not modify.
//  source: game_statistic.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $7;

class PlayerBoardItem extends $pb.GeneratedMessage {
  factory PlayerBoardItem({
    $core.int? rank,
    $core.String? name,
  }) {
    final $result = create();
    if (rank != null) {
      $result.rank = rank;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  PlayerBoardItem._() : super();
  factory PlayerBoardItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerBoardItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayerBoardItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'gameStatistic'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'rank', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlayerBoardItem clone() => PlayerBoardItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlayerBoardItem copyWith(void Function(PlayerBoardItem) updates) => super.copyWith((message) => updates(message as PlayerBoardItem)) as PlayerBoardItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerBoardItem create() => PlayerBoardItem._();
  PlayerBoardItem createEmptyInstance() => create();
  static $pb.PbList<PlayerBoardItem> createRepeated() => $pb.PbList<PlayerBoardItem>();
  @$core.pragma('dart2js:noInline')
  static PlayerBoardItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerBoardItem>(create);
  static PlayerBoardItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get rank => $_getIZ(0);
  @$pb.TagNumber(1)
  set rank($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRank() => $_has(0);
  @$pb.TagNumber(1)
  void clearRank() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class GameStatistic extends $pb.GeneratedMessage {
  factory GameStatistic({
    $core.String? uuid,
    $7.Timestamp? playedAt,
    $core.int? scoreBilance,
    $core.Iterable<PlayerBoardItem>? playerBoard,
    $core.String? gameTitle,
  }) {
    final $result = create();
    if (uuid != null) {
      $result.uuid = uuid;
    }
    if (playedAt != null) {
      $result.playedAt = playedAt;
    }
    if (scoreBilance != null) {
      $result.scoreBilance = scoreBilance;
    }
    if (playerBoard != null) {
      $result.playerBoard.addAll(playerBoard);
    }
    if (gameTitle != null) {
      $result.gameTitle = gameTitle;
    }
    return $result;
  }
  GameStatistic._() : super();
  factory GameStatistic.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameStatistic.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GameStatistic', package: const $pb.PackageName(_omitMessageNames ? '' : 'gameStatistic'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uuid')
    ..aOM<$7.Timestamp>(2, _omitFieldNames ? '' : 'playedAt', protoName: 'playedAt', subBuilder: $7.Timestamp.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'scoreBilance', $pb.PbFieldType.O3, protoName: 'scoreBilance')
    ..pc<PlayerBoardItem>(4, _omitFieldNames ? '' : 'playerBoard', $pb.PbFieldType.PM, protoName: 'playerBoard', subBuilder: PlayerBoardItem.create)
    ..aOS(5, _omitFieldNames ? '' : 'gameTitle', protoName: 'gameTitle')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GameStatistic clone() => GameStatistic()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GameStatistic copyWith(void Function(GameStatistic) updates) => super.copyWith((message) => updates(message as GameStatistic)) as GameStatistic;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GameStatistic create() => GameStatistic._();
  GameStatistic createEmptyInstance() => create();
  static $pb.PbList<GameStatistic> createRepeated() => $pb.PbList<GameStatistic>();
  @$core.pragma('dart2js:noInline')
  static GameStatistic getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameStatistic>(create);
  static GameStatistic? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);

  @$pb.TagNumber(2)
  $7.Timestamp get playedAt => $_getN(1);
  @$pb.TagNumber(2)
  set playedAt($7.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlayedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlayedAt() => clearField(2);
  @$pb.TagNumber(2)
  $7.Timestamp ensurePlayedAt() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get scoreBilance => $_getIZ(2);
  @$pb.TagNumber(3)
  set scoreBilance($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasScoreBilance() => $_has(2);
  @$pb.TagNumber(3)
  void clearScoreBilance() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<PlayerBoardItem> get playerBoard => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get gameTitle => $_getSZ(4);
  @$pb.TagNumber(5)
  set gameTitle($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGameTitle() => $_has(4);
  @$pb.TagNumber(5)
  void clearGameTitle() => clearField(5);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
