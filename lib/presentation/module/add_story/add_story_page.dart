import 'dart:io';

import 'package:flutter/material.dart';
import 'package:layar_cerita_app/presentation/route/route_argument.dart';
import 'package:layar_cerita_app/presentation/theme/app_button_style.dart';
import 'package:layar_cerita_app/presentation/theme/app_color.dart';
import 'package:layar_cerita_app/utils/build_context.dart';
import 'package:layar_cerita_app/utils/ui_state.dart';
import 'package:provider/provider.dart';

import '../../../utils/ui_utils.dart';
import '../../global_widgets/error_state_view.dart';
import '../../global_widgets/loading_indicator.dart';
import '../../route/page_manager.dart';
import 'add_story_provider.dart';

class AddStoryPage extends StatefulWidget {
  final Function() onNavigateToPickLocation;
  final Function() onNavigateBack;

  const AddStoryPage({
    super.key,
    required this.onNavigateToPickLocation,
    required this.onNavigateBack,
  });

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddStoryProvider>().resetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddStoryProvider>(builder: (context, provider, child) {
      return PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, Object? _) async {
          // context.read<PageManager>().returnData(
          //   {
          //     HomeArgs.shouldRefresh: provider.isShouldRefreshPreviousPage,
          //   },
          // );
        },
        child: Scaffold(
          appBar: AppBar(title: const Text("Cerita Baru")),
          body: Stack(
            children: [
              buildBody(),
              provider.addStoryState.when(
                onInitial: () => const SizedBox(),
                onLoading: (message) => Center(
                  child: LoadingIndicator(message: message),
                ),
                onError: (message) => ErrorStateView(
                  message: message,
                  onRetry: provider.resetState,
                ),
                onSuccess: () => const SizedBox(),
              ),
            ],
          ),
          bottomNavigationBar: buildBottomView(),
        ),
      );
    });
  }

  Widget buildBody() {
    return Consumer<AddStoryProvider>(builder: (context, provider, child) {
      return SingleChildScrollView(
        padding: UIUtils.paddingAll(24),
        child: Column(
          children: [
            Container(
              height: context.height * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: (provider.imagePath.isNotEmpty)
                  ? Image.file(
                      File(provider.imagePath),
                    )
                  : const Icon(
                      Icons.image,
                      color: AppColor.neutral200,
                      size: 48,
                    ),
            ),
            UIUtils.heightSpace(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () {
                    provider.pickImageFromGallery(
                      onFailed: (message) {
                        _showErrorSnackbar(message: message);
                      },
                      onSuccess: () {
                        _showSuccessSnackbar(
                            message: "Gambar berhasil dipilih");
                      },
                    );
                  },
                  style: AppButtonStyle.filledPrimary,
                  child: const Text("Galeri"),
                ),
                UIUtils.widthSpace(24),
                FilledButton(
                  onPressed: () async {
                    provider.picImageFromCamera(
                      onFailed: (message) {
                        _showErrorSnackbar(message: message);
                      },
                      onSuccess: () {
                        _showSuccessSnackbar(
                            message: "Gambar berhasil dipilih");
                      },
                    );
                  },
                  style: AppButtonStyle.filledPrimary,
                  child: const Text("Kamera"),
                ),
              ],
            ),
            UIUtils.heightSpace(32),
            TextField(
              onChanged: provider.onDescriptionChanged,
              decoration: const InputDecoration(
                labelText: "Bagikan Ceritamu disini",
              ),
              maxLines: null,
              minLines: 3,
              keyboardType: TextInputType.multiline,
            ),
            UIUtils.heightSpace(32),
            GestureDetector(
              onTap: () async {
                final pageManager = context.read<PageManager>();
                await widget.onNavigateToPickLocation();
                final argResult = await pageManager.waitForResult(AddStoryArgs.resultFromPickLocation);

                final lat = argResult[AddStoryArgs.lat] as double? ?? 0.0;
                final lng = argResult[AddStoryArgs.lng] as double? ?? 0.0;
                debugPrint("AddStoryPage result: lat: $lat, lng: $lng");
                if (lat != 0.0 && lng != 0.0) {
                  provider.onUpdateLocation(lat, lng);
                }
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
                padding: UIUtils.paddingAll(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(provider.selectedLat == null
                            ? "Pilih Lokasi"
                            : "Lokasi terpilih:"),
                        const Spacer(),
                        const Icon(
                          Icons.add_location_rounded,
                        ),
                      ],
                    ),
                    Visibility(
                      visible: provider.selectedLat != null,
                      child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UIUtils.heightSpace(16),
                          Text("latitude: ${provider.selectedLat}"),
                          Text("longitude: ${provider.selectedLng}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget buildBottomView() {
    return Consumer<AddStoryProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          padding: UIUtils.paddingAll(16),
          child: FilledButton(
            onPressed: provider.isValid
                ? () {
                    provider.uploadStory(
                      onSuccess: () {
                        _showSuccessSnackbar(
                            message: "Story berhasil ditambahkan");
                        context.read<PageManager>().returnData(
                          HomeArgs.resultFromAddStory,
                          {
                            HomeArgs.shouldRefresh:
                                provider.isShouldRefreshPreviousPage,
                          },
                        );
                        widget.onNavigateBack();
                      },
                    );
                  }
                : null,
            style: AppButtonStyle.filledPrimary,
            child: const Text("Upload"),
          ),
        );
      },
    );
  }

  _showSuccessSnackbar({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green[400],
      ),
    );
  }

  _showErrorSnackbar({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[400],
      ),
    );
  }
}
