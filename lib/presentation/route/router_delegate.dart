import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:layar_cerita_app/presentation/module/add_story/add_story_page.dart';
import 'package:layar_cerita_app/presentation/module/camera/camera_page.dart';
import 'package:layar_cerita_app/presentation/module/home/home_navigation.dart';
import 'package:layar_cerita_app/presentation/module/profile/profile_page.dart';
import 'package:layar_cerita_app/presentation/module/story_detail/story_detail_page.dart';
import 'package:layar_cerita_app/presentation/route/app_navigation_mixin.dart';

import '../module/home/home_page.dart';
import '../module/login/login_page.dart';
import '../module/register/register_page.dart';
import 'animated_page.dart';
import 'app_page.dart';
import 'app_path.dart';
import 'route_argument.dart';

class AppRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin, AppNavigationMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  AppRouterDelegate(isLoggedIn) : _navigatorKey = GlobalKey<NavigatorState>() {
    navigateTo(
      path: isLoggedIn ? AppPath.home : AppPath.login,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: getPages(),
      onPopPage: (route, result) {
        debugPrint("onPopPage, route: $route");
        if (!route.didPop(result)) {
          return false;
        }
        navigateBack();
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

  @override
  AppRouterDelegate get delegate => this; // TODO

  List<AppPage> get pages => [
        AppPage(
          path: AppPath.login,
          page: AnimatedPage(
            key: const ValueKey('LoginPage'),
            child: LoginPage(
              onNavigateToRegister: () {
                navigateToAndClearStack(path: AppPath.register);
              },
              onNavigateToHome: () {
                navigateToAndClearStack(path: AppPath.home);
              },
            ),
          ),
        ),
        AppPage(
          path: AppPath.register,
          page: AnimatedPage(
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
          page: AnimatedPage(
            key: const ValueKey('HomePage'),
            child: HomePage(
              onNavigateToStoryDetail: (storyId) {
                return navigateTo(
                  path: AppPath.storyDetail,
                  arguments: {
                    DetailArgs.storyId: storyId,
                  },
                );
              },
              onNavigateToAddStory: () {
                navigateTo(path: AppPath.addStory);
              },
              onNavigateToProfile: () {
                navigateTo(path: AppPath.profile);
              },
            ),
          ),
        ),
        AppPage(
          path: AppPath.storyDetail,
          page: AnimatedPage(
            key: const ValueKey('StoryDetailPage'),
            child: StoryDetailPage(
              storyId: arguments[DetailArgs.storyId] as String? ?? "",
            ),
          ),
        ),
        AppPage(
          path: AppPath.profile,
          page: AnimatedPage(
            key: const ValueKey("ProfilePage"),
            child: ProfilePage(
              onNavigateToHome: () {
                navigateBack();
              },
              onNavigateToAddStory: () {
                navigateTo(path: AppPath.addStory);
              },
              onLogoutSuccess: () {
                navigateToAndClearStack(path: AppPath.login);
              },
            ),
          ),
        ),
        AppPage(
          path: AppPath.addStory,
          page: AnimatedPage(
            key: const ValueKey("AddStoryPage"),
            child: AddStoryPage(
              openCamera: (cameras) {
                navigateTo(
                  path: AppPath.camera,
                  arguments: {
                    CameraArgs.cameras: cameras,
                  },
                );
              },
            ),
          ),
        ),
        AppPage(
          path: AppPath.camera,
          page: AnimatedPage(
            key: const ValueKey("CameraPage"),
            child: CameraPage(
              cameras:
                  arguments[CameraArgs.cameras] as List<CameraDescription>? ??
                      [],
            ),
          ),
        ),
      ];

  List<Page> getPages() {
    debugPrint("getPages");
    debugPrint("navStack: $navStack");
    debugPrint("arguments: $arguments");
    final pageResult = pages
        .where((page) => navStack.contains(page.path))
        .map((page) => page.page)
        .toList();

    debugPrint("pageResult: $pageResult");
    debugPrint("pageResult length: ${pageResult.length}");
    return pageResult;
  }

  void triggerNotifyListeners() => notifyListeners();
}
