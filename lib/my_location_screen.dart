import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyLocationScreen extends StatefulWidget {
  const MyLocationScreen({super.key});

  @override
  State<MyLocationScreen> createState() => _MyLocationScreenState();
}

class _MyLocationScreenState extends State<MyLocationScreen> {
  Position? _currentPosition;
  StreamSubscription? _locationSubscriber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Location')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              'My Current Location: ${_currentPosition?.latitude}, ${_currentPosition?.longitude}',
            ),
            FilledButton(
              onPressed: _getCurrentLocation,
              child: Text('Get Location'),
            ),
            FilledButton(
              onPressed: _listenCurrentLocation,
              child: Text('Listen Current Location'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    /// Check if location permission enabled
    bool isPermissionEnabled = await _isPermissionEnabled();
    if (isPermissionEnabled) {
      /// Check if location service enabled
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        /// Get current location
        Position position = await Geolocator.getCurrentPosition();
        print(position);
        if (position.isMocked) {
          print('This is a mocked location!');
        }
        _currentPosition = position;
        setState(() {});
      } else {
        /// If No, then ask to enable location service
        Geolocator.openLocationSettings();
      }
    } else {
      /// If No, then request permission
      bool isPermissionEnabled = await _requestPermission();
      if (isPermissionEnabled) {
        _getCurrentLocation();
      } else {
        // Geolocator.openAppSettings();
      }
    }
  }

  Future<void> _listenCurrentLocation() async {
    /// Check if location permission enabled
    bool isPermissionEnabled = await _isPermissionEnabled();
    if (isPermissionEnabled) {
      /// Check if location service enabled
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        /// Get realtime location
        _locationSubscriber = Geolocator.getPositionStream().listen((
          Position? newPosition,
        ) {
          _currentPosition = newPosition;
          setState(() {});
        });
      } else {
        /// If No, then ask to enable location service
        Geolocator.openLocationSettings();
      }
    } else {
      /// If No, then request permission
      bool isPermissionEnabled = await _requestPermission();
      if (isPermissionEnabled) {
        _getCurrentLocation();
      } else {
        // Geolocator.openAppSettings();
      }
    }
  }

  Future<bool> _isPermissionEnabled() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == .always || permission == .whileInUse;
  }

  Future<bool> _requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission == .always || permission == .whileInUse;
  }

  @override
  void dispose() {
    _locationSubscriber?.cancel();
    super.dispose();
  }
}
