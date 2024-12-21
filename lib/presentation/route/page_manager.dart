import 'dart:async';

import 'package:flutter/material.dart';

class PageManager extends ChangeNotifier {
  final Map<String, Completer<Map<String, dynamic>>> _completers = {};

  // late Completer<Map<String, dynamic>> _completer;

  Future<Map<String, dynamic>> waitForResult(String key) async {
    // _completer = Completer<Map<String, dynamic>>();
    // debugPrint("PageManager.waitForResult with $_completer");
    // debugPrint("PageManager.waitForResult is complete: ${_completer.isCompleted}");
    // return _completer.future;
    if (_completers.containsKey(key) && !_completers[key]!.isCompleted) {
      throw Exception("Completer with key '$key' is already active.");
    }
    final completer = Completer<Map<String, dynamic>>();
    _completers[key] = completer;
    return completer.future;
  }

  void returnData(String key, Map<String, dynamic> value) {
    // if (!_completer.isCompleted) {
    //   debugPrint("PageManager.returnData: $value");
    //   _completer.complete(value);
    // } else {
    //   debugPrint("PageManager: Completer already completed or null.");
    // }
    final completer = _completers[key];
    if (completer != null && !completer.isCompleted) {
      completer.complete(value);
      _completers.remove(key); // Clean up after use
    } else {
      debugPrint(
          "PageManager: No active Completer found for key '$key' or already completed.");
    }
  }
}
