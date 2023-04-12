import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qualplaca/app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
  
  runApp(const App());
}
