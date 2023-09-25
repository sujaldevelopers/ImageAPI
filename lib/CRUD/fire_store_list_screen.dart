import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_image_api/helper/utilis.dart';
import 'add_firestore_post.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  //final ref = FirebaseDatabase.instance.ref('Post');
  final auth = FirebaseAuth.instance;
  final editcontroller = TextEditingController();

  //Step 1: Fatch Data,Creat Refrance.
  final fireStore = FirebaseFirestore.instance.collection('user').snapshots();

  CollectionReference ref = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Fire Store"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          //Step 2: Creat StremBuilder and provide Strem Refrance.
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //Step 3:Handel Error.
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();

              if (snapshot.hasError) return Text("Some Error");

              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        ref
                            .doc(snapshot.data!.docs[index]['id'].toString())
                            .update({'title': 'subscirib'}).then((value) {
                          Utilis().toastMessage("Update");
                        }).onError((error, stackTrace) {
                          Utilis().toastMessage(error.toString());
                        });
                      }, //Step 4: Provide path
                      title:
                          Text(snapshot.data!.docs[index]['title'].toString()),
                      trailing: IconButton(
                        onPressed: () {
                          ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                        },
                        icon: Icon(Icons.delete),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddFireStorePosts(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editcontroller.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update"),
          content: Container(
            child: TextFormField(
              controller: editcontroller,
              decoration: InputDecoration(hintText: "Edit Message"),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancle")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Update"))
          ],
        );
      },
    );
  }
}
