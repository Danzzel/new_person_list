import 'dart:io';
import 'package:new_person_list/models/person.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  String personsTable = 'Persons';
  String columnId = 'id';
  String columnName = 'name';
  String columnLastName = 'lastName';

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Person.db';

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $personsTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT, $columnLastName TEXT) ');
  }

// Read
  Future<List<Person>> getPersons() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> personMapList = await db.query(
      personsTable,
      orderBy: "$columnLastName,  $columnName" 
      
    );
    final List<Person> personsList = [];
    personMapList.forEach((personMap) {
      personsList.add(Person.fromMap(personMap));
    });
    return personsList;
  }

// INSERT
  Future<Person> insertPerson(Person person) async {
    Database db = await this.database;
    person.id =
        await db.insert(personsTable, person.toMap(), nullColumnHack: columnId);
    return person;
  }

  // UPDATE
  Future<int> updatePerson(Person person) async {
    Database db = await this.database;
    return await db.update(
      personsTable,
      person.toMap(),
      where: '$columnId = ?',
      whereArgs: [person.id],
    );
  }

  // Delete
  Future<int> deletePerson(int id) async {
    Database db = await this.database;
    return await db.delete(
      personsTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<List<Person>> selectPerson(String name) async {
    Database db = await this.database;
    final List<Map<String, dynamic>> personMapList = await db.query(
      personsTable,
      columns: ['$columnName, $columnLastName'],
      where: 'LOWER(name)  = ? OR LOWER(lastName) =?',
      whereArgs: ['$name', '$name'],
    );

    final List<Person> selectedPersonList = [];
    personMapList.forEach((personMap) {
      selectedPersonList.add(Person.fromMap(personMap));
    });
    return selectedPersonList;
  }
}
