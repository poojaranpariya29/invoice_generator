import 'dart:async';
import 'package:flutter/material.dart';

class Spalsh extends StatefulWidget {
  const Spalsh({Key? key}) : super(key: key);

  @override
  State<Spalsh> createState() => _SpalshState();
}

class _SpalshState extends State<Spalsh> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 15),
        () => Navigator.pushReplacementNamed(context, 'Home'));
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                Container(
                  height: 400,
                  width: 400,
                  child: Image.asset("assets/image/invoicelogo.png"),
                ),
                SizedBox(
                  height: 60,
                ),
                CircularProgressIndicator(
                  color: Color(0xff4EA09E),
                ),
                SizedBox(
                  height: 115,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    "From",
                    style: TextStyle(color: Colors.black26, fontSize: 13),
                  ),
                ),
                Text(
                  "pooja",
                  style: TextStyle(
                      color: Colors.red.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
