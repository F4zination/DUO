import 'package:duo_client/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:duo_client/pb/notification.pb.dart' as notification;

class NotificationProvider extends ChangeNotifier {
  List<notification.Notification> _notifications = [];

  void addNotification(notification.Notification notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  void removeNotification(int index) {
    _notifications.removeAt(index);
    notifyListeners();
  }

  List<notification.Notification> get notifications => _notifications;

  NotificationProvider();
}

final notificationProvider =
    ChangeNotifierProvider<NotificationProvider>((ref) {
  return NotificationProvider();
});
