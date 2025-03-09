import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as P;
import 'package:virtual_card_project/models/contact_model.dart';

class DbHelper {

  

  final _createTableContact =
      '''create table ${DbContactConstants.tableContact}(
  ${DbContactConstants.tableContactColId} integer primary key autoincrement,
  ${DbContactConstants.tableContactColName} text,
  ${DbContactConstants.tableContactColMobile} text,
  ${DbContactConstants.tableContactColEmail} text,
  ${DbContactConstants.tableContactColAddress} text,
  ${DbContactConstants.tableContactColDesignation} text,
  ${DbContactConstants.tableContactColCompany} text,
  ${DbContactConstants.tableContactColWebsite} text,
  ${DbContactConstants.tableContactColFavorite} integer)''';

  Future<Database> open() async {
    final root =
        await getDatabasesPath(); // get the string which will point to the root of the database of our app in the android app
    debugPrint(' the root address of db is --> $root');
    final dbPath = P.join(root,'contact.db',); // make a Database file contact.db at the location root path inside which our tables will be stored

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        // opens the database at the given path and return the db object already created one .. and if not created then return it after creating the database object
        db.execute(
          _createTableContact,
        ); // execute the sql command since we are in the onCreate ftn which would be executed for the first time when the database object is created when can use this opportunity to create  database tables and some sql setup for our db
      },
    );
  }

  Future<int> insertContact(ContactModel contactModel) async {
    final db =
        await open(); // first get the database object to do any operations
    final id =  db.insert(
      DbContactConstants.tableContact,
      contactModel.toMap(),
    ); // insert the row in table and returns the id of it
    // db.close(); // generally we dont need to close the database object manually bcz flutter sqflite is smart enough to close it after the function has something to return in this case .. bt i have to done for learning purposes
    return id;
  }

  Future<List<ContactModel>> getAllContacts() async {
    final db = await open();
    final mapList = await db.query(DbContactConstants.tableContact);
    return mapList.map((contact)=>ContactModel.fromMap(contact)).toList();

  }

  Future<int> deleteContact(int id) async{
    final db = await open();
    return db.delete(DbContactConstants.tableContact,where: ' ${DbContactConstants.tableContactColId}:?',whereArgs: [id]);
  }
}
