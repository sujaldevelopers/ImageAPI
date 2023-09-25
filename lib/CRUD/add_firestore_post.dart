import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_image_api/helper/round_btn.dart';
import 'package:my_image_api/helper/utilis.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:my_image_api/image/uplode_image.dart';

import 'image_pic.dart';

class AddFireStorePosts extends StatefulWidget {
  const AddFireStorePosts({super.key});

  @override
  State<AddFireStorePosts> createState() => _AddFireStorePostsState();
}

class _AddFireStorePostsState extends State<AddFireStorePosts> {
  final postcontroller = TextEditingController();
  File? file;
  bool loding = false;
  final picker = ImagePicker();
  final fireStore = FirebaseFirestore.instance.collection('user');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseref = FirebaseDatabase.instance.ref();

  Future getImageGallery() async {
    final pickfile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    setState(() {
      if (pickfile != null) {
        file = File(pickfile.path);
      } else {
        print("No image Pick");
      }
    });
  }

  // @override
  // void initState() {
  //   fireStore.collection('users').doc();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add FireStore Post"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        getImageGallery();
                      },
                      child: Center(
                        child: Container(
                          height: 450,
                          width: 450,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: file != null
                              ? Image.file(file!.absolute)
                              : Icon(Icons.image),
                        ),
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
                          'TaTa' +
                              DateTime.now().microsecondsSinceEpoch.toString(),
                        );
                        firebase_storage.UploadTask uploadTask =
                            ref.putFile(file!.absolute);

                        Future.value(uploadTask).then((value) async {
                          var newUrl = await ref.getDownloadURL();
                          databaseref.child('1').set({
                            'id': '1',
                            'url': newUrl.toString(),
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
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postcontroller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "drow Your Idea?",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            RoundButton(
              text: "Add",
              IsLoding: loding,
              onTap: () {
                setState(() {
                  loding = true;
                });
                firebase_storage.Reference ref =
                    firebase_storage.FirebaseStorage.instance.ref(
                  'TaTa' + DateTime.now().microsecondsSinceEpoch.toString(),
                );
                firebase_storage.UploadTask uploadTask =
                    ref.putFile(file!.absolute);

                String id = DateTime.now().millisecondsSinceEpoch.toString();
                fireStore.doc(id).set({
                  'title': postcontroller.text.toString(),
                  'id': id,
                  //'image':newUrl.toString(),
                }).then((value) {
                  setState(() {
                    loding = false;
                  });
                  Utilis().toastMessage('Post Add');
                }).onError((error, stackTrace) {
                  setState(() {
                    loding = false;
                  });
                  Utilis().toastMessage(error.toString());
                });
                Future.value(uploadTask).then((value) async {
                  var newUrl = await ref.getDownloadURL();
                  databaseref.child('1').set({
                    'id': '1',
                    'image': newUrl.toString(),
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
                //return Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
/*onTap: () {
              setState(() {
                loding = true;
              });
              firebase_storage.Reference ref =
              firebase_storage.FirebaseStorage.instance.ref(
                'TaTa' + DateTime.now().microsecondsSinceEpoch.toString(),
              );
              firebase_storage.UploadTask uploadTask =
              ref.putFile(file!.absolute);

              String id = DateTime.now().millisecondsSinceEpoch.toString();
              fireStore.doc(id).set({
                'title': postcontroller.text.toString(),
                'id': id,
              }).then((value) {
                setState(() {
                  loding = false;
                });
                Utilis().toastMessage('Post Add');
              }).onError((error, stackTrace) {
                setState(() {
                  loding = false;
                });
                Utilis().toastMessage(error.toString());
              });
              //return Navigator.pop(context);
            },*/
