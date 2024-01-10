import 'package:examples/animated_search_box.dart';
import 'package:examples/circular_display.dart';
import 'package:examples/completer.dart';
import 'package:examples/curved_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CurvedBottomNavBar(),
    );
  }
}
