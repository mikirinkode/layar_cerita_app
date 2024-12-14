import 'package:flutter/material.dart';
import 'package:layar_cerita_app/presentation/module/login/login_provider.dart';
import 'package:layar_cerita_app/presentation/module/register/register_provider.dart';
import 'package:provider/provider.dart';
import 'package:layar_cerita_app/presentation/module/register/register_page.dart';

import 'di/injection.dart';
import 'presentation/module/home/home_page.dart';
import 'presentation/module/home/home_provider.dart';
import 'presentation/module/login/login_page.dart';
import 'presentation/route/router_delegate.dart';
import 'presentation/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final injection = await Injection.instance.initialize();

  final prefs = injection.sharedPreferencesService;
  final isLoggedIn = await prefs.getIsLoggedIn();

  debugPrint("main");
  debugPrint("isLoggedIn: $isLoggedIn");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(
            authRepository: injection.authRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(
            authRepository: injection.authRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(
            storyRepository: injection.restaurantRepository,
          ),
        ),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppRouterDelegate appRouterDelegate;

  @override
  void initState() {
    super.initState();
    appRouterDelegate = AppRouterDelegate(widget.isLoggedIn);
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
