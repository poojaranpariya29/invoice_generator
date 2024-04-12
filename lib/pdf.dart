import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:invoice_generator/util.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PdfData {
  PdfPreview getPdfPreview() {
    return PdfPreview(build: (format) {
      return getPdf();
    });
  }

  Future<Uint8List> getPdf() async {
    var document = Document();
    final img = await rootBundle.load("images/INVOICE.png");
    final imageBytes = img.buffer.asUint8List();
    int amount = 0;
    int gsttotal = 0;
    int cesstotal = 0;
    for (int i = 0; i < invoice.price.length; i++) {
      amount += (int.tryParse(invoice.price[i]) ?? 0) *
          (int.tryParse(invoice.quantity[i]) ?? 0);
    }
    for (int i = 0; i < invoice.gst.length; i++) {
      gsttotal += int.tryParse(invoice.gst[i]) ?? 0;
    }

    int totals = amount + gsttotal + cesstotal;

    document.addPage(Page(build: (context) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Bill To",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "invoice Number  ",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ])))
        ]),
        SizedBox(height: 25),
        Text("${invoice.name}", style: TextStyle(fontSize: 19)),
        SizedBox(height: 5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("${invoice.address}", style: TextStyle(fontSize: 19)),
        ]),
        SizedBox(height: 5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Due Date  ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextSpan(
                text: "${invoice.dueDate}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
          ]))
        ]),
        SizedBox(height: 5),
        Container(
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: PdfColor.fromInt(0xff666666)),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(width: 10),
              Text("Item Name",
                  style: TextStyle(color: PdfColors.white, fontSize: 15)),
              SizedBox(width: 50),
              Text("Quantity",
                  style: TextStyle(color: PdfColors.white, fontSize: 15)),
              SizedBox(width: 25),
              Text("Rate",
                  style: TextStyle(color: PdfColors.white, fontSize: 15)),
              SizedBox(width: 25),
              Text("CGST",
                  style: TextStyle(color: PdfColors.white, fontSize: 15)),
              SizedBox(width: 25),
              Text("price",
                  style: TextStyle(color: PdfColors.white, fontSize: 15)),
              SizedBox(width: 25),
              Text("Amount",
                  style: TextStyle(color: PdfColors.white, fontSize: 15)),
            ])),
        SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(width: 10),
          Column(children: [
            for (int i = 0; i < invoice.items.length; i++)
              Text("${invoice.items[i]}", style: TextStyle(fontSize: 18)),
          ]),
          SizedBox(width: 90),
          Column(children: [
            for (int i = 0; i < invoice.quantity.length; i++)
              Text("${invoice.quantity[i]}", style: TextStyle(fontSize: 18)),
          ]),
          SizedBox(width: 50),
          Column(children: [
            for (int i = 0; i < invoice.price.length; i++)
              Text("${invoice.price[i]}", style: TextStyle(fontSize: 18)),
          ]),
          SizedBox(width: 25),
          Column(children: [
            for (int i = 0; i < invoice.price.length; i++)
              Text("5.00", style: TextStyle(fontSize: 20)),
          ]),
          SizedBox(width: 20),
          Column(children: [
            for (int i = 0; i < invoice.price.length; i++)
              Text("20.00", style: TextStyle(fontSize: 20)),
          ]),
          SizedBox(width: 40),
          Column(
            children: [
              for (int i = 0; i < invoice.price.length; i++)
                Text(
                    "${(int.tryParse(invoice.price[i]) ?? 0) * (int.tryParse(invoice.quantity[i]) ?? 0)}",
                    style: TextStyle(fontSize: 20)),
            ],
          ),
        ]),
        Padding(
            padding: EdgeInsets.only(left: 280, top: 20),
            child: Column(children: [
              Row(children: [
                SizedBox(width: 45),
                Text("CGST ", style: TextStyle(fontSize: 20)),
                SizedBox(width: 30),
                Column(
                  children: [
                    Text(
                      "${gsttotal}.00",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ]),
              SizedBox(height: 20),
              Padding(
                  padding: EdgeInsets.only(left: 45),
                  child: Row(children: [
                    Text("Total", style: TextStyle(fontSize: 20)),
                    SizedBox(width: 50),
                    Text("${totals}.00",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ]))
            ]))
      ]);
    }));

    return document.save();
  }
}
