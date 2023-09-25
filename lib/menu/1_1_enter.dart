import 'package:eventsincalgary/utils/footer_bar.dart';
import 'package:flutter/material.dart';
import '../utils/app_bar.dart';

class UserEnter extends StatefulWidget {
  const UserEnter({Key? key}) : super(key: key);

  @override
  UserEnterState createState() => UserEnterState();
}

class UserEnterState extends State<UserEnter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor.loginAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Form(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/events.jpg', fit: BoxFit.cover),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Hello.  We are glad to welcome you. We sincerely invite you to register and continue your journey in the application in search of new and interesting events.',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'DeliciousHandrawn',
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 40.0,
                            shadows: [Shadow(offset: Offset(2.0, 2.0), blurRadius: 6.0)]),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: FooterBar.getLoginBar(context, Colors.blue, Colors.brown, Colors.brown, Colors.brown),
    );
  }
}
