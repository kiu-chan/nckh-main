// ignore_for_file: prefer_const_constructors, file_names, camel_case_types, unused_field
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class pageTwo extends StatefulWidget {
  const pageTwo({Key? key}) : super(key: key);

  @override
  State<pageTwo> createState() => pageTwoState();
}

class pageTwoState extends State<pageTwo> {
  final Completer<GoogleMapController> _controller = Completer();

  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;

      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            zoom: 13.5, target: LatLng(newLoc.latitude!, newLoc.longitude!)),
      ));
      setState(() {});
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
    print('supppppppp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      body: currentLocation == null
          ? Center(
              child: ElevatedButton(
              child: Text('Refresh!!'),
              onPressed: () {
                setState(() {});
              },
            ))
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: SafeArea(
                child: Container(
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(currentLocation!.latitude!,
                                currentLocation!.longitude!),
                            zoom: 13.5),
                        markers: {
                          Marker(
                              markerId: MarkerId("source"),
                              position: LatLng(currentLocation!.latitude!,
                                  currentLocation!.longitude!)),
                        },
                        onMapCreated: (mapController) {
                          _controller.complete(mapController);
                        },
                      )),
                ),
              ),
            ),
    );
  }
}
