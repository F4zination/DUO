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

class Card extends $pb.GeneratedMessage {
  factory Card({
    $core.String? cardId,
    $core.bool? isFaceUp,
  }) {
    final $result = create();
    if (cardId != null) {
      $result.cardId = cardId;
    }
    if (isFaceUp != null) {
      $result.isFaceUp = isFaceUp;
    }
    return $result;
  }
  Card._() : super();
  factory Card.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Card.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Card', package: const $pb.PackageName(_omitMessageNames ? '' : 'game'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardId')
    ..aOB(2, _omitFieldNames ? '' : 'isFaceUp')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Card clone() => Card()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Card copyWith(void Function(Card) updates) => super.copyWith((message) => updates(message as Card)) as Card;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Card create() => Card._();
  Card createEmptyInstance() => create();
  static $pb.PbList<Card> createRepeated() => $pb.PbList<Card>();
  @$core.pragma('dart2js:noInline')
  static Card getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Card>(create);
  static Card? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isFaceUp => $_getBF(1);
  @$pb.TagNumber(2)
  set isFaceUp($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsFaceUp() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsFaceUp() => clearField(2);
}

class PlaceStackState extends $pb.GeneratedMessage {
  factory PlaceStackState({
    $core.int? amountCards,
    Card? cardOnTop,
  }) {
    final $result = create();
    if (amountCards != null) {
      $result.amountCards = amountCards;
    }
    if (cardOnTop != null) {
      $result.cardOnTop = cardOnTop;
    }
    return $result;
  }
  PlaceStackState._() : super();
  factory PlaceStackState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlaceStackState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlaceStackState', package: const $pb.PackageName(_omitMessageNames ? '' : 'game'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'amountCards', $pb.PbFieldType.O3)
    ..aOM<Card>(2, _omitFieldNames ? '' : 'cardOnTop', subBuilder: Card.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlaceStackState clone() => PlaceStackState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlaceStackState copyWith(void Function(PlaceStackState) updates) => super.copyWith((message) => updates(message as PlaceStackState)) as PlaceStackState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlaceStackState create() => PlaceStackState._();
  PlaceStackState createEmptyInstance() => create();
  static $pb.PbList<PlaceStackState> createRepeated() => $pb.PbList<PlaceStackState>();
  @$core.pragma('dart2js:noInline')
  static PlaceStackState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlaceStackState>(create);
  static PlaceStackState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get amountCards => $_getIZ(0);
  @$pb.TagNumber(1)
  set amountCards($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmountCards() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmountCards() => clearField(1);

  @$pb.TagNumber(2)
  Card get cardOnTop => $_getN(1);
  @$pb.TagNumber(2)
  set cardOnTop(Card v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardOnTop() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardOnTop() => clearField(2);
  @$pb.TagNumber(2)
  Card ensureCardOnTop() => $_ensure(1);
}

class DrawStackState extends $pb.GeneratedMessage {
  factory DrawStackState({
    $core.int? stackId,
    $core.int? stackSize,
    $core.int? stackType,
    $core.Iterable<Card>? cards,
  }) {
    final $result = create();
    if (stackId != null) {
      $result.stackId = stackId;
    }
    if (stackSize != null) {
      $result.stackSize = stackSize;
    }
    if (stackType != null) {
      $result.stackType = stackType;
    }
    if (cards != null) {
      $result.cards.addAll(cards);
    }
    return $result;
  }
  DrawStackState._() : super();
  factory DrawStackState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DrawStackState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DrawStackState', package: const $pb.PackageName(_omitMessageNames ? '' : 'game'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'stackId', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'stackSize', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'stackType', $pb.PbFieldType.O3)
    ..pc<Card>(4, _omitFieldNames ? '' : 'cards', $pb.PbFieldType.PM, subBuilder: Card.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DrawStackState clone() => DrawStackState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DrawStackState copyWith(void Function(DrawStackState) updates) => super.copyWith((message) => updates(message as DrawStackState)) as DrawStackState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DrawStackState create() => DrawStackState._();
  DrawStackState createEmptyInstance() => create();
  static $pb.PbList<DrawStackState> createRepeated() => $pb.PbList<DrawStackState>();
  @$core.pragma('dart2js:noInline')
  static DrawStackState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DrawStackState>(create);
  static DrawStackState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get stackId => $_getIZ(0);
  @$pb.TagNumber(1)
  set stackId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStackId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStackId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get stackSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set stackSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStackSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearStackSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get stackType => $_getIZ(2);
  @$pb.TagNumber(3)
  set stackType($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStackType() => $_has(2);
  @$pb.TagNumber(3)
  void clearStackType() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<Card> get cards => $_getList(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
