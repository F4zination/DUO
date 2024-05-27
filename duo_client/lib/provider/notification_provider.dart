import 'package:duo_client/provider/api_provider.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  final ApiProvider _apiProvider;

  List<String> _notifications = [
    // 'Friend request from Joe Mama',
    // 'Friend request from ZinsiBinsi',
    // 'Friend request from Rehnertli',
    // 'Friend request from Hillibilli',
  ];

  List<String> get notifications => _notifications;

  NotificationProvider(ApiProvider apiProvider) : _apiProvider = apiProvider;
}
