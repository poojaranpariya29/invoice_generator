import 'package:invoice_generator/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_generator/util.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  GlobalKey<FormState> fKey = GlobalKey<FormState>();

  List<TextEditingController> iteam = [TextEditingController()];
  List<TextEditingController> quantity = [TextEditingController()];
  List<TextEditingController> price = [TextEditingController()];
  List<TextEditingController> gst = [TextEditingController()];
  List<TextEditingController> total = [TextEditingController()];
  TextEditingController dueDate = TextEditingController();
  TextEditingController adderess = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController in_no = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Invoice Generator",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: fKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15, left: 15),
                child: Text(
                  "INVOICE",
                  style: TextStyle(color: Colors.black54, fontSize: 33),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 12, top: 6),
                child: TextFormField(
                  controller: in_no,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.black54),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(color: Colors.black54),
                      ),
                      prefixIcon: const Icon(
                        Icons.edit_outlined,
                        color: Colors.black54,
                      ),
                      hintText: "Invoice Number",
                      labelStyle:
                          const TextStyle(fontSize: 12, color: Colors.black54)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Invoice Number";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, left: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Bill Form*",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 12, top: 12),
                child: TextFormField(
                  controller: name,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.black54),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(color: Colors.black54),
                      ),
                      hintText: "Who is this invoice form? (required)",
                      labelStyle:
                          const TextStyle(fontSize: 12, color: Colors.black54)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Invoice Form";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 12, top: 15),
                child: TextField(
                  controller: adderess,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  maxLines: 2,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                    hintText: "Address",
                    labelStyle:
                        const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, left: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Due Date",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 5),
                child: TextFormField(
                  controller: dueDate,
                  style: const TextStyle(color: Color(0xFF555259)),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 20),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF555259)),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF555259)),
                        borderRadius: BorderRadius.circular(9)),
                    prefixIcon: const Icon(
                      Icons.calendar_month,
                      color: Colors.black54,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Due Date";
                    } else {
                      return null;
                    }
                  },
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.fromSwatch(
                              primarySwatch: Colors.blueGrey,
                              backgroundColor: Colors.lightBlue,
                              cardColor: Colors.white,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(
                        () {
                          dueDate.text = formattedDate;
                        },
                      );
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 15, left: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Items*",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xffF8F9FE)),
                      minimumSize: MaterialStatePropertyAll(Size(0, 60))),
                  onPressed: () {
                    showModalBottomSheet(
                        scrollControlDisabledMaxHeightRatio: double.infinity,
                        context: context,
                        builder: (BuildContext mContext) {
                          return Container(
                            width: double.infinity,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            for (var element in iteam) {
                                              element.clear();
                                            }
                                            for (var element in price) {
                                              element.clear();
                                            }
                                            for (var element in quantity) {
                                              element.clear();
                                            }
                                            for (var element in gst) {
                                              element.clear();
                                            }
                                            for (var element in total) {
                                              element.clear();
                                            }
                                          },
                                          child: Text(
                                            "Clear",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          "Item Details",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(Icons.close)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Item Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff1F2948),
                                          fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      children: iteam.map((e) {
                                        return TextFormField(
                                          controller: e,
                                          maxLines: 2,
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                              hintText: "What are you selling",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15))),
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Please Enter your Item Name";
                                            } else {
                                              return null;
                                            }
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Price",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff1F2948),
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 140,
                                        ),
                                        Text(
                                          "Quantity",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff1F2948),
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: price.map((e) {
                                              return TextFormField(
                                                controller: e,
                                                decoration: InputDecoration(
                                                  hintText: "INR 0.00",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: quantity.map((e) {
                                              return TextFormField(
                                                controller: e,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          "GST",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff1F2948),
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: gst.map((e) {
                                              return TextFormField(
                                                controller: e,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        for (var element in iteam) {
                                          invoice.items.add(element.text);
                                        }
                                        for (var element in price) {
                                          invoice.price.add(element.text);
                                        }
                                        for (var element in quantity) {
                                          invoice.quantity.add(element.text);
                                        }
                                        for (var element in gst) {
                                          invoice.gst.add(element.text);
                                        }
                                        for (var element in total) {
                                          invoice.total_price.add(element.text);
                                        }
                                      },
                                      child: Container(
                                          height: 50,
                                          width: 300,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Color(0xff1871FF)),
                                          child: Center(
                                            child: Text(
                                              "Done",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ]),
                          );
                        });
                  },
                  child: Row(children: [
                    Icon(
                      Icons.add_circle_rounded,
                      color: Colors.blue,
                    ),
                    Text(
                      "  Add Item Details",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1F2948)),
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Save Successfully"),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                      action: SnackBarAction(
                        label: "Send",
                        onPressed: () {},
                      ),
                    ));
                    bool isValid = fKey.currentState?.validate() ?? false;

                    if (isValid) {
                      invoice.in_no = in_no.text;
                      invoice.dueDate = dueDate.text;
                      fKey.currentState?.save();
                      FocusScope.of(context).unfocus();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Saved")),
                      );
                    }
                    Navigator.pushNamed(context, "pdf", arguments: Myinvoice());
                  },
                  child: Container(
                    height: 60,
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xff1871FF)),
                    child: Center(
                        child: Text(
                      "save",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
