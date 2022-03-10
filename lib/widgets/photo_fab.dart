import 'package:flutter/material.dart';
import 'dart:io';
import 'package:wasteagram/screens/new_post.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class photoFAB extends StatefulWidget {
  @override
  photoFABState createState() => photoFABState();
}

class photoFABState extends State<photoFAB> {

  File? image;
  final picker = ImagePicker();

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
    return Semantics(
        button: true,
        onTapHint: "Select a photo",
        label: "Select a photo",
        child: FloatingActionButton(
          onPressed: () async {
            final url = await getImage();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewPost(url: url)));
          },
          child: Icon(Icons.camera_enhance),
        ));
  }
}
