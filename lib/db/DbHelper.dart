import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as P;
import 'package:sqflite/sqflite.dart';
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
  ${DbContactConstants.tableContactColFavorite} integer,
  ${DbContactConstants.tableContactColImage} text)''';

  ///returns the database object for any database operation
  Future<Database> _open() async {
    // get the string which will point to the root of the database of our app in the android app
    final root = await getDatabasesPath();

    debugPrint(' the root address of db is --> $root');

    // make a Database file contact.db at the location root path inside which our tables will be stored
    final dbPath = P.join(root, 'contact2.db');

    // opens the database at the given path and return the db object already created one ..
    // and if not created then return it after creating the database object
    return openDatabase(
      dbPath,
      version: 1,
      onDowngrade: (db, oldVersion, newVersion) { db.execute(_createTableContact);},
      onCreate: (db, version) {
        /// execute the sql command since we are in the onCreate ftn which would be executed for the
        /// first time when the database object is created when can use this opportunity to create
        /// database tables and some sql setup for our db
        db.execute(_createTableContact);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1) {
          db.execute(
            'alter table ${DbContactConstants.tableContact} rename to tbl_contact_old',
          );
          db.execute(_createTableContact);
          final rows = await db.query('tbl_contact_old');
          for (final row in rows) {
            db.insert(DbContactConstants.tableContact, row);
          }
          db.execute("drop table if exists tbl_contact_old ");
        }
      },
    );
  }

  Future<int> insertContact(ContactModel contactModel) async {
    final db =
        await _open(); // first get the database object to do any operations

    // insert the row in table and returns the id of it
    final id = db.insert(DbContactConstants.tableContact, contactModel.toMap());

    // db.close(); // generally we dont need to close the database object manually bcz flutter sqflite
    // is smart enough to close it after the function has something to return in this case ..
    // bt i have to done for learning purposes
    return id;
  }

  Future<List<ContactModel>> getAllContacts() async {
    final db = await _open();
    final mapList = await db.query(DbContactConstants.tableContact);
    return mapList.map((contact) => ContactModel.fromMap(contact)).toList();
  }

  Future<int> deleteContact(int id) async {
    final db = await _open();
    return db.delete(
      DbContactConstants.tableContact,
      where: ' ${DbContactConstants.tableContactColId} = ?',
      // this ? is acts as a placeholder for the whereArgs values
      // where: ' ${DbContactConstants.tableContactColId} = ? and ${DbContactConstants.tableContactColFavorite} = ?',
      whereArgs: [id],
      // whereArgs: [id,false],
    );
  }

  Future<int> updateContactFavourite(ContactModel contact) async {
    final db = await _open();
    final value = contact.favourite ? 1 : 0;
    return db.update(
      DbContactConstants.tableContact,
      {DbContactConstants.tableContactColFavorite: value},
      where: "${DbContactConstants.tableContactColId} = ?",
      whereArgs: [contact.id],
    );
  }

  Future<int> updateContact(ContactModel contact) async {
    final db = await _open();

    return db.update(
      DbContactConstants.tableContact,
      contact.toMap(),
      where: "${DbContactConstants.tableContactColId} = ?",
      whereArgs: [contact.id],
    );
  }

  Future<List<ContactModel>> getAllFavouriteContacts() async {
    final db = await _open();
    final mapList = await db.query(
      DbContactConstants.tableContact,
      where: '${DbContactConstants.tableContactColFavorite} = ?',
      whereArgs: [true],
    );
    return mapList.map((contact) => ContactModel.fromMap(contact)).toList();
  }

  Future<ContactModel> getContactById(int id) async {
    final db = await _open();
    final mapList = await db.query(
      DbContactConstants.tableContact,
      where: "${DbContactConstants.tableContactColId}= ?",
      whereArgs: [id],
    );
    return ContactModel.fromMap(mapList.first);
  }
}
