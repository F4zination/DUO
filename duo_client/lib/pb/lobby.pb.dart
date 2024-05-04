//
//  Generated code. Do not modify.
//  source: lobby.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $5;

class LobbyStatus extends $pb.GeneratedMessage {
  factory LobbyStatus({
    $core.Iterable<$5.User>? users,
    $core.bool? isStarting,
    $core.int? lobbyId,
    $core.int? maxPlayers,
  }) {
    final $result = create();
    if (users != null) {
      $result.users.addAll(users);
    }
    if (isStarting != null) {
      $result.isStarting = isStarting;
    }
    if (lobbyId != null) {
      $result.lobbyId = lobbyId;
    }
    if (maxPlayers != null) {
      $result.maxPlayers = maxPlayers;
    }
    return $result;
  }
  LobbyStatus._() : super();
  factory LobbyStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LobbyStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LobbyStatus', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<$5.User>(1, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM, subBuilder: $5.User.create)
    ..aOB(2, _omitFieldNames ? '' : 'isStarting', protoName: 'isStarting')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'lobbyId', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'maxPlayers', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LobbyStatus clone() => LobbyStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LobbyStatus copyWith(void Function(LobbyStatus) updates) => super.copyWith((message) => updates(message as LobbyStatus)) as LobbyStatus;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LobbyStatus create() => LobbyStatus._();
  LobbyStatus createEmptyInstance() => create();
  static $pb.PbList<LobbyStatus> createRepeated() => $pb.PbList<LobbyStatus>();
  @$core.pragma('dart2js:noInline')
  static LobbyStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LobbyStatus>(create);
  static LobbyStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$5.User> get users => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get isStarting => $_getBF(1);
  @$pb.TagNumber(2)
  set isStarting($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsStarting() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsStarting() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get lobbyId => $_getIZ(2);
  @$pb.TagNumber(3)
  set lobbyId($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLobbyId() => $_has(2);
  @$pb.TagNumber(3)
  void clearLobbyId() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get maxPlayers => $_getIZ(3);
  @$pb.TagNumber(4)
  set maxPlayers($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaxPlayers() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxPlayers() => clearField(4);
}

class CreateLobbyRequest extends $pb.GeneratedMessage {
  factory CreateLobbyRequest({
    $core.String? token,
    $core.int? maxPlayers,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (maxPlayers != null) {
      $result.maxPlayers = maxPlayers;
    }
    return $result;
  }
  CreateLobbyRequest._() : super();
  factory CreateLobbyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLobbyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateLobbyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'maxPlayers', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLobbyRequest clone() => CreateLobbyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLobbyRequest copyWith(void Function(CreateLobbyRequest) updates) => super.copyWith((message) => updates(message as CreateLobbyRequest)) as CreateLobbyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLobbyRequest create() => CreateLobbyRequest._();
  CreateLobbyRequest createEmptyInstance() => create();
  static $pb.PbList<CreateLobbyRequest> createRepeated() => $pb.PbList<CreateLobbyRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateLobbyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateLobbyRequest>(create);
  static CreateLobbyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get maxPlayers => $_getIZ(1);
  @$pb.TagNumber(2)
  set maxPlayers($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMaxPlayers() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxPlayers() => clearField(2);
}

class JoinLobbyRequest extends $pb.GeneratedMessage {
  factory JoinLobbyRequest({
    $core.String? token,
    $core.int? lobbyId,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (lobbyId != null) {
      $result.lobbyId = lobbyId;
    }
    return $result;
  }
  JoinLobbyRequest._() : super();
  factory JoinLobbyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JoinLobbyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JoinLobbyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'lobbyId', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JoinLobbyRequest clone() => JoinLobbyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JoinLobbyRequest copyWith(void Function(JoinLobbyRequest) updates) => super.copyWith((message) => updates(message as JoinLobbyRequest)) as JoinLobbyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinLobbyRequest create() => JoinLobbyRequest._();
  JoinLobbyRequest createEmptyInstance() => create();
  static $pb.PbList<JoinLobbyRequest> createRepeated() => $pb.PbList<JoinLobbyRequest>();
  @$core.pragma('dart2js:noInline')
  static JoinLobbyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinLobbyRequest>(create);
  static JoinLobbyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get lobbyId => $_getIZ(1);
  @$pb.TagNumber(2)
  set lobbyId($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLobbyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLobbyId() => clearField(2);
}

class DisconnectLobbyRequest extends $pb.GeneratedMessage {
  factory DisconnectLobbyRequest({
    $core.String? token,
    $core.int? lobbyId,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (lobbyId != null) {
      $result.lobbyId = lobbyId;
    }
    return $result;
  }
  DisconnectLobbyRequest._() : super();
  factory DisconnectLobbyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectLobbyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisconnectLobbyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'lobbyId', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectLobbyRequest clone() => DisconnectLobbyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectLobbyRequest copyWith(void Function(DisconnectLobbyRequest) updates) => super.copyWith((message) => updates(message as DisconnectLobbyRequest)) as DisconnectLobbyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisconnectLobbyRequest create() => DisconnectLobbyRequest._();
  DisconnectLobbyRequest createEmptyInstance() => create();
  static $pb.PbList<DisconnectLobbyRequest> createRepeated() => $pb.PbList<DisconnectLobbyRequest>();
  @$core.pragma('dart2js:noInline')
  static DisconnectLobbyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisconnectLobbyRequest>(create);
  static DisconnectLobbyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get lobbyId => $_getIZ(1);
  @$pb.TagNumber(2)
  set lobbyId($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLobbyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLobbyId() => clearField(2);
}

class DisconnectLobbyResponse extends $pb.GeneratedMessage {
  factory DisconnectLobbyResponse({
    $core.bool? success,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  DisconnectLobbyResponse._() : super();
  factory DisconnectLobbyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectLobbyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisconnectLobbyResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectLobbyResponse clone() => DisconnectLobbyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectLobbyResponse copyWith(void Function(DisconnectLobbyResponse) updates) => super.copyWith((message) => updates(message as DisconnectLobbyResponse)) as DisconnectLobbyResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisconnectLobbyResponse create() => DisconnectLobbyResponse._();
  DisconnectLobbyResponse createEmptyInstance() => create();
  static $pb.PbList<DisconnectLobbyResponse> createRepeated() => $pb.PbList<DisconnectLobbyResponse>();
  @$core.pragma('dart2js:noInline')
  static DisconnectLobbyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisconnectLobbyResponse>(create);
  static DisconnectLobbyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
