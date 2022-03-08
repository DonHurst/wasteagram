import 'package:flutter/material.dart';
import '../models/post.dart';

class Detail extends StatelessWidget {

  late final WasteagramPost post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Wasteagram")),
      body: Text("Filler")
    );
  }
}
