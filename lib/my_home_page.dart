import 'dart:io';
import 'dart:typed_data';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_image_api/profile/user_profile.dart';

import 'CRUD/add_firestore_post.dart';
import 'helper/bottom.dart';

class MyImage extends StatefulWidget {
  const MyImage({super.key});

  @override
  State<MyImage> createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  final databaseref = FirebaseDatabase.instance.ref().child('user');
  final auth = FirebaseAuth.instance;

  // final searchfilter = TextEditingController();
  final editcontroller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home Page"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: databaseref.child('user List'),
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(12)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'asserts/image/images/avatar.png',
                            image: "${snapshot.value['Pimage']}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.value['PTitle'].toString(),
                          style: TextStyle(),
                        ),
                        IconButton(
                          onPressed: () {
                            PostService.deletePost('Pid', 'Puid');
                          },
                          icon: AvatarGlow(
                            endRadius: 10,
                            child: Icon(CupertinoIcons.delete),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      snapshot.value['Pdisc'].toString(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyImage(),
                        ));
                  },
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () async {
                    final res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFireStorePosts(),
                        ));

                    print('res -> $res');

                    setState(() {});
                  },
                  icon: Icon(Icons.add, size: 30)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfile(),
                        ));
                  },
                  icon: Icon(Icons.person, size: 30)),
            ],
          ),
        ),
      ),
    );
  }
} //data.bottom(context),

/*
Container(
        height: 60,
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  )),
              IconButton(

                  icon: Icon(Icons.add, size: 30)),
              IconButton(

                  icon: Icon(Icons.person, size: 30)),
            ],
          ),
        ),
      ),
// Future<void> showMyDialog(String title, String id) async {
//   editcontroller.text = title;
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Update"),
//         content: Container(
//           child: TextFormField(
//             controller: editcontroller,
//             decoration: InputDecoration(hintText: "Edit Message"),
//           ),
//         ),
//         actions: [
//           TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text("Cancle")),
//           TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 dbRef.child(id).update({
//                   "title": editcontroller.text.toLowerCase()
//                 }).then((value) {
//                   Utilis().toastMessage('Post Update');
//                 }).onError((error, stackTrace) {
//                   Utilis().toastMessage(error.toString());
//                 });
//               },
//               child: Text("Update"))
//         ],
//       );
//     },
//   );
// }
 Container(
                        height:300,
                        width: 300,
                        child: FutureBuilder<String>(
                          future: fetchImage('image1696009905686860'), // Replace with your image path
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Loading indicator
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData) {
                              return Text('No image data found.');
                            } else {
                              return Image.network(snapshot.data.toString()); // Display the image
                            }
                          },
                        ),
                      ),
Search Box Logic
  final searchfilter = TextEditingController();//provide in stf class.
Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchfilter,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              defaultChild: Text("Loding"),
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('title').value.toString();
                if (searchfilter.text.isEmpty) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                  );
                } else if (title.toLowerCase().contains(searchfilter.text.toLowerCase().toLowerCase())) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
Realtime Database Firebase Using Stream.
//Get Data From Fire Base Step:1
          Expanded(
              child: StreamBuilder(
            stream: ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }else{
                Map<dynamic,dynamic>map=snapshot.data!.snapshot.value as dynamic;
                List<dynamic>list=[];
                list.clear();
                list=map.values.toList();
                return ListView.builder(
                  itemCount: snapshot.data?.snapshot.children.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(list[index]['title']),
                      subtitle: Text(list[index]['id']),
                    );
                  },
                );
              }

            },
          )),*/
