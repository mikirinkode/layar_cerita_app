import 'package:flutter/material.dart';
import 'package:layar_cerita_app/presentation/module/register/register_page.dart';

import 'presentation/module/home/home_page.dart';
import 'presentation/module/login/login_page.dart';
import 'presentation/route/router_delegate.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppRouterDelegate appRouterDelegate;

  @override
  void initState() {
    super.initState();
    appRouterDelegate = AppRouterDelegate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LayarCerita',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      home: Router(
        routerDelegate: appRouterDelegate,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
