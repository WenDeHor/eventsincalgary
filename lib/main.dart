import 'package:eventsincalgary/menu/1_4_license.dart';
import 'package:eventsincalgary/menu/2_1_mine_screan.dart';
import 'package:eventsincalgary/menu/2_2_create_event_image.dart';
import 'package:eventsincalgary/menu/2_3_create_event_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eventsincalgary/menu/1_1_enter.dart';
import 'package:eventsincalgary/menu/1_2_login.dart';
import 'package:eventsincalgary/menu/1_3_registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white70),
      initialRoute: '/user_enter',
      routes: {
        '/user_enter': (context) => const UserEnter(),
        '/user_login': (context) => const UserLogin(),
        '/user_registration': (context) => const UserRegistration(),
        '/license': (context) => const UserLicense(),

        '/events': (context) => const MyApp(),
        '/create_event_image': (context) => const CreateEventImage(),
        '/create_event_info': (context) => const CreateEventInfo(),
//        '/my_tickets': (context) => const MyTickets(),

//        buttonForm(context, "Events", Icons.home_filled, eventList, '/events'),
//        buttonForm(context, "Create Event", Icons.api, createEvent, '/create_event'),
//        buttonForm(context, "My tickets", Icons.add_chart, myTickets, '/my_tickets'),

//        '/user_login': (context) => const UserLogin(),
//        '/user_registration': (context) => const UserRegistration(),
//        '/event-page': (context) => const EventPage(),

//        '/user_registration': (context) => const UserRegistration(),
//        '/license': (context) => const UserLicense(),
//        '/flip_card': (context) => const EditUserFlipCard(),
//        '/list_card': (context) => const EditUserListCard(),
//        '/searcher': (context) => const Searcher(),
      },
    ),
//    ),
  );
}
