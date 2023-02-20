import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global-variables.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: GlobalVariables.myBlueColor,
    content: Text(text),
  ));
}
