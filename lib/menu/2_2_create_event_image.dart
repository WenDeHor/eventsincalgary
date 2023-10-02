import 'dart:convert';

import 'package:eventsincalgary/db/image_database.dart';
import 'package:eventsincalgary/model/image.dart';
import 'package:eventsincalgary/utils/constants.dart';
import 'package:eventsincalgary/utils/footer_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_bar.dart';

const appName = 'Events in Calgary';

class CreateEventImage extends StatefulWidget {
  const CreateEventImage({Key? key}) : super(key: key);

  @override
  CreateEventImageState createState() => CreateEventImageState();
}

class CreateEventImageState extends State<CreateEventImage> {
  late ImageDatabase imageDatabase = ImageDatabase();
  List<ImageEvent> imageList = [];
  final MaterialStatesController _imageController = MaterialStatesController();

  @override
  void initState() {
    super.initState();
    imageDatabase = ImageDatabase();
    imageDatabase.getDataBase().whenComplete(() async {
      _getImageInfo();
      setState(() {});
    });
  }

  void _getImageInfo() async {
    final imageDB = await imageDatabase.getAllImages();
    setState(() {
      imageList = imageDB;
    });
  }

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
              titleRow(),
              imageField(imageList),
            ], //
          ),
        ),
      ),
      bottomNavigationBar: FooterBar.getMineBar(context, Colors.brown, Colors.blue, Colors.brown),
    );
  }

  Padding titleRow() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Center(
        child: Text('Creat event. Adding image',
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

  Padding buttonUploadImage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 30.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: ElevatedButton(
          statesController: _imageController,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          onPressed: () async {
            String byte64String;
            try {
              byte64String = await pickImage();
              if (byte64String.isNotEmpty) {
                imageDatabase.insertOrUpdateImage(byte64String);
                showSnackBarBySave('image loaded success');
//                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => super.widget));
                Navigator.popAndPushNamed(context, '/create_event_info');
              } else{
                errorToast("Please upload image of event");
              }
            } catch (e) {
              errorToast("Image not upload");
            }
          },
          child: const Text(
            'Upload photo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
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
