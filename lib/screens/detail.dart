import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/post.dart';
import 'package:intl/intl.dart';

class Detail extends StatelessWidget {
  DocumentSnapshot post;

  Detail({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime postDate = post['date'].toDate();
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Wasteagram")),
        body: Center( child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text('${DateFormat.yMMMMEEEEd().format(postDate)}', style: TextStyle(fontSize: 25)),
          Container(child: Semantics(
            image: true,
            label: 'Picture of wasted items',
            child: Image.network(post['imageURL'], fit: BoxFit.cover)
          )),
          Text('${post['quantity']} items', style: TextStyle(fontSize: 25)),
          Text('Location: (${post['latitude']},${post['longitude']})')
          ],
        )));
  }
}
