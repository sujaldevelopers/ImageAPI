import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_image_api/helper/round_btn.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:my_image_api/helper/utilis.dart';

class UplodeImage extends StatefulWidget {
  const UplodeImage({super.key});

  @override
  State<UplodeImage> createState() => _UplodeImageState();
}

class _UplodeImageState extends State<UplodeImage> {
  File? _image;
  bool loding = false;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseref = FirebaseDatabase.instance.ref();

  Future getImageGallery() async {
    final pickfile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    setState(() {
      if (pickfile != null) {
        _image = File(pickfile.path);
      } else {
        print("No image Pick");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Uplode image"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    getImageGallery();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: _image != null
                        ? Image.file(_image!.absolute)
                        : Center(child: Icon(Icons.image)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RoundButton(
                  text: "Uplode",
                  IsLoding: loding,
                  onTap: () async {
                    setState(() {
                      loding = true;
                    });
                    firebase_storage.Reference ref =
                        firebase_storage.FirebaseStorage.instance.ref(
                      'TaTa' + DateTime.now().microsecondsSinceEpoch.toString(),
                    );
                    firebase_storage.UploadTask uploadTask =
                        ref.putFile(_image!.absolute);

                    Future.value(uploadTask).then((value) async {
                      var newUrl = await ref.getDownloadURL();
                      databaseref.child('1').set({
                        'id': '1',
                        'title': newUrl.toString(),
                      }).then((value) {
                        setState(() {
                          loding = false;
                        });
                        Utilis().toastMessage("Uploded");
                      }).onError((error, stackTrace) {
                        setState(() {
                          loding = false;
                        });
                      });
                    }).onError((error, stackTrace) {
                      Utilis().toastMessage(error.toString());
                    });
                    setState(() {
                      loding = false;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
