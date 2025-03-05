import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'homePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact List")),
      body: Center(
        child: Text(
          "This is the HomePage",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
