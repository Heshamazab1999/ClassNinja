import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/shared.dart';

class LoCation extends GetxController{
  var longitude=0.0.obs,
      latitude=0.0.obs;
  getLocation() async {
    // Location location = new Location();
    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;
    // LocationData _locationData;
    //
    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }
    //
    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'disabled';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'deniedForever';
    }
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    longitude.value=position.longitude;
    latitude.value=position.latitude;
    print(position.latitude);
    print(position.longitude);
    return position;
  }

  goToMaps(latitude,longitude) async {
    print("going to map");
    String mapLocationUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    final String encodedURl = Uri.encodeFull(mapLocationUrl);
    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      Get.snackbar("", "عفوا حدث خطا ما");
    }
  }
  getAdress(lat,long)async{
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    String street=placemarks.first.street.toString();
    String txt1 = street.substring(0, street.indexOf('P5P+7GJ')),
           txt2= txt1.substring(0, street.indexOf('6')),
           ar= txt2.substring(0, street.indexOf('،،'));
    print(ar);
    String en=" ${placemarks.first.locality} ${placemarks.first.subAdministrativeArea} "
        "${placemarks.first.administrativeArea}";
    print(en);
    return [ar,en];
  }
}