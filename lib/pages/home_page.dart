import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card_project/pages/scan_page.dart';
import 'package:virtual_card_project/provider/state_provider.dart';
import 'package:virtual_card_project/utils/helper_functions.dart';

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
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'All'),

            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
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
                  (context, index) => Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: FractionalOffset.centerRight,
                      padding: EdgeInsets.only(right: 35.0),
                      color: Colors.red,
                      child: Icon(Icons.delete, size: 25, color: Colors.white),
                    ),
                    confirmDismiss: _showMsgDialog,
                    onDismissed: (direction) {
                      provider.deleteContact(provider.contactList[index]);
                      showMsg(context, "Delete");
                    },
                    child: ListTile(
                      title: Text(provider.contactList[index].name!),
                      subtitle: Text(provider.contactList[index].mobile!),
                      trailing: IconButton(
                        onPressed: () {
                          provider.updateContactFavourite(provider.contactList[index]);
                        },
                        icon: Icon(
                          provider.contactList[index].favourite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
            ),
      ),
    );
  }



  Future<bool?> _showMsgDialog(DismissDirection direction) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Contact"),
          content: Text("Do u really wanna delete this contact"),
          actions: [
            OutlinedButton(
              onPressed: () => context.pop(false),
              child: Text("No"),
            ),
            // context.pop(false) here false will be return the in the confirmDismiss parameter of the Dismissible which will then reject the dismiss
            OutlinedButton(
              onPressed: () => context.pop(true),
              child: Text("Yes"),
            ),
            // context.pop(true) here true will be return the in the confirmDismiss parameter of the Dismissible which will then accept the dismiss getstrue and remove the dismissible from the widget tree
          ],
        );
      },
    );
  }
}
