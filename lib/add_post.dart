import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_image_api/helper/round_btn.dart';
import 'package:my_image_api/helper/text_form%20field.dart';
import 'package:my_image_api/helper/utilis.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

final postcontroller = TextEditingController();
bool loding = false;

final databaseRef = FirebaseDatabase.instance.ref('Post');

class _AddPostsState extends State<AddPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: postcontroller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "drow Your Idea?",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RoundButton(
            text: "Add",
            IsLoding: loding,
            onTap: () {
              setState(() {
                loding = true;
              });
              String id = DateTime.now().millisecondsSinceEpoch.toString();
              databaseRef.child(id).set({
                'id': id,
                'title': postcontroller.text.toString(),
              }).then((value) {
                Utilis().toastMessage('Post Added');
                setState(() {
                  return Navigator.pop(context);
                });
                setState(() {
                  loding = false;
                });
              }).onError((error, stackTrace) {
                Utilis().toastMessage(error.toString());
                setState(() {
                  loding = false;
                });
              });
              //return Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
