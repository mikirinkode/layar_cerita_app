import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:layar_cerita_app/presentation/module/home/home_page.dart';
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
  final Function(List<CameraDescription> cameras) openCamera;

  const AddStoryPage({
    super.key,
    required this.openCamera,
  });

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddStoryProvider>(builder: (context, provider, child) {
      return PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, Object? _) async {
          context
              .read<PageManager>()
              .returnData(provider.isShouldRefreshPreviousPage);
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
                    provider.uploadStory(onSuccess: () {
                      _showSuccessSnackbar(
                          message: "Story berhasil ditambahkan");
                    });
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
