import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layar_cerita_app/presentation/theme/app_button_style.dart';

import '../../../utils/ui_utils.dart';
import '../../theme/app_color.dart';

class LoginPage extends StatelessWidget {
  final Function() onNavigateToRegister;

  const LoginPage({super.key, required this.onNavigateToRegister});

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
                  child: Text("Login"),
                ),
              ),
              UIUtils.heightSpace(24),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun?"),
                  UIUtils.widthSpace(16),
                  TextButton(
                    onPressed: onNavigateToRegister,
                    child: Text("Daftar"),
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
