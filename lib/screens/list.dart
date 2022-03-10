import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/photo_fab.dart';
import '../widgets/list_stream.dart';
import '../widgets/appbar_counter.dart';

class List extends StatefulWidget {
  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCounter(),
      body: listStream(),
      floatingActionButton: photoFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
