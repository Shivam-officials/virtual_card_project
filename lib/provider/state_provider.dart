import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card_project/models/contact_model.dart';

import '../db/DbHelper.dart';

class StateProvider extends ChangeNotifier{

  final _db = DbHelper();
  List<ContactModel> contactList =[];

  //todo why do am i returning the future should i have been like the viewmodel had it finished just like the any other normal function making it return the int or other diff value instead of future
  Future<int> insertContact(ContactModel contactModel) async{
  final id = await  _db.insertContact(contactModel);
  contactModel.id = id;
  contactList.add(contactModel);
  notifyListeners();
  return id;
}

 Future<void> getAllContact()async{
    contactList = await _db.getAllContacts();
    notifyListeners();
 }

}