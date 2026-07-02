import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_fifteen/map_screen.dart';
import 'package:ostad_flutter_batch_fifteen/my_location_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyLocationScreen(),
    );
  }
}
