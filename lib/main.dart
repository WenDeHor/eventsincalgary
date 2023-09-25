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
