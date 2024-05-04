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

import 'game.pbenum.dart';

export 'game.pbenum.dart';

class StartGameRequest extends $pb.GeneratedMessage {
  factory StartGameRequest({
    $core.String? gameId,
    $core.String? token,
  }) {
    final $result = create();
    if (gameId != null) {
      $result.gameId = gameId;
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  StartGameRequest._() : super();
  factory StartGameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartGameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StartGameRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'gameId')
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartGameRequest clone() => StartGameRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartGameRequest copyWith(void Function(StartGameRequest) updates) => super.copyWith((message) => updates(message as StartGameRequest)) as StartGameRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartGameRequest create() => StartGameRequest._();
  StartGameRequest createEmptyInstance() => create();
  static $pb.PbList<StartGameRequest> createRepeated() => $pb.PbList<StartGameRequest>();
  @$core.pragma('dart2js:noInline')
  static StartGameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartGameRequest>(create);
  static StartGameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get gameId => $_getSZ(0);
  @$pb.TagNumber(1)
  set gameId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearToken() => clearField(2);
}

class GetPlayerStateRequest extends $pb.GeneratedMessage {
  factory GetPlayerStateRequest({
    $core.String? gameId,
    $core.String? token,
  }) {
    final $result = create();
    if (gameId != null) {
      $result.gameId = gameId;
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  GetPlayerStateRequest._() : super();
  factory GetPlayerStateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlayerStateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPlayerStateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'gameId')
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlayerStateRequest clone() => GetPlayerStateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlayerStateRequest copyWith(void Function(GetPlayerStateRequest) updates) => super.copyWith((message) => updates(message as GetPlayerStateRequest)) as GetPlayerStateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPlayerStateRequest create() => GetPlayerStateRequest._();
  GetPlayerStateRequest createEmptyInstance() => create();
  static $pb.PbList<GetPlayerStateRequest> createRepeated() => $pb.PbList<GetPlayerStateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPlayerStateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlayerStateRequest>(create);
  static GetPlayerStateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get gameId => $_getSZ(0);
  @$pb.TagNumber(1)
  set gameId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearToken() => clearField(2);
}

class GetStackStateRequest extends $pb.GeneratedMessage {
  factory GetStackStateRequest({
    $core.String? gameId,
    $core.String? token,
  }) {
    final $result = create();
    if (gameId != null) {
      $result.gameId = gameId;
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  GetStackStateRequest._() : super();
  factory GetStackStateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStackStateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStackStateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'gameId')
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStackStateRequest clone() => GetStackStateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStackStateRequest copyWith(void Function(GetStackStateRequest) updates) => super.copyWith((message) => updates(message as GetStackStateRequest)) as GetStackStateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStackStateRequest create() => GetStackStateRequest._();
  GetStackStateRequest createEmptyInstance() => create();
  static $pb.PbList<GetStackStateRequest> createRepeated() => $pb.PbList<GetStackStateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStackStateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStackStateRequest>(create);
  static GetStackStateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get gameId => $_getSZ(0);
  @$pb.TagNumber(1)
  set gameId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearToken() => clearField(2);
}

class GameState extends $pb.GeneratedMessage {
  factory GameState({
    $core.String? currentPlayer,
    Card? cardOnTopOfDiscard,
  }) {
    final $result = create();
    if (currentPlayer != null) {
      $result.currentPlayer = currentPlayer;
    }
    if (cardOnTopOfDiscard != null) {
      $result.cardOnTopOfDiscard = cardOnTopOfDiscard;
    }
    return $result;
  }
  GameState._() : super();
  factory GameState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GameState', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currentPlayer')
    ..aOM<Card>(2, _omitFieldNames ? '' : 'cardOnTopOfDiscard', subBuilder: Card.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GameState clone() => GameState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GameState copyWith(void Function(GameState) updates) => super.copyWith((message) => updates(message as GameState)) as GameState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GameState create() => GameState._();
  GameState createEmptyInstance() => create();
  static $pb.PbList<GameState> createRepeated() => $pb.PbList<GameState>();
  @$core.pragma('dart2js:noInline')
  static GameState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameState>(create);
  static GameState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currentPlayer => $_getSZ(0);
  @$pb.TagNumber(1)
  set currentPlayer($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPlayer() => clearField(1);

  @$pb.TagNumber(2)
  Card get cardOnTopOfDiscard => $_getN(1);
  @$pb.TagNumber(2)
  set cardOnTopOfDiscard(Card v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardOnTopOfDiscard() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardOnTopOfDiscard() => clearField(2);
  @$pb.TagNumber(2)
  Card ensureCardOnTopOfDiscard() => $_ensure(1);
}

class PlayerState extends $pb.GeneratedMessage {
  factory PlayerState({
    $core.Iterable<Card>? hand,
    Alert? alert,
  }) {
    final $result = create();
    if (hand != null) {
      $result.hand.addAll(hand);
    }
    if (alert != null) {
      $result.alert = alert;
    }
    return $result;
  }
  PlayerState._() : super();
  factory PlayerState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayerState', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Card>(1, _omitFieldNames ? '' : 'hand', $pb.PbFieldType.PM, subBuilder: Card.create)
    ..aOM<Alert>(2, _omitFieldNames ? '' : 'alert', subBuilder: Alert.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlayerState clone() => PlayerState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlayerState copyWith(void Function(PlayerState) updates) => super.copyWith((message) => updates(message as PlayerState)) as PlayerState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerState create() => PlayerState._();
  PlayerState createEmptyInstance() => create();
  static $pb.PbList<PlayerState> createRepeated() => $pb.PbList<PlayerState>();
  @$core.pragma('dart2js:noInline')
  static PlayerState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerState>(create);
  static PlayerState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Card> get hand => $_getList(0);

  @$pb.TagNumber(2)
  Alert get alert => $_getN(1);
  @$pb.TagNumber(2)
  set alert(Alert v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAlert() => $_has(1);
  @$pb.TagNumber(2)
  void clearAlert() => clearField(2);
  @$pb.TagNumber(2)
  Alert ensureAlert() => $_ensure(1);
}

class StackState extends $pb.GeneratedMessage {
  factory StackState({
    PlaceStackState? placeStack,
    DrawStackState? drawStack,
    StackState_Direction? direction,
  }) {
    final $result = create();
    if (placeStack != null) {
      $result.placeStack = placeStack;
    }
    if (drawStack != null) {
      $result.drawStack = drawStack;
    }
    if (direction != null) {
      $result.direction = direction;
    }
    return $result;
  }
  StackState._() : super();
  factory StackState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StackState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StackState', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PlaceStackState>(1, _omitFieldNames ? '' : 'placeStack', subBuilder: PlaceStackState.create)
    ..aOM<DrawStackState>(2, _omitFieldNames ? '' : 'drawStack', subBuilder: DrawStackState.create)
    ..e<StackState_Direction>(3, _omitFieldNames ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: StackState_Direction.CLOCKWISE, valueOf: StackState_Direction.valueOf, enumValues: StackState_Direction.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StackState clone() => StackState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StackState copyWith(void Function(StackState) updates) => super.copyWith((message) => updates(message as StackState)) as StackState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StackState create() => StackState._();
  StackState createEmptyInstance() => create();
  static $pb.PbList<StackState> createRepeated() => $pb.PbList<StackState>();
  @$core.pragma('dart2js:noInline')
  static StackState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StackState>(create);
  static StackState? _defaultInstance;

  @$pb.TagNumber(1)
  PlaceStackState get placeStack => $_getN(0);
  @$pb.TagNumber(1)
  set placeStack(PlaceStackState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlaceStack() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlaceStack() => clearField(1);
  @$pb.TagNumber(1)
  PlaceStackState ensurePlaceStack() => $_ensure(0);

  @$pb.TagNumber(2)
  DrawStackState get drawStack => $_getN(1);
  @$pb.TagNumber(2)
  set drawStack(DrawStackState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDrawStack() => $_has(1);
  @$pb.TagNumber(2)
  void clearDrawStack() => clearField(2);
  @$pb.TagNumber(2)
  DrawStackState ensureDrawStack() => $_ensure(1);

  @$pb.TagNumber(3)
  StackState_Direction get direction => $_getN(2);
  @$pb.TagNumber(3)
  set direction(StackState_Direction v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDirection() => $_has(2);
  @$pb.TagNumber(3)
  void clearDirection() => clearField(3);
}

class PlayerAction extends $pb.GeneratedMessage {
  factory PlayerAction({
    PlayerAction_ActionType? action,
    $core.String? cardId,
  }) {
    final $result = create();
    if (action != null) {
      $result.action = action;
    }
    if (cardId != null) {
      $result.cardId = cardId;
    }
    return $result;
  }
  PlayerAction._() : super();
  factory PlayerAction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerAction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayerAction', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..e<PlayerAction_ActionType>(1, _omitFieldNames ? '' : 'action', $pb.PbFieldType.OE, defaultOrMaker: PlayerAction_ActionType.DRAW, valueOf: PlayerAction_ActionType.valueOf, enumValues: PlayerAction_ActionType.values)
    ..aOS(2, _omitFieldNames ? '' : 'cardId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlayerAction clone() => PlayerAction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlayerAction copyWith(void Function(PlayerAction) updates) => super.copyWith((message) => updates(message as PlayerAction)) as PlayerAction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerAction create() => PlayerAction._();
  PlayerAction createEmptyInstance() => create();
  static $pb.PbList<PlayerAction> createRepeated() => $pb.PbList<PlayerAction>();
  @$core.pragma('dart2js:noInline')
  static PlayerAction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerAction>(create);
  static PlayerAction? _defaultInstance;

  @$pb.TagNumber(1)
  PlayerAction_ActionType get action => $_getN(0);
  @$pb.TagNumber(1)
  set action(PlayerAction_ActionType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardId() => clearField(2);
}

class Alert extends $pb.GeneratedMessage {
  factory Alert({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  Alert._() : super();
  factory Alert.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Alert.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Alert', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Alert clone() => Alert()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Alert copyWith(void Function(Alert) updates) => super.copyWith((message) => updates(message as Alert)) as Alert;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Alert create() => Alert._();
  Alert createEmptyInstance() => create();
  static $pb.PbList<Alert> createRepeated() => $pb.PbList<Alert>();
  @$core.pragma('dart2js:noInline')
  static Alert getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Alert>(create);
  static Alert? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Card', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlaceStackState', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
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
    $core.Iterable<Card>? cards,
  }) {
    final $result = create();
    if (stackId != null) {
      $result.stackId = stackId;
    }
    if (cards != null) {
      $result.cards.addAll(cards);
    }
    return $result;
  }
  DrawStackState._() : super();
  factory DrawStackState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DrawStackState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DrawStackState', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'stackId', $pb.PbFieldType.O3)
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

  @$pb.TagNumber(4)
  $core.List<Card> get cards => $_getList(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
