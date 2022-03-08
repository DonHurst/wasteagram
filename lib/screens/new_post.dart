// This screen displays a photo of the item, a field for # of items wasted,
// and a large upload button for saving the post
// Tapping back in app bar causes list-screen to appear
// Tapping the upload button causes list screen to appear with the latest post
// If # of items is empty, tapping upload causes an error to appear.
// Post needs to also save the date, imageURL, quantity, latitude, and longitude
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class NewPost extends StatefulWidget {
  String url;

  NewPost({Key? key, required this.url}) : super(key:key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  LocationData? locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
    setState(() {});
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (locationData == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
          appBar: AppBar(centerTitle: true, title: Text("Wasteagram")),
          body: Column(children: [
            Text("Latitude: ${locationData!.latitude}"),
            Text("Longitude: ${locationData!.longitude}"),
          ]));
    }
  }
}
