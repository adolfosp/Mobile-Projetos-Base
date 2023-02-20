import 'package:flutter/material.dart';
import 'package:flutter_mongodb/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? userMail;
  void checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userMail = prefs.getString('usermail');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}