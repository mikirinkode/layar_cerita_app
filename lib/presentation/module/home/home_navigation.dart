import 'package:layar_cerita_app/presentation/route/app_path.dart';
import 'package:layar_cerita_app/presentation/route/route_argument.dart';
import 'package:layar_cerita_app/presentation/route/router_delegate.dart';

import '../../route/app_navigation_mixin.dart';

extension HomeNavigation on AppRouterDelegate { // TODO REMOVE
  navigateToDetailStory(String storyId) {
    return navigateTo(
      path: AppPath.storyDetail,
      arguments: {
        DetailArgs.storyId: storyId,
      },
    );
  }
}
