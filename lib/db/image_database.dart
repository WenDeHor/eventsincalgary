import 'dart:async';
import 'dart:io';

import 'package:eventsincalgary/model/image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ImageDatabase {
  final String imageTable = 'image_table';

  Future<Database> getDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'database_schema');
    var database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    await database.execute(queryToCreateEventTable());
  }

  Future<void> insertOrUpdateImage(String image) async {
    Database db = await getDataBase();
    var newImage = createImage(image);
    int? count = Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM $imageTable"));
    if (count != null && count >= 1) {
      await db.update(imageTable, newImage.toMap(), where: "id = ?", whereArgs: [1]);
    } else {
      await db.insert(
        imageTable,
        newImage.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<ImageEvent>> getAllImages() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> usersMaps = await db.query(imageTable);
    return List.generate(usersMaps.length, (index) {
      return ImageEvent(
        id: usersMaps[index]["id"],
        image: usersMaps[index]["image"],
      );
    });
  }

  Future<ImageEvent> getImageById(int id) async {
    Database db = await getDataBase();
    var data = await db.query(imageTable, where: "id = ?", whereArgs: [id]);
    return data.isNotEmpty ? ImageEvent.fromMap(data.first) : const ImageEvent();
  }

  ImageEvent createImage(String image) {
    return ImageEvent(id: 1, image: image);
  }

  String queryToCreateEventTable() {
    return '''
        CREATE TABLE $imageTable (
        id INTEGER, 
        image TEXT);
        ''';
  }
}
