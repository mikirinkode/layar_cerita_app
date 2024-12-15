import 'package:flutter/widgets.dart';
import 'package:layar_cerita_app/presentation/route/router_delegate.dart';

mixin AppNavigationMixin {
  List<String> _navStack = [];

  List<String> get navStack => _navStack;

  final Map<String, dynamic> _arguments = {};

  Map<String, dynamic> get arguments => _arguments;

  AppRouterDelegate get delegate;

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
    delegate.triggerNotifyListeners();
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
    delegate.triggerNotifyListeners();
  }

  void clearStack() {
    _navStack = [];
    delegate.triggerNotifyListeners();
  }

  void clearArguments() {
    _arguments.clear();
    delegate.triggerNotifyListeners();
  }

  void popLast() {
    _navStack.removeLast();
    delegate.triggerNotifyListeners();
  }

  void navigateBack(){
    popLast();
  }
}
