import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheMangerProvider {
  CacheMangerProvider._();

  static final restaurantImage = CacheManager(
    Config(
      "storyImage",
      stalePeriod: const Duration(days: 7),
    ),
  );
}
