import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppbarCounter extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    int wastePosts;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          wastePosts = 0;
          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.length > 0) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              int currentNum = snapshot.data!.docs[i]['quantity'];
              wastePosts += currentNum;
            }
          }

          return AppBar(
              centerTitle: true, title: Text("Wasteagram - $wastePosts"));
        });
  }
}
