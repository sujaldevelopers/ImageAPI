

import 'package:firebase_database/firebase_database.dart';

class PostService {
  final databaseref = FirebaseDatabase.instance.ref().child('user');

  Future<void> createPost(String userUid, String title, String content,String description,String Url) async {
    final newPostRef = databaseref.push();
    await newPostRef.set({
      'Pid': userUid,
      'Puid': userUid,
      'title': title,
      'Pdisc': description,
      'Pimage':Url,
    });
  }

  static Future<void> deletePost(String Pid, String Puid) async {
    final databaseref = FirebaseDatabase.instance.ref().child('user');
    final postSnapshot = await databaseref.child(Pid).once();
    if (postSnapshot.snapshot.value!= null) {
      final postUid = postSnapshot.snapshot.value['Pid'];
      if (postUid == Puid) {
        await databaseref.child(Pid).remove();
      } else {
        throw Exception("You can only delete your own posts.");
      }
    }
  }
}