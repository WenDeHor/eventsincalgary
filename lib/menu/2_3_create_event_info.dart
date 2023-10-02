import 'dart:convert';

import 'package:eventsincalgary/db/event_database.dart';
import 'package:eventsincalgary/db/image_database.dart';
import 'package:eventsincalgary/db/user_database.dart';
import 'package:eventsincalgary/model/event.dart';
import 'package:eventsincalgary/model/image.dart';
import 'package:eventsincalgary/model/user.dart';
import 'package:eventsincalgary/utils/constants.dart';
import 'package:eventsincalgary/utils/footer_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../utils/app_bar.dart';

const appName = 'Events in Calgary';

class CreateEventInfo extends StatefulWidget {
  const CreateEventInfo({Key? key}) : super(key: key);

  @override
  CreateEventInfoState createState() => CreateEventInfoState();
}

class CreateEventInfoState extends State<CreateEventInfo> {
  late UserDatabase userDatabase = UserDatabase();
  late EventDatabase eventDatabase = EventDatabase();
  late ImageDatabase imageDatabase = ImageDatabase();
  List<Event> eventList = [];
  List<ImageEvent> imageList = [];
  List<User> userList = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    eventDatabase = EventDatabase();
    eventDatabase.getDataBase().whenComplete(() async {
      _getEventInfo();
      setState(() {});
    });

    imageDatabase = ImageDatabase();
    imageDatabase.getDataBase().whenComplete(() async {
      _getImageInfo();
      setState(() {});
    });

    userDatabase = UserDatabase();
    userDatabase.getDataBase().whenComplete(() async {
      _getUserInfo();
      setState(() {});
    });
  }

  void _getEventInfo() async {
    final eventsDB = await eventDatabase.getAllEvents();
    setState(() {
      eventList = eventsDB;
    });
  }

  void _getImageInfo() async {
    final imageDB = await imageDatabase.getAllImages();
    setState(() {
      imageList = imageDB;
    });
  }

  void _getUserInfo() async {
    final usersDB = await userDatabase.getAllUsers();
    setState(() {
      userList = usersDB;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor.revertAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          margin: themeMargin,
          padding: themePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              titleRow(),
              imageField(imageList),
              titleField(),
              descriptionField(),
              addressField(),
              dateField(),
              phoneField(),
              buttonSubmit(),
            ], //
          ),
        ),
      ),
      bottomNavigationBar: FooterBar.getMineBar(context, Colors.brown, Colors.brown, Colors.brown),
    );
  }

  Padding titleRow() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Center(
        child: Text('Creating event',
            style: TextStyle(
                fontFamily: 'DeliciousHandrawn',
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontStyle: FontStyle.italic,
                fontSize: 40.0,
                shadows: [Shadow(offset: Offset(2.0, 2.0), blurRadius: 6.0)])),
      ),
    );
  }

  Padding imageField(List<ImageEvent> imageList) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Center(
        child: SizedBox(
          width: (MediaQuery.of(context).size.width / 100) * 80,
          height: (MediaQuery.of(context).size.height / 100) * 55,
          child: imageList.isNotEmpty && imageList.last.image != null
              ? Image.memory(base64.decode(imageList.last.image!))
              : Image.asset('assets/events.jpg', fit: BoxFit.cover),
        ),
      ),
    );
  }

  Padding titleField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
      child: TextFormField(
        controller: _titleController,
        validator: (value) {
          return validatorInput(value, 3, 30, 'Enter please 3 to 30 characters');
        },
        decoration: const InputDecoration(
            hintText: 'enter title of event',
            hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.normal, fontSize: 15),
            labelText: 'title of event',
            labelStyle: TextStyle(color: Colors.blueGrey, fontStyle: FontStyle.normal, fontSize: 20),
            prefixIcon: Icon(
              Icons.event_available,
              color: Colors.blueGrey,
            ),
            errorStyle: TextStyle(fontSize: 20.0),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.all(Radius.circular(9.0)))),
      ),
    );
  }

  Padding descriptionField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: TextFormField(
        controller: _descriptionController,
        minLines: 1,
        maxLines: 8,
        keyboardType: TextInputType.multiline,
        validator: (value) {
          return validatorInput(value, 3, 100, 'Enter please 3 to 100 characters');
        },
        decoration: const InputDecoration(
            hintText: 'enter description',
            labelText: 'description',
            prefixIcon: Icon(
              Icons.message,
              color: Colors.blueGrey,
            ),
            errorStyle: TextStyle(fontSize: 18.0),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.all(Radius.circular(9.0)))),
      ),
    );
  }

  Padding addressField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
      child: TextFormField(
        controller: _addressController,
        validator: (value) {
          return validatorInput(value, 3, 30, 'Enter please 3 to 30 characters');
        },
        decoration: const InputDecoration(
            hintText: 'enter address of event',
            hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.normal, fontSize: 15),
            labelText: 'address of event',
            labelStyle: TextStyle(color: Colors.blueGrey, fontStyle: FontStyle.normal, fontSize: 20),
            prefixIcon: Icon(
              Icons.location_on_outlined,
              color: Colors.blueGrey,
            ),
            errorStyle: TextStyle(fontSize: 20.0),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.all(Radius.circular(9.0)))),
      ),
    );
  }

  Padding phoneField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
      child: TextFormField(
        controller: _addressController,
        validator: (value) {
          return validatorInput(value, 3, 30, 'Enter please 3 to 30 characters');
        },
        decoration: const InputDecoration(
            hintText: 'enter contact phone number',
            hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.normal, fontSize: 15),
            labelText: 'contact phone number',
            labelStyle: TextStyle(color: Colors.blueGrey, fontStyle: FontStyle.normal, fontSize: 20),
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.blueGrey,
            ),
            errorStyle: TextStyle(fontSize: 20.0),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.all(Radius.circular(9.0)))),
      ),
    );
  }

  Padding dateField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
      child: TextField(
        controller: _dateController,
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_month_outlined),
            labelText: "Enter Date"),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            setState(() {
              _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
            });
          } else {
            //TODO notification
            print("Date is not selected");
          }
        },
      ),
    );
  }

  Padding buttonSubmit() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 30.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 5,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()
                && imageList.isNotEmpty && imageList.last.image != null
                && _dateController.text.isNotEmpty) {
              //TODO save Event to FB
              eventDatabase.createEvent(
                  imageList.last.image!,
                  _phoneController.text,
                  _addressController.text,
                  _dateController.text,
                  _titleController.text,
                  _descriptionController.text,
                  getUserKey(userList));
              showSnackBarBySave('Event was created successfully');
            } else {
              errorToast("All fields must be filled");
              Navigator.pushNamed(context, '/create_event_image');
            }
          },
          child: const Text('Save description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        ),
      ),
    );
  }

  int getUserKey(List<User> list) {
    return list.isNotEmpty && list.first.userKey != null
        ? list.first.userKey!
        : 1;
  }

  dynamic validatorInput(dynamic value, int min, int max, String error) {
    if (value.isEmpty || value.length < min || value.length > max) {
      return error;
    }
    return null;
  }

  Future<String> pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 30);
    var imageBytes = await image!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  void showSnackBarBySave(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ));
  }

  void errorToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.deepOrange[200],
    ));
  }
}
