import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:layar_cerita_app/presentation/module/story_detail/story_detail_page.dart';

import '../module/home/home_page.dart';
import '../module/login/login_page.dart';
import '../module/register/register_page.dart';
import 'app_page.dart';
import 'app_path.dart';
import 'route_argument.dart';

class AppRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  AppRouterDelegate(isLoggedIn)
      : _navigatorKey = GlobalKey<NavigatorState>(),
        // _rootPath = isLoggedIn ? AppPath.home : AppPath.login,
        _navStack = [isLoggedIn ? AppPath.home : AppPath.login];

  // Current navigation state
  // String _rootPath = AppPath.login;

  // Navigation stack
  List<String> _navStack = [];

  final Map<String, dynamic> _arguments = {};

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: getPages(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        _navStack.removeLast();
        _arguments.clear();
        notifyListeners();
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

  List<AppPage> get pages => [
        AppPage(
          path: AppPath.login,
          page: MaterialPage(
            key: const ValueKey('LoginPage'),
            child: LoginPage(
              onNavigateToRegister: () {
                navigateToAndClearStack(path: AppPath.register);
              },
            ),
          ),
        ),
        AppPage(
          path: AppPath.register,
          page: MaterialPage(
            key: const ValueKey('RegisterPage'),
            child: RegisterPage(
              onNavigateToLogin: () {
                navigateToAndClearStack(path: AppPath.login);
              },
              onNavigateToHome: () {
                navigateToAndClearStack(path: AppPath.home);
              },
            ),
          ),
        ),
        AppPage(
          path: AppPath.home,
          page: MaterialPage(
            key: const ValueKey('HomePage'),
            child: HomePage(
              onNavigateToStoryDetail: (storyId) {
                navigateTo(
                  path: AppPath.storyDetail,
                  arguments: {DetailArgs.storyId: storyId},
                );
              },
            ),
          ),
        ),
        AppPage(
          path: AppPath.storyDetail,
          page: MaterialPage(
            key: const ValueKey('StoryDetailPage'),
            child: StoryDetailPage(
              storyId: _arguments[DetailArgs.storyId] as String? ?? "",
            ),
          ),
        ),
      ];

  List<Page> getPages() {
    debugPrint("_navStack: $_navStack");
    debugPrint("_arguments: $_arguments");
    final pageResult = pages
        .where((page) => _navStack.contains(page.path))
        .map((page) => page.page)
        .toList();

    debugPrint("pageResult: $pageResult");
    debugPrint("pageResult length: ${pageResult.length}");
    return pageResult;
  }

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
    notifyListeners();
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
    notifyListeners();
  }
}
