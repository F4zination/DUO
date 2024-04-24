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

import 'user.pb.dart' as $4;

class LobbyStatus extends $pb.GeneratedMessage {
  factory LobbyStatus({
    $core.Iterable<$4.User>? users,
    $core.bool? isStarting,
  }) {
    final $result = create();
    if (users != null) {
      $result.users.addAll(users);
    }
    if (isStarting != null) {
      $result.isStarting = isStarting;
    }
    return $result;
  }
  LobbyStatus._() : super();
  factory LobbyStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LobbyStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LobbyStatus', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<$4.User>(1, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM, subBuilder: $4.User.create)
    ..aOB(2, _omitFieldNames ? '' : 'isStarting', protoName: 'isStarting')
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
  $core.List<$4.User> get users => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get isStarting => $_getBF(1);
  @$pb.TagNumber(2)
  set isStarting($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsStarting() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsStarting() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
