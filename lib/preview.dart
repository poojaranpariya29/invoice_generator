import 'dart:io';

import 'package:flutter/material.dart';
import 'package:invoice_generator/util.dart';

class Preview extends StatefulWidget {
  const Preview({Key? key}) : super(key: key);

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    DataModal data = ModalRoute.of(context)!.settings.arguments as DataModal;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              "Invoice",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Color(0xff4EA09E)),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  color: Color(0xff4EA09E),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 21),
                        child: data.logo_path == null
                            ? Container()
                            : Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black, width: 4)),
                                child: Image.file(File("${data.logo_path}")),
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 115),
                        child: Text(
                          "From To : ${data.bf_name}\nAddress : ${data.bf_add}",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 9,
                  width: double.infinity,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Bill To : ${data.bt_name}\nAddress : ${data.bt_add}",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 60, top: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Invoice No   : ${data.in_num}\nFirst Date     : ${data.f_date}\nDue Data      : ${data.due_date}",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Container(
                    height: 20,
                    width: double.infinity,
                    color: Colors.black,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                          ),
                          child: Text(
                            "Items",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 90,
                          ),
                          child: Text(
                            "Quantity",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                          ),
                          child: Text(
                            "Price",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 50,
                          ),
                          child: Text(
                            "Total",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: data.items!
                      .asMap()
                      .entries
                      .map(
                        (e) => Padding(
                          padding:
                              EdgeInsets.only(left: 21, right: 21, top: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 6,
                                ),
                                child: Text(
                                  "${data.items![e.key]}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 120,
                                ),
                                child: Text(
                                  "${data.quntitys![e.key]}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 30,
                                ),
                                child: Text(
                                  "Rs. ${data.prices![e.key]}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 30,
                                ),
                                child: Text(
                                  "Rs. ${data.totals![e.key]}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.black,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 12, left: 180),
                    child: Text(
                      "TOTAL : Rs. ${data.total}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                height: 9,
                width: double.infinity,
                color: Color(0xff4EA09E),
              ),
            )
          ],
        ),
      ),
    );
  }
}
