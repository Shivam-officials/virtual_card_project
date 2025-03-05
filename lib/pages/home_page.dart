import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_card_project/pages/scan_page.dart';

class HomePage extends StatefulWidget {
  static final String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          context.goNamed(ScanPage.routeName);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          currentIndex: selectedIndex,
          backgroundColor: Colors.blue[100],
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'All'),

            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourite',
            ),
          ],
        ),
      ),
    );
  }
}
