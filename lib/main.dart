import 'package:flutter/material.dart';
import 'package:invoice_generator/preview.dart';
import 'package:invoice_generator/splash_screen.dart';
import 'home_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Spalsh(),
      'Home': (context) => Home(),
      'Preview': (context) => Preview(),
    },
  ));
}
