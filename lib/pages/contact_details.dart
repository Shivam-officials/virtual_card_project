import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card_project/provider/state_provider.dart';

class ContactDetails extends StatefulWidget {
  static final String routeName = 'contactDetails';
  final int contactId;

  const ContactDetails({super.key, required this.contactId});

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  late int id;

  @override
  void initState() {
    id = widget.contactId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final currentContact = context.read<StateProvider>().getContactById(id);
    return Scaffold(
      appBar: AppBar(title: Text("Contact Detail")),
      body: FutureBuilder(
        future: context.read<StateProvider>().getContactById(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final contact = snapshot.data!;
            return ListView(
              padding: EdgeInsets.all(8),
              children: [
                Image.file(File(contact.image!),width: double.infinity,height: 250 ),
                ListTile(
                  title: Text(contact.mobile!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.call)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.message)),
                    ],
                  ),
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "There is an error in fetchign data ${snapshot.error.toString()}",
              ),
            );
          }

          return const Center(child: Text("Data has yet to come"));
        },
      ),
    );
  }
}
