import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqlite_api.dart';

class ContactDao {
  static const String _tableName = 'Contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  static const String tablesql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY,'
      '$_name TEXT NOT NULL,'
      '$_accountNumber INTEGER NOT NULL)';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    return db.insert(_tableName, contact.toMap());
  }

  Future<List<Contact>> getAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> response = await db.query(_tableName);

    List<Contact> contacts = _toList(response);
    return contacts;
  }

  Future<int> delete(Contact contact) async {
    final Database db = await getDatabase();
    return await db
        .delete(_tableName, where: 'id = ?', whereArgs: [contact.id]);
  }

  Future<void> update(Contact contact) async {
    final Database db = await getDatabase();
    db.update(_tableName, contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  List<Contact> _toList(List<Map<String, dynamic>> response) {
    final List<Contact> contacts = [];

    for (Map<String, dynamic> row in response) {
      final Contact contact =
          Contact(row[_id], row[_name], row[_accountNumber]);
      contacts.add(contact);
    }
    return contacts;
  }
}
