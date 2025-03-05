import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_card_project/pages/home_page.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
