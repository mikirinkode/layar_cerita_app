import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layar_cerita_app/presentation/global_widgets/error_state_view.dart';
import 'package:layar_cerita_app/utils/ui_state.dart';
import 'package:provider/provider.dart';

import '../../../utils/regexp_utils.dart';
import '../../../utils/ui_utils.dart';
import '../../theme/app_button_style.dart';
import '../../theme/app_color.dart';
import 'register_provider.dart';

class RegisterPage extends StatelessWidget {
  final Function() onNavigateToLogin;
  final Function() onNavigateToHome;

  const RegisterPage({
    super.key,
    required this.onNavigateToLogin,
    required this.onNavigateToHome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RegisterProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                body(),
                provider.registerState.when(
                  onInitial: () => const SizedBox(),
                  onLoading: (message) => Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: UIUtils.paddingAll(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          UIUtils.widthSpace(8),
                          Text(message ?? ''),
                        ],
                      ),
                    ),
                  ),
                  onError: (message) => ErrorStateView(
                    message: message,
                    onRetry: () {
                      provider.resetState();
                    },
                  ),
                  onSuccess: () => const SizedBox(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget body() {
    return Consumer<RegisterProvider>(builder: (context, provider, child) {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: UIUtils.paddingAll(24),
        child: Form(
          key: provider.registerFormKey,
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: "Nama",
                  prefixIcon: Icon(
                    CupertinoIcons.person_fill,
                    color: AppColor.neutral500,
                  ),
                ),
                onChanged: provider.onNameChanged,
              ),
              UIUtils.heightSpace(16),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: RegExpUtils.validateEmail,
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(
                    CupertinoIcons.mail_solid,
                    color: AppColor.neutral500,
                  ),
                ),
                onChanged: provider.onEmailChanged,
              ),
              UIUtils.heightSpace(16),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: provider.obsecurePassword.value,
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: RegExpUtils.validatePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(
                    CupertinoIcons.lock_fill,
                    color: AppColor.neutral500,
                  ),
                  suffixIcon: IconButton(
                    onPressed: provider.toggleObsecurePassword,
                    icon: Icon(
                      provider.obsecurePassword.value
                          ? CupertinoIcons.eye_fill
                          : CupertinoIcons.eye_slash_fill,
                      color: AppColor.neutral500,
                    ),
                  ),
                ),
                onChanged: provider.onPasswordChanged,
              ),
              UIUtils.heightSpace(24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    provider.register(
                      onLoginSuccess: () {
                        debugPrint("onLoginSuccess");
                        onNavigateToHome();
                      },
                    );
                  },
                  style: AppButtonStyle.filledPrimary,
                  child: Text("Daftar"),
                ),
              ),
              UIUtils.heightSpace(24),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sudah punya akun?"),
                  UIUtils.widthSpace(16),
                  TextButton(
                    onPressed: onNavigateToLogin,
                    child: Text("Login"),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
