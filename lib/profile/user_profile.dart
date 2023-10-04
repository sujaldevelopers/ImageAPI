import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_image_api/Log_In/ap_login_page.dart';
import 'package:my_image_api/helper/utilis.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? image;
  final auth = FirebaseAuth.instance;
  final picker = ImagePicker();

  Future getImageGallery() async {
    final pickfile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    setState(() {
      if (pickfile != null) {
        image = File(pickfile.path);
      } else {
        print("No image Pick"); //U+2389
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                getImageGallery();
              },
              icon: Icon(Icons.add)),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: MediaQuery.of(context).size.height * 0.120,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.file(
                        image!.absolute,
                        fit: BoxFit.fill,
                      ),
                    )
                  : Icon(Icons.image, size: 50),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text("ABC ID", style: TextStyle(fontSize: 30)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Divider(
              height: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                child: Row(
                  children: [
                    Text.rich(TextSpan(
                        text: '\u2389.', style: TextStyle(fontSize: 25))),
                    Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                alignment: Alignment.topLeft),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
                child: Row(
                  children: [
                    //
                    Text.rich(TextSpan(
                        text: '\u2389.', style: TextStyle(fontSize: 25))),
                    TextButton(
                        onPressed: () {
                          auth.signOut().then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          }).onError((error, stackTrace) {
                            Utilis().toastMessage(error.toString());
                          });
                        },
                        child: Text("Log Out")),

                  ],
                ),
                alignment: Alignment.topLeft),
          ),
        ],
      ),
    );
  }
}
