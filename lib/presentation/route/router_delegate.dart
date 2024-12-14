import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../module/home/home_page.dart';
import '../module/login/login_page.dart';
import '../module/register/register_page.dart';
import 'path.dart';

class AppRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  AppRouterDelegate(isLoggedIn)
      : _navigatorKey = GlobalKey<NavigatorState>(),
        _currentPath = isLoggedIn ? AppPath.home : AppPath.login;

  // Current navigation state
  String _currentPath = AppPath.login;

  String get currentPath => _currentPath;

  void setPath(String path) {
    debugPrint('setPath: $path');
    _currentPath = path;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: [
        // Add pages based on the current path
        if (_currentPath == AppPath.login)
          MaterialPage(
            key: const ValueKey('LoginPage'),
            child: LoginPage(
              onNavigateToRegister: () => setPath(AppPath.register),
            ),
          ),
        if (_currentPath == AppPath.register)
          MaterialPage(
            key: const ValueKey('RegisterPage'),
            child: RegisterPage(
              onNavigateToLogin: () => setPath(AppPath.login),
              onNavigateToHome: () => setPath(AppPath.home),
            ),
          ),
        if (_currentPath == AppPath.home)
          MaterialPage(
            key: const ValueKey('HomePage'),
            child: HomePage(),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        // Handle back navigation
        if (_currentPath == AppPath.register) {
          setPath(AppPath.login);
        } else if (_currentPath == AppPath.home) {
          setPath(AppPath.login);
        }
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) async {
    /* DO NOTHING */
  }
}
