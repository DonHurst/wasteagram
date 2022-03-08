import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? image;
  final picker = ImagePicker();

/*
* Pick an image from the gallery, upload it to Firebase Storage and return 
* the URL of the image in Firebase Storage.
*/
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.length > 0) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data!.docs[index];
                      return ListTile(
                          leading: Text(post['latitude']),
                          title: Text(post['longitude']));
                    },
                  ),
                ),
                ElevatedButton(
                  child: Text('Select photo and upload data'),
                  onPressed: () {
                    uploadData();
                  },
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Center(child: CircularProgressIndicator()),
                ElevatedButton(
                  child: Text('Select photo and upload data'),
                  onPressed: () {
                    uploadData();
                  },
                ),
              ],
            );
          }
        });
  }

  void uploadData() async {
    final url = await getImage();
    final weight = DateTime.now().millisecondsSinceEpoch % 1000;
    final title = 'Title ' + weight.toString();
    FirebaseFirestore.instance
        .collection('posts')
        .add({'weight': weight, 'title': title, 'url': url});
  }
}
