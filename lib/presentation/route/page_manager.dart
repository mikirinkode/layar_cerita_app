import 'dart:async';

import 'package:flutter/material.dart';

/// todo-03-manager-01: create Page Manager to handle data from a screen
class PageManager extends ChangeNotifier {
  /// todo-03-manager-02: add completer variable to handle data
  late Completer<bool> _completer;

  /// todo-03-manager-03: make a function to wait the data
  Future<bool> waitForResult() async {
    _completer = Completer<bool>();
    return _completer.future;
  }

  /// todo-03-manager-04: make a function to return the data
  void returnData(bool value) {
    _completer.complete(value);
  }
}