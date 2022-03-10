import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/new_post_scaffold.dart';

class tempPost {
  late DateTime date;
  late String imageURL;
  late int quantity;
  late double latitude;
  late double longitude;
}

class NewPost extends StatefulWidget {
  String? url;
  NewPost({Key? key, required this.url}) : super(key: key);
  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: PostFormScaffold(url: widget.url),
    );
  }
}
