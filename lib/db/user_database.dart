import 'dart:async';
import 'dart:io';

import 'package:eventsincalgary/model/dto/user_dto.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/user.dart';

class UserDatabase {
  final String userTable = 'user_table';

  Future<Database> getDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'database_schema');
    var database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    await database.execute(queryToCreateUserTable());
  }

  Future<void> insertUserRegistration(String phone, String password, String name, int userKey) async {
    Database db = await getDataBase();
    int? count = Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM $userTable"));
    var userDto = createUserDto(phone, password, name, userKey);
    if (count != null && count >= 1) {
      await db.rawDelete("DELETE FROM $userTable");
    }
      await db.insert(
        userTable,
        userDto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
  }

  Future<List<User>> getAllUsers() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> usersMaps = await db.query(userTable);
    return List.generate(usersMaps.length, (index) {
      return User(
          id: usersMaps[index]["id"],
          phone: usersMaps[index]["phone"],
          userKey: usersMaps[index]["user_key"],
          email: usersMaps[index]["email"],
          password: usersMaps[index]["password"],
          name: usersMaps[index]["name"],
          image: usersMaps[index]["image"],
          status: usersMaps[index]["status"]);
    });
  }

  Future<User> getUserById(int id) async {
    Database db = await getDataBase();
    var data = await db.query(userTable, where: "id = ?", whereArgs: [id]);
    return data.isNotEmpty ? User.fromMap(data.first) : const User();
  }

  Future<User> getUserByStatus(int status) async {
    Database db = await getDataBase();
    var data = await db.query(userTable, where: "status = ?", whereArgs: [status]);
    return data.isNotEmpty ? User.fromMap(data.first) : const User();
  }

  UserDto createUserDto(String phone, String password, String name, int userKey) {
    return UserDto(phone: phone, userKey: userKey, email: "email", password: password, name: name, image: "image", status: 1);
  }

  String queryToCreateUserTable() {
    return '''
        CREATE TABLE $userTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        phone TEXT, 
        user_key INTEGER,
        email TEXT, 
        password TEXT, 
        name TEXT, 
        image TEXT,
        status INTEGER );
        ''';
  }
}
