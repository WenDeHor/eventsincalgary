import 'dart:async';
import 'dart:io';

import 'package:eventsincalgary/model/dto/event_dto.dart';
import 'package:eventsincalgary/model/event.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class EventDatabase {
  final String eventTable = 'event_table';

  Future<Database> getDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'database_schema');
    var database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    await database.execute(queryToCreateEventTable());
  }

  Future<void> createEvent(String image, String phoneContact, String address, String data, String title, String description, int userKey) async {
    Database db = await getDataBase();
    var eventDto = createEventDto(image, phoneContact, address, data, title, description, userKey);
    await db.insert(
      eventTable,
      eventDto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Event>> getAllEvents() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> usersMaps = await db.query(eventTable);
    return List.generate(usersMaps.length, (index) {
      return Event(
          id: usersMaps[index]["id"],
          image: usersMaps[index]["image"],
          phoneContact: usersMaps[index]["phone_contact"],
          address: usersMaps[index]["address"],
          date: usersMaps[index]["date"],
          title: usersMaps[index]["title"],
          description: usersMaps[index]["description"],
          userKey: usersMaps[index]["user_key"]);
    });
  }

  Future<Event> getEventById(int id) async {
    Database db = await getDataBase();
    var data = await db.query(eventTable, where: "id = ?", whereArgs: [id]);
    return data.isNotEmpty ? Event.fromMap(data.first) : const Event();
  }

  EventDto createEventDto(String image, String phoneContact, String address, String date, String title, String description, int userKey) {
    return EventDto(image: image, phoneContact: phoneContact, address: address, date: date, title: title, description: description, userKey: userKey);
  }

  String queryToCreateEventTable() {
    return '''
        CREATE TABLE $eventTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        image TEXT, 
        phone_contact TEXT,   
        address TEXT, 
        date TEXT, 
        title TEXT,
        description TEXT,
        user_key INTEGER);
        ''';
  }
}
