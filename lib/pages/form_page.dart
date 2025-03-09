import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card_project/models/contact_model.dart';
import 'package:virtual_card_project/pages/home_page.dart';
import 'package:virtual_card_project/provider/state_provider.dart';
import 'package:virtual_card_project/utils/constants.dart';
import 'package:virtual_card_project/utils/helper_functions.dart';

class FormPage extends StatefulWidget {
  final ContactModel contactDetails;
  static const String routeName = 'formPage';
  const FormPage({super.key, required this.contactDetails});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final companyController = TextEditingController();
  final designationController = TextEditingController();
  final websiteController = TextEditingController();

  final _formKey =
      GlobalKey<
        FormState
      >(); // to globally recognise the form we have to declare the key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Form Page'),
        actions: [IconButton(onPressed: saveContact, icon: Icon(Icons.save))],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              controller: nameController,
              decoration: InputDecoration(label: Text('contact name')),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return errMsg;
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: mobileController,
              decoration: InputDecoration(label: Text('Phone No')),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return errMsg;
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(label: Text('email address')),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: addressController,
              decoration: InputDecoration(label: Text('address')),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: designationController,
              decoration: InputDecoration(label: Text('designation')),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: companyController,
              decoration: InputDecoration(label: Text('company')),
            ),
            TextFormField(
              keyboardType: TextInputType.webSearch,
              controller: websiteController,
              decoration: InputDecoration(label: Text('website')),
            ),
          ],
        ),
      ),
    );
  }

  /// as soon this page is contructed we have to assign the values from the contactModel
  /// to textControllers so that we already have the data filled in the textFormfield
  @override
  void initState() {
    emailController.text = widget.contactDetails.email ?? '';
    nameController.text = widget.contactDetails.name ?? '';
    mobileController.text = widget.contactDetails.mobile ?? '';
    addressController.text = widget.contactDetails.address ?? '';
    companyController.text = widget.contactDetails.company ?? '';
    designationController.text = widget.contactDetails.designation ?? '';
    websiteController.text = widget.contactDetails.website ?? '';
    super.initState();
  }

  /// whenever we have the controllers inside the state object we have to dispose them
  /// as soon as the state object destroys so we have to override the defualt dispose method
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    mobileController.dispose();
    companyController.dispose();
    designationController.dispose();
    websiteController.dispose();

    super.dispose();
  }

  void saveContact() {
    if (_formKey.currentState!.validate()) {
      // if all the formfields are validated then execute the block
      widget.contactDetails.name = nameController.text;
      widget.contactDetails.email = emailController.text;
      widget.contactDetails.mobile = mobileController.text;
      widget.contactDetails.address = addressController.text;
      widget.contactDetails.company = companyController.text;
      widget.contactDetails.designation = designationController.text;
      widget.contactDetails.website = websiteController.text;
    }
    debugPrint(widget.contactDetails.toMap().toString());
    context.read<StateProvider>().insertContact(widget.contactDetails)
    .then((onValue){
      showMsg(context, "saved");
    }).catchError((error){
      showMsg(context, "Failed To save bcz ${error.toString()}");
    });

    context.goNamed(HomePage.routeName);
  }
}
