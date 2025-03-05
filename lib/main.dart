import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_card_project/pages/home_page.dart';
import 'package:virtual_card_project/pages/scan_page.dart';

void main() {
  runApp(DevicePreview(enabled: kDebugMode, builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: HomePage.routeName,
        name: HomePage.routeName,
        builder: (context, state) => HomePage(),
        routes: [
          GoRoute(
            path: ScanPage.routeName,
            name: ScanPage.routeName,
            builder: (context, state) => ScanPage(),
          ),
        ],
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: _router,
      builder: EasyLoading.init(), // initialises the flutter EasyLoading object
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
