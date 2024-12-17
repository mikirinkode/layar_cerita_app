import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:layar_cerita_app/presentation/theme/app_color.dart';

import '../../utils/ui_utils.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;

  const LoadingIndicator({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: UIUtils.paddingAll(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoActivityIndicator(
            radius: 16,
            color: Theme.of(context).primaryColor,
          ),
          Visibility(
            visible: message != null,
            child: Padding(
              padding: UIUtils.paddingLeft(16),
              child: Text(
                message ?? '',
                style: TextStyle(
                  // color: AppColor.neutral700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
