import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layar_cerita_app/data/source/network/response/story/story_response.dart';
import 'package:layar_cerita_app/presentation/global_widgets/error_state_view.dart';
import 'package:layar_cerita_app/presentation/module/home/home_provider.dart';
import 'package:layar_cerita_app/presentation/route/route_argument.dart';
import 'package:layar_cerita_app/utils/time_utils.dart';
import 'package:layar_cerita_app/utils/ui_state.dart';
import 'package:layar_cerita_app/utils/ui_utils.dart';
import 'package:provider/provider.dart';

import '../../../utils/cache_manager_provider.dart';
import '../../global_widgets/loading_indicator.dart';
import '../../route/page_manager.dart';
import '../../theme/app_color.dart';

class HomePage extends StatefulWidget {
  final Function(String storyId) onNavigateToStoryDetail;
  final Function() onNavigateToAddStory;
  final Function() onNavigateToProfile;

  const HomePage({
    super.key,
    required this.onNavigateToStoryDetail,
    required this.onNavigateToAddStory,
    required this.onNavigateToProfile,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController(viewportFraction: 1);

  @override
  void initState() {
    super.initState();
    final provider = context.read<HomeProvider>();

    pageController.addListener(() {
      if (pageController.position.pixels >=
          pageController.position.maxScrollExtent) {
        debugPrint("homePage, scrolled to end. fetch new data");
        if (provider.pageItems != null) {
          provider.getStoryList();
        }
      }
    });

    Future.microtask(() {
      provider.getStoryList();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
            onSuccess: () => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                buildStoryListView(
                  stories: provider.storyList,
                  onNavigateToStoryDetail: widget.onNavigateToStoryDetail,
                  pageItems: provider.pageItems,
                ),
                buildBottomNav(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildBottomNav() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 75,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.15)),
        padding: UIUtils.paddingAll(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              highlightColor: Colors.white.withOpacity(0.15),
              onPressed: () async {
                final pageManager = context.read<PageManager>();
                await widget.onNavigateToAddStory();
                final argResult = await pageManager.waitForResult();
                final isShouldRefresh =
                    argResult[HomeArgs.shouldRefresh] as bool? ?? false;
                debugPrint("homePage: isShouldRefresh: $isShouldRefresh");
                if (isShouldRefresh == true) {
                  context.read<HomeProvider>().getStoryList();
                }
              },
              icon: const Icon(
                CupertinoIcons.camera,
                color: Colors.white,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: const IconButton(
                onPressed: null,
                icon: Icon(
                  CupertinoIcons.house_fill,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              highlightColor: Colors.white.withOpacity(0.15),
              onPressed: widget.onNavigateToProfile,
              icon: const Icon(
                CupertinoIcons.person,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStoryListView({
    required List<StoryResponse> stories,
    required Function(String storyId) onNavigateToStoryDetail,
    required int? pageItems,
  }) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: pageController,
      physics: const BouncingScrollPhysics(),
      itemCount: stories.length + (pageItems != null ? 1 : 0),
      itemBuilder: (context, index) =>
          (index == stories.length && pageItems != null)
              ? Center(child: LoadingIndicator(message: "Loading..."))
              : buildStoryView(
                  story: stories[index],
                  onNavigateToStoryDetail: onNavigateToStoryDetail),
    );
  }

  Widget buildStoryView({
    required StoryResponse story,
    required Function(String storyId) onNavigateToStoryDetail,
  }) {
    return GestureDetector(
      onTap: () {
        onNavigateToStoryDetail(story.id);
      },
      child: Stack(
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
      ),
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
          begin: Alignment.center,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withOpacity(0.75),
            Colors.transparent
            // Colors.transparent
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: UIUtils.paddingFromLTRB(
              left: 16,
              top: 64,
              right: 16,
              bottom: 16,
            ),
            child: Text(
              storyDesc,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.25),
            width: double.infinity,
            height: 1,
          ),
          UIUtils.heightSpace(75),
        ],
      ),
    );
  }
}
