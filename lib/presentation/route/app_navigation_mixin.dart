import 'package:flutter/widgets.dart';

mixin AppNavigationMixin {
  List<String> _navStack = [];

  List<String> get navStack => _navStack;

  final Map<String, dynamic> _arguments = {};

  Map<String, dynamic> get arguments => _arguments;

  triggerNotifyListener();

  void navigateTo({
    required String path,
    Map<String, dynamic>? arguments,
  }) {
    debugPrint('navigateTo: $path');
    debugPrint('arguments: $arguments');
    _navStack.add(path);
    if (arguments != null) {
      _arguments.addAll(arguments);
    }
    triggerNotifyListener();
  }

  void navigateToAndClearStack({
    required String path,
    Map<String, dynamic>? arguments,
  }) {
    debugPrint('navigateToAndClearStack: $path');
    debugPrint('arguments: $arguments');
    _navStack = [path];
    if (arguments != null) {
      _arguments.addAll(arguments);
    }
    triggerNotifyListener();
  }

  void clearStack() {
    _navStack = [];
    triggerNotifyListener();
  }

  // void clearArguments() {
  //   _arguments.clear();
  //   triggerNotifyListener();
  // }

  // void _popLast() {
  //   _navStack.removeLast();
  //   triggerNotifyListener();
  // }

  void navigateBack() {
    _navStack.removeLast();
    triggerNotifyListener();
    debugPrint("navigateBack");
    debugPrint('navStack: $navStack');
  }
}
