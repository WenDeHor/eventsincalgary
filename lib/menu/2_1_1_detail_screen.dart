import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventsincalgary/db/ticket_database.dart';
import 'package:eventsincalgary/db/user_database.dart';
import 'package:eventsincalgary/model/dto/ticket_dto.dart';
import 'package:eventsincalgary/model/event.dart';
import 'package:eventsincalgary/utils/app_bar.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final TicketDatabase ticketDatabase = TicketDatabase();

  //USER
  final int? userKey;
  final String? userPhone;
  final String? userName;

  //EVENT
  final int id;
  final String image;
  final String phoneContact;
  final String address;
  final String date;
  final String title;
  final String description;
  final int userKeyByEvent;

  DetailScreen({
    super.key,
    required this.id,
    required this.image,
    required this.phoneContact,
    required this.address,
    required this.date,
    required this.title,
    required this.description,
    required this.userKeyByEvent,
    required this.userKey,
    required this.userPhone,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBarConstructor.revertAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: Container(
            padding: const EdgeInsets.all(1),
            child: Row(
              children: [
                fieldImage(context, image),
                fieldTitle(context, title),
                fieldDescription(context, description),
                fieldDateAndAddress(context, date, address),
                fieldPhoneContact(context, phoneContact),
                buttonSubmit(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding fieldImage(BuildContext context, String image) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Center(
        child: SizedBox(
          width: (MediaQuery.of(context).size.width / 100) * 50,
//          height: (MediaQuery.of(context).size.height / 100) * 55,
          child: image.isNotEmpty ? Image.memory(base64.decode(image)) : Image.asset('assets/events.jpg', fit: BoxFit.cover),
        ),
      ),
    );
  }

  Expanded fieldTitle(BuildContext context, String title) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }

  Expanded fieldDescription(BuildContext context, String description) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              description,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Expanded fieldDateAndAddress(BuildContext context, String date, String address) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
          ),
          Text(
            "$date  $address",
            style: TextStyle(color: Colors.grey[500], fontSize: 15),
          ),
        ],
      ),
    );
  }

  Expanded fieldPhoneContact(BuildContext context, String phoneContact) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
          ),
          Text(
            phoneContact,
            style: TextStyle(color: Colors.grey[500], fontSize: 15),
          ),
        ],
      ),
    );
  }

  Padding buttonSubmit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 30.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 5, // <-- match_parent
        height: 50, // <-- match-parent
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ))),
          onPressed: () async {
            FirebaseFirestore.instance.collection('tickets').add({'user_key': userKey, 'event_key': id});
            ticketDatabase.insertTicket(createTicketDto());

            Navigator.pushNamed(context, '/my_tickets');
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Registration for this event has been completed successfully'),
              backgroundColor: Colors.green,
            ));
          },
          child: const Text('Go to app', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        ),
      ),
    );
  }

  TicketDto createTicketDto() {
    return TicketDto(
        eventId: id,
        userKey: userKey,
        userPhone: userPhone,
        userName: userName,
        userTicketNumber: "100",
        //TODO currently no generate
        image: image,
        phoneContact: phoneContact,
        address: address,
        date: date,
        title: title,
        description: description,
        userKeyOfEvent: userKeyByEvent);
  }
}
