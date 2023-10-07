import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventsincalgary/db/event_database.dart';
import 'package:eventsincalgary/db/user_database.dart';
import 'package:eventsincalgary/model/event.dart';
import 'package:eventsincalgary/model/user.dart';
import 'package:eventsincalgary/utils/constants.dart';
import 'package:eventsincalgary/utils/footer_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:eventsincalgary/menu/2_1_1_detail_screen.dart';
import 'package:flutter/material.dart';

import '../utils/app_bar.dart';

const appName = 'Events in Calgary';

List<Event> localEventsList = [];
//List<UserFirebase> uploadPeople = [];
//
//final FirebasePeopleDatabase firebasePeopleDatabase = FirebasePeopleDatabase();
final EventDatabase eventDatabase = EventDatabase();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<MyApp> {
  late UserDatabase userDatabase;
  List<User> _userList = [];

  @override
  void initState() {
    super.initState();
    initFirebase();

    userDatabase = UserDatabase();
    userDatabase.getDataBase().whenComplete(() async {
      _getUserInfo();
      setState(() {});
    });
  }

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp().whenComplete(() {
      print("Firebase loaded");
      setState(() {});
    });
  }

  void _getUserInfo() async {
    final users = await userDatabase.getAllUsers();
    print("++++++++++++++++++${users.toString()}");
    print("++++++++++++++++++${users.length}");
    setState(() {
      _userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor.mineAppBar(context),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('events').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text('Not present events');
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Container(
                        margin: themeMargin,
                        padding: themePadding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            eventFolder(snapshot.data?.docs[index].get('image'), snapshot.data?.docs[index].get('title'),
                                snapshot.data?.docs[index].get('date'), snapshot.data?.docs[index].get('address'), snapshot, index),
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
      bottomNavigationBar: FooterBar.getMineBar(context, Colors.blue, Colors.brown, Colors.brown),
    );
  }

  OutlinedButton eventFolder(String image, String title, String date, String place, AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: Colors.blue,
        minimumSize: const Size(88, 70),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      onPressed: () {
        //TODO show tickets from FB
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              id: snapshot.data?.docs[index].get('id'),
              image: snapshot.data?.docs[index].get('image'),
              phoneContact: snapshot.data?.docs[index].get('phone_contact'),
              address: snapshot.data?.docs[index].get('address'),
              date: snapshot.data?.docs[index].get('data'),
              title: snapshot.data?.docs[index].get('title'),
              description: snapshot.data?.docs[index].get('description'),
              userKeyByEvent: snapshot.data?.docs[index].get('user_key'),
              userKey: _userList.last.userKey!,
              userPhone: _userList.last.phone!,
              userName: _userList.last.name!,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Container(
          padding: const EdgeInsets.all(1),
          child: Row(
            children: [
              fieldImage(image),
              fieldTitle(title, date, place),
            ],
          ),
        ),
      ),
    );
  }

  Padding fieldImage(String image) {
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

  Expanded fieldTitle(String title, String date, String address) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Text(
            "$date  $address",
            style: TextStyle(color: Colors.grey[500], fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class EventPage extends StatelessWidget {
  final String image, phoneContact, address, date, title, description;

  const EventPage({
    super.key,
    required this.image,
    required this.phoneContact,
    required this.address,
    required this.date,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor.mineAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          margin: themeMargin,
          padding: themePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              fieldImage(context, image),
              fieldTitle(title, description, date, address, phoneContact),
              buttonSubmit(context),
            ], //
          ),
        ),
      ),
      bottomNavigationBar: FooterBar.getMineBar(context, Colors.brown, Colors.brown, Colors.brown),
    );
  }

  Padding fieldImage(BuildContext context, String image) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Center(
        child: SizedBox(
          width: (MediaQuery.of(context).size.width / 100) * 80,
          height: (MediaQuery.of(context).size.height / 100) * 55,
          child: image.isNotEmpty ? Image.memory(base64.decode(image)) : Image.asset('assets/events.jpg', fit: BoxFit.cover),
        ),
      ),
    );
  }

  Expanded fieldTitle(String title, String description, String date, String address, String phoneContact) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            description,
            style: TextStyle(color: Colors.grey[500], fontSize: 15),
          ),
          Text(
            phoneContact,
            style: TextStyle(color: Colors.grey[500], fontSize: 15),
          ),
          Text(
            address,
            style: TextStyle(color: Colors.grey[500], fontSize: 15),
          ),
          Text(
            date,
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
          onPressed: () {
            //TODO save ticket to FB
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Success!'),
              backgroundColor: Colors.green,
            ));
          },
          child: const Text('Take the ticket', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        ),
      ),
    );
  }
}
