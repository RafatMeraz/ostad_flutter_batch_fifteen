import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target: LatLng(23.799923053964953, 90.37183227502337),
        ),
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        onTap: (LatLng latLng) {
          print('On tapped $latLng');
        },
        onLongPress: (LatLng latLng) {
          print('On long pressed $latLng');
        },
        mapType: MapType.normal,
        trafficEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }
}
