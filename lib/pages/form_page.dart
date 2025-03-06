import 'package:flutter/material.dart';
import 'package:virtual_card_project/models/ContactModel.dart';

class FormPage extends StatefulWidget {
  final ContactModel contactDetails;
  static final String routeName = 'formPage';
  const FormPage({super.key, required this.contactDetails});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.contactDetails.name!)),
    );
  }
}
