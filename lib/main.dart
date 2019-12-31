import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_train/app.dart';
import 'package:flutter_train/utils/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primaryDark
  ));
  runApp(App());
}
