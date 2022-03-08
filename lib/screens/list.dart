import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:wasteagram/screens/camera_screen.dart';
import 'package:wasteagram/screens/new_post.dart';
import '../models/post.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class List extends StatefulWidget {
  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  File? image; 
  final picker = ImagePicker();
  // late final WasteagramPost post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Wasteagram")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
                snapshot.data!.docs != null &&
                snapshot.data!.docs.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];
                    return ListTile(
                        title: Text(post['imageURL']),
                        trailing: Text(post['quantity']));
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String url = await getImage();
          Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => NewPost(url: url)));
        },
        child: Icon(Icons.camera_enhance),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);

    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }
}
