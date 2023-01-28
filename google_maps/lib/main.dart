import 'package:flutter/material.dart';
import 'package:google_maps/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapScreen(),
    );
  }
}

