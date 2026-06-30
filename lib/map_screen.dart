import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
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
        markers: <Marker>{
          Marker(
            markerId: MarkerId('home'),
            position: LatLng(23.801535407212405, 90.37467677146196),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            onTap: () {
              print('On tapped marker home');
            },
            infoWindow: InfoWindow(
              title: 'Home',
              onTap: () {
                print('On tapped home info window');
              },
            ),
            consumeTapEvents: false,
          ),
          Marker(
            markerId: MarkerId('office'),
            position: LatLng(23.799782565844605, 90.3718101605773),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            onTap: () {
              print('On tapped marker office');
            },
            infoWindow: InfoWindow(
              title: 'Office',
              onTap: () {
                print('On tapped office info window');
              },
            ),
            consumeTapEvents: false,
          ),
        },
        polylines: <Polyline>{
          Polyline(
            polylineId: PolylineId('home-to-office'),
            points: [
              LatLng(23.801535407212405, 90.37467677146196),
              LatLng(23.799782565844605, 90.3718101605773),
              LatLng(23.80356001078558, 90.37091664969921),
            ],
            onTap: () {
              print('On tapped home-to-office polyline');
            },
            color: Colors.purple,
            width: 6,
            endCap: .roundCap,
            startCap: .buttCap,
            visible: true,
            jointType: .bevel,
          ),
        },
        circles: <Circle>{
          Circle(
            circleId: CircleId('danger-zone'),
            center: LatLng(23.807164340557335, 90.36863040179014),
            radius: 300,
            strokeWidth: 5,
            strokeColor: Colors.red,
            fillColor: Colors.red.withAlpha(40),
            onTap: () {
              print('On tapped red-zone');
            },
            consumeTapEvents: true,
            visible: true,
          ),
        },
        polygons: <Polygon>{
          Polygon(
            polygonId: PolygonId('random-polygon'),
            points: [
              LatLng(23.798394755168214, 90.36067362874746),
              LatLng(23.791009721058643, 90.35668585449457),
              LatLng(23.7873460386566, 90.36339037120342),
              LatLng(23.788334831981643, 90.36934822797775),
              LatLng(23.796868269009767, 90.36869678646326),
              LatLng(23.798845396467293, 90.36253239959478),
            ],
            fillColor: Colors.purple.withAlpha(40),
            strokeColor: Colors.purple,
            strokeWidth: 6,
            onTap: () {
              print('On tapped random polygon');
            },
            consumeTapEvents: true,
          ),
        },
      ),
      floatingActionButtonLocation: .centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _moveToHome,
        child: Icon(Icons.home),
      ),
    );
  }

  void _moveToHome() {
    // _mapController.moveCamera(
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //         target: LatLng(23.801535407212405, 90.37467677146196),
    //       zoom: 16
    //     ),
    //   ),
    // );
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(23.801535407212405, 90.37467677146196),
          zoom: 16
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
