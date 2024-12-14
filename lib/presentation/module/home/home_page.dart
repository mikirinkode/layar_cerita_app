import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layar_cerita_app/data/source/network/response/story/story_response.dart';
import 'package:layar_cerita_app/presentation/global_widgets/error_state_view.dart';
import 'package:layar_cerita_app/presentation/module/home/home_provider.dart';
import 'package:layar_cerita_app/presentation/module/register/register_provider.dart';
import 'package:layar_cerita_app/utils/build_context.dart';
import 'package:layar_cerita_app/utils/time_utils.dart';
import 'package:layar_cerita_app/utils/ui_state.dart';
import 'package:layar_cerita_app/utils/ui_utils.dart';
import 'package:provider/provider.dart';

import '../../../utils/cache_manager_provider.dart';
import '../../global_widgets/loading_indicator.dart';
import '../../theme/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<HomeProvider>().getStoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return provider.state.when(
            onInitial: () => const SizedBox(),
            onLoading: (message) => Center(
              child: LoadingIndicator(message: message),
            ),
            onError: (message) => ErrorStateView(
              message: message,
              onRetry: () {
                provider.getStoryList();
              },
            ),
            onSuccess: () => buildStoryListView(
              stories: provider.storyList,
            ),
          );
        },
      ),
    );
  }

  Widget buildStoryListView({required List<StoryResponse> stories}) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: PageController(viewportFraction: 1),
      physics: const BouncingScrollPhysics(),
      itemCount: stories.length,
      itemBuilder: (context, index) =>
          buildStoryView(story: stories[index], index: index),
    );
  }

  Widget buildStoryView({required StoryResponse story, int index = 0}) {
    return Stack(
      children: [
        CachedNetworkImage(
          width: double.infinity,
          height: double.infinity,
          imageUrl: story.photoUrl ?? "",
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
        Align(
          alignment: Alignment.topCenter,
          child: buildHeader(
            userName: story.name,
            createdAt: story.createdAt,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: buildBottomView(
            storyDesc: story.description,
          ),
        ),
      ],
    );
  }

  Widget buildHeader({required String userName, required String createdAt}) {
    return Container(
      width: double.infinity,
      padding: UIUtils.paddingFromLTRB(
        left: 24,
        top: 24,
        right: 24,
        bottom: 126,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.75),
            Colors.black.withOpacity(0.25),
            Colors.transparent,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColor.neutral100,
                    shape: BoxShape.circle,
                  ),
                  padding: UIUtils.paddingAll(8),
                  child: const Icon(
                    CupertinoIcons.person_fill,
                    color: AppColor.neutral400,
                  ),
                ),
                UIUtils.widthSpace(16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        TimeUtils.formatCreatedAt(dateString: createdAt),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            UIUtils.heightSpace(8),
            Divider(
              color: Colors.white.withOpacity(0.5),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBottomView({required String storyDesc}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.center,
          colors: [
            Colors.black.withOpacity(0.75),
            Colors.black.withOpacity(0.25),
          ],
        ),
      ),
      padding:
          UIUtils.paddingFromLTRB(left: 16, top: 32, right: 16, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            storyDesc,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
