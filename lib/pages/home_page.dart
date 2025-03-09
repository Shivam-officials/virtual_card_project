import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card_project/pages/scan_page.dart';
import 'package:virtual_card_project/provider/state_provider.dart';

class HomePage extends StatefulWidget {
  static final String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  void didChangeDependencies() {
    context.read<StateProvider>().getAllContact();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact List")),
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
            BottomNavigationBarItem(icon: Expanded(child: Icon(Icons.person)), label: 'All'),

            BottomNavigationBarItem(
              icon: Expanded(child: Icon(Icons.favorite)),
              label: 'Favourite',
            ),
          ],
        ),
      ),
      body: Consumer<StateProvider>(
        builder:
            (context, provider, child) => ListView.builder(
              itemCount: context.read<StateProvider>().contactList.length,
              itemBuilder:
                  (context, index) => ListTile(
                    title: Text(provider.contactList[index].name!),
                    subtitle: Text(provider.contactList[index].mobile!),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        provider.contactList[index].favourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                    ),
                  ),
            ),
      ),
    );
  }
}
