import 'package:flutter/material.dart';
import 'package:layar_cerita_app/data/source/network/response/story/story_detail_response.dart';
import 'package:layar_cerita_app/main.dart';
import 'package:layar_cerita_app/presentation/module/story_detail/story_detail_provider.dart';
import 'package:layar_cerita_app/utils/ui_state.dart';
import 'package:provider/provider.dart';

import '../../global_widgets/error_state_view.dart';
import '../../global_widgets/loading_indicator.dart';
import '../home/home_provider.dart';

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
        title: Text("Detail"),
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
              story: provider.storyDetailResponse,
            ),
          );
        },
      ),
    );
  }

  Widget buildBody({StoryDetailResponse? story}) {
    return Container();
  }
}
