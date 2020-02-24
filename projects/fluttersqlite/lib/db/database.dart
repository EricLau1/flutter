import 'dart:async';
import 'dart:io';
import '../models/contact.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DB {

  static DB _db;
  static Database _database;
  
  Table table = new Table(
    name: "contacts",
    columns: [
      "id",
      "name",
      "email",
      "image",
    ],
  );
  
  DB._createInstance();

  factory DB() {
    if(_db == null) {
      _db = DB._createInstance(); 
    }
    return _db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db.sqlite";

    var db = await openDatabase(path, version: 1, onCreate: _createTable);

    return db;
  }

  void _createTable(Database db, int newVersion) async {
    var colId = '${table.getColumn('id')} INTEGER PRIMARY KEY AUTOINCREMENT';
    var colName = '${table.getColumn('name')} TEXT';
    var colEmail = '${table.getColumn('email')} TEXT';
    var colImage = '${table.getColumn('image')} TEXT';

    await db.execute('CREATE TABLE ${table.name}($colId, $colName, $colEmail, $colImage)');
  }

  Future<int> insert(Contact contact) async {
    Database db = await this.database;

    var result = await db.insert(table.name, contact.toMap());

    return result;
  }

  Future<Contact> find(int id) async {
    Database db = await this.database;

    List<Map> items = await db.query(
      table.name,
      columns: table.columns,
      where: "${table.getColumn('id')} = ?",
      whereArgs: [id],
    );

    if (items.length > 0) {
      return Contact.fromMap(items.first);
    }

    return null;
  }

  Future<List<Contact>> findAll() async {
    Database db = await this.database;

    var result = await db.query(table.name);

    List<Contact> contacts = [];
    
    if (result.isNotEmpty) {
      contacts = result.map((contact) => Contact.fromMap(contact)).toList();
    }
  
    return contacts;
  }

  Future<int> update(Contact contact) async {
    Database db = await this.database;

    var result = await db.update(
      table.name, 
      contact.toMap(),
      where: "${table.getColumn('id')} = ?",
      whereArgs: [contact.id],
    );

    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.database;

    var result = await db.delete(
      table.name, 
      where: "${table.getColumn('id')} = ?",
      whereArgs: [id],
    );

    return result;
  }

  Future<int> count() async {
    Database db = await this.database;
    List<Map<String,dynamic>> c = await db.rawQuery("SELECT COUNT(*) FROM ${table.name}");

    return Sqflite.firstIntValue(c);
  }

  Future close() async {
    Database db = await this.database; 
    db.close();
  }
}

class Table {
  String name;
  List<String> columns;

  Table({this.name, this.columns});

  String getColumn(String col) {
    var i = this.columns.indexOf(col); // returns -1 if not found
    if (i >= 0) {
       return this.columns[i];
    }
    return "";
  }

  int setColumn(String col) {
    var i = this.columns.indexOf(col);
    if (i < 0) {
      this.columns.add(col);
    }
    return this.columns.length; 
  }
}