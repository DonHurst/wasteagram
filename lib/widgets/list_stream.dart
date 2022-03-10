import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../screens/detail.dart';


class listStream extends StatefulWidget {
  @override
  ListStreamState createState() => ListStreamState();
}

class ListStreamState extends State<listStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.length > 0) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var post = snapshot.data!.docs[index];
                  DateTime postDate = post['date'].toDate();
                  return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detail(post: post)));
                      },
                      title:
                          Text('${DateFormat.yMMMMEEEEd().format(postDate)}'),
                      trailing: Text(post['quantity'].toString()));
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
