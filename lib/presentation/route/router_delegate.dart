import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../module/home/home_page.dart';
import '../module/login/login_page.dart';
import '../module/register/register_page.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  MyRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  // Current navigation state
  String _currentPath = '/login';

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
        if (_currentPath == '/login')
          MaterialPage(
            key: const ValueKey('LoginPage'),
            child: LoginPage(
              onNavigateToRegister: () => setPath('/register'),
            ),
          ),
        if (_currentPath == '/register')
          MaterialPage(
            key: const ValueKey('RegisterPage'),
            child: RegisterPage(
              onNavigateToLogin: () => setPath('/login'),
            ),
          ),
        if (_currentPath == '/home')
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
        if (_currentPath == '/register') {
          setPath('/login');
        } else if (_currentPath == '/home') {
          setPath('/login');
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
