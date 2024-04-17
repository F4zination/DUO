import 'package:duo_client/pb/google/protobuf/timestamp.pb.dart';

extension DateTimeExtension on DateTime {
  Timestamp toTimestamp() {
    return Timestamp.fromDateTime(this);
  }
}
