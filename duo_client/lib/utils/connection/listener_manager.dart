import 'package:flutter/foundation.dart';

class ListenerManager {
  final List<VoidCallback> _listeners = [];

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (var listener in List.from(_listeners)) {
      listener();
    }
  }
}
