import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:invoice_generator/util.dart';
import 'package:printing/printing.dart';

class My_Pdf extends StatefulWidget {
  const My_Pdf({super.key});

  @override
  State<My_Pdf> createState() => _My_PdfState();
}

class _My_PdfState extends State<My_Pdf> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MY pdf",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: PdfPreview(
        build: (PdfPageFormat format) {
          return PDF(DataModal());
        },
      ),
    );
  }

  Future<Uint8List> PDF(DataModal data) async {
    var pdf = pw.Document();
    final image = pw.MemoryImage(
      File('${data.logo_path}').readAsBytesSync(),
    );
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(10),
      build: (context) {
        return pw.Stack(children: [
          pw.Column(children: [
            pw.Container(
                height: 150,
                width: double.infinity,
                color: PdfColors.red,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.only(right: 115),
                        child: pw.Container(
                            height: 85,
                            width: 85,
                            decoration: pw.BoxDecoration(
                                color: PdfColors.white,
                                border: pw.Border.all(
                                    color: PdfColors.black, width: 3)),
                            alignment: pw.Alignment.center,
                            child: pw.Image(image, fit: pw.BoxFit.fill)),
                      ),
                      pw.Padding(
                          padding: pw.EdgeInsets.only(right: 30),
                          child: pw.Text(
                              "From To : ${data.bf_name}\nAddress : ${data.bf_add}",
                              style: pw.TextStyle(
                                  color: PdfColors.white, fontSize: 12)))
                    ])),
            pw.Padding(
                padding: pw.EdgeInsets.only(top: 8),
                child: pw.Container(
                    width: double.infinity, height: 7, color: PdfColors.black)),
            pw.Row(children: [
              pw.Padding(
                  padding: pw.EdgeInsets.only(top: 50, left: 21),
                  child: pw.Text(
                      "Bill To    : ${data.bt_name}\nAddress : ${data.bt_add}",
                      style:
                          pw.TextStyle(color: PdfColors.black, fontSize: 13))),
              pw.Padding(
                  padding: pw.EdgeInsets.only(top: 50, left: 150),
                  child: pw.Text(
                      "Invoice No :        ${data.in_num}\nFirst Date  :        ${data.f_date}\nDue Date   :        ${data.due_date}",
                      style:
                          pw.TextStyle(color: PdfColors.black, fontSize: 13))),
            ]),
            pw.Padding(
                padding: pw.EdgeInsets.only(top: 30, left: 35, right: 45),
                child: pw.Container(
                    height: 21,
                    width: double.infinity,
                    color: PdfColors.red,
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Row(children: [
                      pw.SizedBox(width: 10),
                      pw.Text("Item",
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontSize: 15,
                          )),
                      pw.SizedBox(width: 190),
                      pw.Text("Quantity",
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontSize: 15,
                          )),
                      pw.SizedBox(width: 65),
                      pw.Text("Price",
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontSize: 15,
                          )),
                      pw.SizedBox(width: 65),
                      pw.Text("Total",
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontSize: 15,
                          )),
                    ]))),
            pw.Column(
              children: data.items!
                  .asMap()
                  .entries
                  .map(
                    (e) => pw.Padding(
                        padding:
                            pw.EdgeInsets.only(top: 15, left: 35, right: 45),
                        child: pw.Row(children: [
                          pw.SizedBox(width: 10),
                          pw.Text("${data.items![e.key]}",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                              )),
                          pw.SizedBox(width: 208),
                          pw.Text("${data.prices![e.key]}",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                              )),
                          pw.SizedBox(width: 97),
                          pw.Text("Rs. ${data.quntitys![e.key]}",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                              )),
                          pw.SizedBox(width: 70),
                          pw.Text("Rs. ${data.totals![e.key]}",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                              )),
                        ])),
                  )
                  .toList(),
            ),
            pw.Padding(
                padding: pw.EdgeInsets.only(top: 21, left: 35, right: 45),
                child: pw.Container(
                    width: double.infinity, height: 1, color: PdfColors.black)),
            pw.Padding(
                padding: pw.EdgeInsets.only(top: 15, left: 335, right: 45),
                child: pw.Text("TOTAL :         Rs. ${data.total}",
                    style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold))),
            pw.Padding(
                padding: pw.EdgeInsets.only(top: 121, left: 230),
                child: pw.Container(
                    height: 40,
                    width: 115,
                    color: PdfColors.black,
                    alignment: pw.Alignment.center,
                    child: pw.Text("INVOICE",
                        style: pw.TextStyle(
                            color: PdfColors.white, fontSize: 18)))),
            pw.Padding(
                padding: pw.EdgeInsets.only(
                  top: 815,
                ),
                child: pw.Container(
                    width: double.infinity, height: 5, color: PdfColors.red)),
          ])
        ]);
      },
    ));
    return pdf.save();
  }
}
