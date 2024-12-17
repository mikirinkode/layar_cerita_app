import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layar_cerita_app/presentation/module/login/login_provider.dart';
import 'package:layar_cerita_app/presentation/theme/app_button_style.dart';
import 'package:layar_cerita_app/utils/ui_state.dart';
import 'package:provider/provider.dart';

import '../../../utils/regexp_utils.dart';
import '../../../utils/ui_utils.dart';
import '../../global_widgets/error_state_view.dart';
import '../../global_widgets/loading_indicator.dart';
import '../../theme/app_color.dart';

class LoginPage extends StatelessWidget {
  final Function() onNavigateToRegister;
  final Function() onNavigateToHome;

  const LoginPage(
      {super.key,
      required this.onNavigateToRegister,
      required this.onNavigateToHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Stack(
              children: [
                body(),
                provider.loginState.when(
                  onInitial: () => const SizedBox(),
                  onLoading: (message) => Center(
                    child: LoadingIndicator(message: message),
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
    return Consumer<LoginProvider>(builder: (context, provider, child) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: UIUtils.paddingAll(24),
        child: Form(
          key: provider.loginFormKey,
          child: Column(
            children: [
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
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Password tidak boleh kosong.";
                  } else {
                    return null;
                  }
                },
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
                    provider.login(
                      onLoginSuccess: () {
                        debugPrint("onLoginSuccess");
                        onNavigateToHome();
                      },
                    );
                  },
                  style: AppButtonStyle.filledPrimary,
                  child: const Text("Login"),
                ),
              ),
              UIUtils.heightSpace(24),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum punya akun?"),
                  UIUtils.widthSpace(16),
                  TextButton(
                    onPressed: onNavigateToRegister,
                    child: const Text("Daftar"),
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
