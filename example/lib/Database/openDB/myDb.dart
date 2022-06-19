import 'dart:io';

import 'package:arcore_flutter_plugin_example/Database/models/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ar_project.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
          id INTEGER PRIMARY KEY,
          firstName TEXT,
          lastName TEXT,
          username TEXT,
          token TEXT,
          email TEXT,
          password TEXT,
          type_user TEXT
      )
      ''');
  }
  Future<List<User>> getUsers() async {
    Database db = await instance.database;
    var users = await db.query('users', orderBy: 'username');
    List<User> userList = users.isNotEmpty
        ? users.map((c) => User.fromMap(c)).toList()
        : [];
    return userList;
  }


  Future<int> add(User user) async {
    Database db = await instance.database;
    return await db.insert('users', user.toMap());
  }
  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
  Future<int> removeall() async {
    Database db = await instance.database;
    return await db.delete('users');
  }
}