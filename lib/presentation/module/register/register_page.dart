import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/ui_utils.dart';
import '../../theme/app_button_style.dart';
import '../../theme/app_color.dart';

class RegisterPage extends StatelessWidget {
  final Function() onNavigateToLogin;
  const RegisterPage({super.key, required this.onNavigateToLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: UIUtils.paddingAll(24),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Nama",
                  prefixIcon: Icon(
                    CupertinoIcons.person_fill,
                    color: AppColor.neutral500,
                  ),
                ),
              ),
              UIUtils.heightSpace(16),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(
                    CupertinoIcons.mail_solid,
                    color: AppColor.neutral500,
                  ),
                ),
              ),
              UIUtils.heightSpace(16),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(
                    CupertinoIcons.lock_fill,
                    color: AppColor.neutral500,
                  ),
                  suffixIcon: Icon(
                    CupertinoIcons.eye_fill,
                    color: AppColor.neutral500,
                  ),
                ),
              ),
              UIUtils.heightSpace(24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
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
      ),
    );
  }
}
