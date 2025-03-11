import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:virtual_card_project/provider/state_provider.dart';
import 'package:virtual_card_project/utils/helper_functions.dart';

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
                Image.file(
                  File(contact.image!),
                  width: double.infinity,
                  height: 250,
                ),
                ListTile(
                  title: Text(contact.mobile!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed:
                            () => doPhoneNumberAction('tel', contact.mobile!),
                        icon: Icon(Icons.call),
                      ),
                      IconButton(
                        onPressed:
                            () => doPhoneNumberAction('sms', contact.mobile!),
                        icon: Icon(Icons.message),
                      ),
                    ],
                  ),
                ),
                if(contact.email != null && contact.email!.isNotEmpty)ListTile(
                  title: Text(contact.email!),
                  trailing: IconButton(onPressed: () =>doPhoneNumberAction('mailto', contact.email!),
                  icon: Icon(Icons.mail_outline_sharp)),
                ),
                if(contact.address != null && contact.address!.isNotEmpty)ListTile(
                  title: Text(contact.address!),
                  trailing: IconButton(onPressed:()=> _openMap(contact.address!),
                      icon: Icon(Icons.navigation)),
                ),
                if(contact.website != null && contact.website!.isNotEmpty)ListTile(
                  title: Text(contact.website!),
                  trailing: IconButton(onPressed: () =>doPhoneNumberAction('https', contact.website!),
                  icon: Icon(Icons.web_sharp)),
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

  Future<void> doPhoneNumberAction(String uriScheme, String data) async {
    //urlSchemes:: for call => tel:<phone number> & for sms => sms:<phone number>
    final url = '$uriScheme:$data';

    // checks if there is an app to handle that scheme
    if (await canLaunchUrlString(url)) {

      // execute that urlScheme and OS will find the app to execute that scheme automaticaly
      launchUrlString(url);
    }else{
      showMsg(context, 'cannot perfrom this task');
    }
  }

   Future<void> _openMap(String address ) async{

    final value = address.replaceAll(' ', '+');
    String url = '';
    if (Platform.isAndroid) {
      url = 'geo:0,0?q=$value'; // for android
    }else{
      url = 'http://maps.apple.com/?q=$url'; // for ios
    }

    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    }else{
      showMsg(context, 'cannot perfrom this task');
    }

  }
}
