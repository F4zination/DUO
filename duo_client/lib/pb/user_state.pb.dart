//
//  Generated code. Do not modify.
//  source: user_state.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'friend.pbenum.dart' as $1;

class StatusChangeRequest extends $pb.GeneratedMessage {
  factory StatusChangeRequest({
    $core.String? token,
    $1.FriendState? status,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  StatusChangeRequest._() : super();
  factory StatusChangeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StatusChangeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StatusChangeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..e<$1.FriendState>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $1.FriendState.offline, valueOf: $1.FriendState.valueOf, enumValues: $1.FriendState.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StatusChangeRequest clone() => StatusChangeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StatusChangeRequest copyWith(void Function(StatusChangeRequest) updates) => super.copyWith((message) => updates(message as StatusChangeRequest)) as StatusChangeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatusChangeRequest create() => StatusChangeRequest._();
  StatusChangeRequest createEmptyInstance() => create();
  static $pb.PbList<StatusChangeRequest> createRepeated() => $pb.PbList<StatusChangeRequest>();
  @$core.pragma('dart2js:noInline')
  static StatusChangeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StatusChangeRequest>(create);
  static StatusChangeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $1.FriendState get status => $_getN(1);
  @$pb.TagNumber(2)
  set status($1.FriendState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
