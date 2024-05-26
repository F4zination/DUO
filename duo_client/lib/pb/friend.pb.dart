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

import 'friend.pbenum.dart';

export 'friend.pbenum.dart';

class Friend extends $pb.GeneratedMessage {
  factory Friend({
    $core.String? uuid,
    $core.String? name,
    $core.int? score,
    FriendState? state,
  }) {
    final $result = create();
    if (uuid != null) {
      $result.uuid = uuid;
    }
    if (name != null) {
      $result.name = name;
    }
    if (score != null) {
      $result.score = score;
    }
    if (state != null) {
      $result.state = state;
    }
    return $result;
  }
  Friend._() : super();
  factory Friend.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Friend.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Friend', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uuid')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'score', $pb.PbFieldType.O3)
    ..e<FriendState>(4, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: FriendState.offline, valueOf: FriendState.valueOf, enumValues: FriendState.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Friend clone() => Friend()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Friend copyWith(void Function(Friend) updates) => super.copyWith((message) => updates(message as Friend)) as Friend;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Friend create() => Friend._();
  Friend createEmptyInstance() => create();
  static $pb.PbList<Friend> createRepeated() => $pb.PbList<Friend>();
  @$core.pragma('dart2js:noInline')
  static Friend getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Friend>(create);
  static Friend? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get score => $_getIZ(2);
  @$pb.TagNumber(3)
  set score($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearScore() => clearField(3);

  @$pb.TagNumber(4)
  FriendState get state => $_getN(3);
  @$pb.TagNumber(4)
  set state(FriendState v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasState() => $_has(3);
  @$pb.TagNumber(4)
  void clearState() => clearField(4);
}

class FriendList extends $pb.GeneratedMessage {
  factory FriendList({
    $core.Iterable<Friend>? friends,
  }) {
    final $result = create();
    if (friends != null) {
      $result.friends.addAll(friends);
    }
    return $result;
  }
  FriendList._() : super();
  factory FriendList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FriendList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FriendList', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Friend>(2, _omitFieldNames ? '' : 'friends', $pb.PbFieldType.PM, subBuilder: Friend.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FriendList clone() => FriendList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FriendList copyWith(void Function(FriendList) updates) => super.copyWith((message) => updates(message as FriendList)) as FriendList;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FriendList create() => FriendList._();
  FriendList createEmptyInstance() => create();
  static $pb.PbList<FriendList> createRepeated() => $pb.PbList<FriendList>();
  @$core.pragma('dart2js:noInline')
  static FriendList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FriendList>(create);
  static FriendList? _defaultInstance;

  /// string token = 1;
  @$pb.TagNumber(2)
  $core.List<Friend> get friends => $_getList(0);
}

class FriendRequestRequest extends $pb.GeneratedMessage {
  factory FriendRequestRequest({
    $core.String? token,
    $core.String? targetId,
    $core.String? requesterName,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (targetId != null) {
      $result.targetId = targetId;
    }
    if (requesterName != null) {
      $result.requesterName = requesterName;
    }
    return $result;
  }
  FriendRequestRequest._() : super();
  factory FriendRequestRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FriendRequestRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FriendRequestRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'targetId')
    ..aOS(3, _omitFieldNames ? '' : 'requesterName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FriendRequestRequest clone() => FriendRequestRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FriendRequestRequest copyWith(void Function(FriendRequestRequest) updates) => super.copyWith((message) => updates(message as FriendRequestRequest)) as FriendRequestRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FriendRequestRequest create() => FriendRequestRequest._();
  FriendRequestRequest createEmptyInstance() => create();
  static $pb.PbList<FriendRequestRequest> createRepeated() => $pb.PbList<FriendRequestRequest>();
  @$core.pragma('dart2js:noInline')
  static FriendRequestRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FriendRequestRequest>(create);
  static FriendRequestRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get targetId => $_getSZ(1);
  @$pb.TagNumber(2)
  set targetId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get requesterName => $_getSZ(2);
  @$pb.TagNumber(3)
  set requesterName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRequesterName() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequesterName() => clearField(3);
}

class FriendRequest extends $pb.GeneratedMessage {
  factory FriendRequest({
    $core.String? requesterUuid,
    $core.String? requesterName,
    $core.String? targetUuid,
  }) {
    final $result = create();
    if (requesterUuid != null) {
      $result.requesterUuid = requesterUuid;
    }
    if (requesterName != null) {
      $result.requesterName = requesterName;
    }
    if (targetUuid != null) {
      $result.targetUuid = targetUuid;
    }
    return $result;
  }
  FriendRequest._() : super();
  factory FriendRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FriendRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FriendRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requesterUuid')
    ..aOS(2, _omitFieldNames ? '' : 'requesterName')
    ..aOS(3, _omitFieldNames ? '' : 'targetUuid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FriendRequest clone() => FriendRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FriendRequest copyWith(void Function(FriendRequest) updates) => super.copyWith((message) => updates(message as FriendRequest)) as FriendRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FriendRequest create() => FriendRequest._();
  FriendRequest createEmptyInstance() => create();
  static $pb.PbList<FriendRequest> createRepeated() => $pb.PbList<FriendRequest>();
  @$core.pragma('dart2js:noInline')
  static FriendRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FriendRequest>(create);
  static FriendRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requesterUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set requesterUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequesterUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequesterUuid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get requesterName => $_getSZ(1);
  @$pb.TagNumber(2)
  set requesterName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRequesterName() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequesterName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get targetUuid => $_getSZ(2);
  @$pb.TagNumber(3)
  set targetUuid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTargetUuid() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetUuid() => clearField(3);
}

class FriendRequestList extends $pb.GeneratedMessage {
  factory FriendRequestList({
    $core.Iterable<FriendRequest>? requests,
  }) {
    final $result = create();
    if (requests != null) {
      $result.requests.addAll(requests);
    }
    return $result;
  }
  FriendRequestList._() : super();
  factory FriendRequestList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FriendRequestList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FriendRequestList', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<FriendRequest>(2, _omitFieldNames ? '' : 'requests', $pb.PbFieldType.PM, subBuilder: FriendRequest.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FriendRequestList clone() => FriendRequestList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FriendRequestList copyWith(void Function(FriendRequestList) updates) => super.copyWith((message) => updates(message as FriendRequestList)) as FriendRequestList;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FriendRequestList create() => FriendRequestList._();
  FriendRequestList createEmptyInstance() => create();
  static $pb.PbList<FriendRequestList> createRepeated() => $pb.PbList<FriendRequestList>();
  @$core.pragma('dart2js:noInline')
  static FriendRequestList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FriendRequestList>(create);
  static FriendRequestList? _defaultInstance;

  @$pb.TagNumber(2)
  $core.List<FriendRequest> get requests => $_getList(0);
}

class FriendRequestResponse extends $pb.GeneratedMessage {
  factory FriendRequestResponse({
    $core.String? token,
    $core.String? requesterId,
    $core.bool? accept,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (requesterId != null) {
      $result.requesterId = requesterId;
    }
    if (accept != null) {
      $result.accept = accept;
    }
    return $result;
  }
  FriendRequestResponse._() : super();
  factory FriendRequestResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FriendRequestResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FriendRequestResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'requesterId')
    ..aOB(3, _omitFieldNames ? '' : 'accept')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FriendRequestResponse clone() => FriendRequestResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FriendRequestResponse copyWith(void Function(FriendRequestResponse) updates) => super.copyWith((message) => updates(message as FriendRequestResponse)) as FriendRequestResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FriendRequestResponse create() => FriendRequestResponse._();
  FriendRequestResponse createEmptyInstance() => create();
  static $pb.PbList<FriendRequestResponse> createRepeated() => $pb.PbList<FriendRequestResponse>();
  @$core.pragma('dart2js:noInline')
  static FriendRequestResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FriendRequestResponse>(create);
  static FriendRequestResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get requesterId => $_getSZ(1);
  @$pb.TagNumber(2)
  set requesterId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRequesterId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequesterId() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get accept => $_getBF(2);
  @$pb.TagNumber(3)
  set accept($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccept() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccept() => clearField(3);
}

class DeleteFriendRequest extends $pb.GeneratedMessage {
  factory DeleteFriendRequest({
    $core.String? token,
    $core.String? targetId,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (targetId != null) {
      $result.targetId = targetId;
    }
    return $result;
  }
  DeleteFriendRequest._() : super();
  factory DeleteFriendRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteFriendRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteFriendRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'targetId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteFriendRequest clone() => DeleteFriendRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteFriendRequest copyWith(void Function(DeleteFriendRequest) updates) => super.copyWith((message) => updates(message as DeleteFriendRequest)) as DeleteFriendRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteFriendRequest create() => DeleteFriendRequest._();
  DeleteFriendRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteFriendRequest> createRepeated() => $pb.PbList<DeleteFriendRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteFriendRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteFriendRequest>(create);
  static DeleteFriendRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get targetId => $_getSZ(1);
  @$pb.TagNumber(2)
  set targetId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetId() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
