import 'dart:async';
import 'dart:io';

import 'package:eventsincalgary/model/dto/ticket_dto.dart';
import 'package:eventsincalgary/model/dto/user_dto.dart';
import 'package:eventsincalgary/model/ticket.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/user.dart';

class TicketDatabase {
  final String ticketTable = 'ticket_table';

  Future<Database> getDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'database_schema');
    var database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    await database.execute(queryToCreateTicketTable());
  }

  Future<void> insertTicket(TicketDto ticketDto) async {
    Database db = await getDataBase();
    int? count = Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM $ticketTable"));
    if (count != null && count >= 1) {
      await db.rawDelete("DELETE FROM $ticketTable");
    }
    await db.insert(
      ticketTable,
      ticketDto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Ticket>> getAllTicket() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> map = await db.query(ticketTable);
    return List.generate(map.length, (index) {
      return Ticket(
          id: map[index]["id"],
          eventId: map[index]["event_id"],
          userKey: map[index]["user_key"],
          userPhone: map[index]["user_phone"],
          userName: map[index]["user_name"],
          userTicketNumber: map[index]["user_ticket_number"],
          image: map[index]["image"],
          phoneContact: map[index]["phone_contact"],
          address: map[index]["address"],
          date: map[index]["date"],
          title: map[index]["title"],
          description: map[index]["description"],
          userKeyOfEvent: map[index]["user_key_of_event"]);
    });
  }

  Future<Ticket> getUserById(int id) async {
    Database db = await getDataBase();
    var data = await db.query(ticketTable, where: "id = ?", whereArgs: [id]);
    return data.isNotEmpty ? Ticket.fromMap(data.first) : const Ticket();
  }

  TicketDto createUserDto(int eventId, int userKey, String userPhone, String userName, String userTicketNumber, String image, String phoneContact,
      String address, String date, String title, String description, int userKeyOfEvent) {
    return TicketDto(
        eventId: eventId,
        userKey: userKey,
        userPhone: userPhone,
        userName: userName,
        userTicketNumber: userTicketNumber,
        image: image,
        phoneContact: phoneContact,
        address: address,
        date: date,
        title: title,
        description: description,
        userKeyOfEvent: userKeyOfEvent);
  }

  String queryToCreateTicketTable() {
    return '''
        CREATE TABLE $ticketTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        event_id INTEGER, 
        user_key INTEGER,   
        user_phone TEXT, 
        user_name TEXT, 
        user_ticket_number TEXT,
        image TEXT,
        phone_contact TEXT,
        address TEXT,
        date TEXT,
        title TEXT,
        description TEXT,
        user_key_of_event INTEGER);
        ''';
  }
}
