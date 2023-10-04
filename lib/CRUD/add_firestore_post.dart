import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_image_api/helper/round_btn.dart';
import 'package:my_image_api/helper/utilis.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

class AddFireStorePosts extends StatefulWidget {
  const AddFireStorePosts({super.key});

  @override
  State<AddFireStorePosts> createState() => _AddFireStorePostsState();
}

class _AddFireStorePostsState extends State<AddFireStorePosts> {
  final postcontroller = TextEditingController();
  final descriptcontroller = TextEditingController();
  File? image;
  final databaseref = FirebaseDatabase.instance.ref().child("user");
  FirebaseAuth auth = FirebaseAuth.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  bool loding = false;
  final picker = ImagePicker();

  Future getImageGallery() async {
    final pickfile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    setState(() {
      if (pickfile != null) {
        image = File(pickfile.path);
      } else {
        print("No image Pick");
      }
    });
  }
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
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 1,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black87),
                              borderRadius: BorderRadius.circular(10)),
                          child: image != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                                child: Image.file(
                                    image!.absolute,
                                    fit: BoxFit.fill,
                                  ),
                              )
                              : Icon(Icons.image,size: 100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
                controller: postcontroller,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "drow Your Idea?",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
                controller: descriptcontroller,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Explain About Post. ",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: RoundButton(
                text: "update",
                IsLoding: loding,
                onTap: () async {
                  try {
                    int date = DateTime.now().microsecondsSinceEpoch;
                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance
                        .ref('/poast$date');
                    setState(() {
                      loding = true;
                    });
                    UploadTask upldoTask = ref.putFile(image!.absolute);
                    await Future.value(upldoTask);
                    var newUrl = await ref.getDownloadURL();
                    final User? user = auth.currentUser;
                    databaseref.child('user List').child(date.toString()).set({
                      'Puuid':"",
                      'Pid': date.toString(),
                      'Pimage': newUrl.toString(),
                      'Ptime': date.toString(),
                      'PTitle': postcontroller.text.toString(),
                      'Pdisc':descriptcontroller.text.toString(),
                      'Puid': user!.uid.toString(),
                    }).then((value) {
                      Utilis().toastMessage('Post Published');
                      setState(() {
                        loding = false;
                      });
                    }).onError((error, stackTrace) {
                      Utilis().toastMessage(error.toString());
                      setState(() {
                        loding = false;
                      });
                    });
                  } catch (e) {
                    Utilis().toastMessage(e.toString());
                    setState(() {
                      loding = false;
                    });
                  }
                  Navigator.pop(context);
                },
              ),
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
