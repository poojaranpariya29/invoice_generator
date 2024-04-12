import 'package:flutter/material.dart';
import 'package:invoice_generator/splash_screen.dart';
import 'home_page.dart';
import 'my_pdf.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "Home": (context) => Invoice(),
        "pdf": (context) => MyPdf(),
      },
    );
  }
}

List<Map> pdflist = [];
