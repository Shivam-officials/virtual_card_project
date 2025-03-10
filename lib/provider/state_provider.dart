import 'package:flutter/cupertino.dart';
import 'package:virtual_card_project/models/contact_model.dart';

import '../db/DbHelper.dart';

class StateProvider extends ChangeNotifier {
  final _db = DbHelper();
  List<ContactModel> contactList = [];

  // TODO: Why am I returning a Future? Should I have made it like a normal function
  // returning an int or another value directly instead of a Future?
  /// The reason for returning a Future is that it allows asynchronous control
  /// over when this operation finishes. This way, we can perform additional operations
  /// on the Future, such as using the `then()` method to execute code once the Future completes.
  /// For example, we can show a Snackbar confirming the successful insertion of data.
  /// If this function returned a simple int instead of a Future, we wouldn't be able
  /// to perform such asynchronous operations effectively.
  Future<int> insertContact(ContactModel contactModel) async {
    final id = await _db.insertContact(contactModel);
    contactModel.id = id;
    contactList.add(contactModel);
    notifyListeners();
    return id;
  }

  Future<void> getAllContact() async {
    contactList = await _db.getAllContacts();
    notifyListeners();
  }

  Future<int> deleteContact(ContactModel contactModel) async {
    contactList.remove(contactModel);
    /// here we don't need notifyListeners() method bcz we don't need to rebuild
    /// the ui to reflect the new list bcz dismissible has already
    /// removed that contactItem ListTile from the widget tree
    return _db.deleteContact(contactModel.id);
  }
}
