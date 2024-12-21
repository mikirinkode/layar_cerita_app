import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:layar_cerita_app/data/source/network/response/story/story_response.dart';
import 'package:layar_cerita_app/presentation/module/story_detail/story_detail_provider.dart';
import 'package:layar_cerita_app/utils/time_utils.dart';
import 'package:layar_cerita_app/utils/ui_state.dart';
import 'package:layar_cerita_app/utils/ui_utils.dart';
import 'package:provider/provider.dart';

import '../../../utils/cache_manager_provider.dart';
import '../../global_widgets/error_state_view.dart';
import '../../global_widgets/loading_indicator.dart';
import '../../theme/app_color.dart';

class StoryDetailPage extends StatefulWidget {
  final String storyId;

  const StoryDetailPage({super.key, required this.storyId});

  @override
  State<StoryDetailPage> createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  @override
  void initState() {
    super.initState();
    debugPrint("story id: ${widget.storyId}");
    Future.microtask(() {
      context.read<StoryDetailProvider>().getStoryDetail(widget.storyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Consumer<StoryDetailProvider>(
        builder: (context, provider, child) {
          return provider.state.when(
            onInitial: () => const SizedBox(),
            onLoading: (message) => Center(
              child: LoadingIndicator(message: message),
            ),
            onError: (message) => ErrorStateView(
              message: message,
              onRetry: () {
                provider.getStoryDetail(widget.storyId);
              },
            ),
            onSuccess: () => buildBody(
              story: provider.storyDetailResponse?.story,
            ),
          );
        },
      ),
    );
  }

  Widget buildBody({StoryResponse? story}) {
    return SingleChildScrollView(
      padding: UIUtils.paddingAll(16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: CachedNetworkImage(
              width: double.infinity,
              height: 250,
              imageUrl: story?.photoUrl ?? "",
              fit: BoxFit.cover,
              cacheManager: CacheMangerProvider.restaurantImage,
              placeholder: (context, url) => const Padding(
                padding: EdgeInsets.all(4.0),
                child: CupertinoActivityIndicator(
                  radius: 18,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Theme.of(context).cardColor,
                child: const Icon(
                  Icons.image_not_supported,
                  color: AppColor.neutral500,
                ),
              ),
            ),
          ),
          UIUtils.heightSpace(24),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: UIUtils.paddingAll(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story?.name ?? "-",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UIUtils.heightSpace(8),
                Text(
                  TimeUtils.formatCreatedAt(dateString: story?.createdAt ?? ""),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                UIUtils.heightSpace(16),
                Divider(
                  color: Theme.of(context).dividerColor,
                ),
                UIUtils.heightSpace(16),
                Text(
                  story?.description ?? "-",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          UIUtils.heightSpace(24),
          Visibility(
            visible: (story?.lat ?? 0) != 0 && (story?.lon ?? 0) != 0,
            child: buildMap(lat: story?.lat ?? 0, lng: story?.lon ?? 0),
          ),
        ],
      ),
    );
  }

  Widget buildMap({required lat, required lng}) {
    final provider = context.read<StoryDetailProvider>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: GoogleMap(
          markers: provider.markers,
          initialCameraPosition: CameraPosition(
            target: provider.defaultLatLng,
          ),
          onMapCreated: (controller) {
            provider.onMapCreated(controller);
            provider.initStoryLocation(lat: lat, lng: lng);
          },
        ),
      ),
    );
  }
}
