import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/commons/error_handler.dart';
import 'package:flutter_mongodb/commons/global-variables.dart';
import 'package:flutter_mongodb/commons/my_snackbar.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../homepage.dart';
import '../models/user.dart';

class AuthService {
  void signUp(
      {required BuildContext context,
      required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    try {
      User user = User(
          firstName: firstName,
          password: password,
          lastName: lastName,
          email: email);

      http.Response res = await http.post(Uri.parse('$url/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Login realizado com sucesso!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$url/api/signup'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('usermail', jsonDecode(res.body)['email']);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
