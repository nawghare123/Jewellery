import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Mycart.dart';
import 'package:jewellery/view/uiToPdf.dart';

import 'dart:io' as io;
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SingleChildScrollView(
          child: Container(
              //   height: MediaQuery.of(context).size.height,

              child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [gradient2, gradient1])),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              //Navigator.pop(context);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 13.0, top: 5),
                              child: Image.asset(
                                "assets/image/menu2.png",
                                color: white,
                                height: 25,
                              ),
                            )
                            //  Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,
                            // )

                            ),
                        Center(
//SvgPicture.asset("assets/image/menu1.svg",height: 25,),
//
                          child: GradientText(
                            'Order Invoice',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20.0,
                                fontFamily: "Alhadara-DEMO"),
                            gradientType: GradientType.radial,
                            radius: 2.5,
                            colors: [darkgradient1, darkgradient2],
                          ),
                        ),
                        Row(
                          children: [
                            // SvgPicture.asset("assets/image/notification.svg",
                            //     color: white),

                            // SizedBox(width: 15),

                            //  Image.asset("assets/image/cart.png"),

                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyCart()));
                                },
                                child: SvgPicture.asset("assets/image/Buy.svg",
                                    color: white)),

                            SizedBox(width: 10),
                          ],
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: bgcolor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: white),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/image/logo.png",
                              height: MediaQuery.of(context).size.width * 0.2,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Product Name",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("Gold bangle",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Size",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("2.5 ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("4 Pcs ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "weight",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("10gms",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            // SizedBox(
                            //   height: 40,
                            // ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Image.asset("assets/image/divider.png"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Product Name",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("Gold bangle",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Size",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("2.5 ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("4 Pcs ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "weight",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("10gms",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Image.asset("assets/image/divider.png"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Product Name",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("Gold bangle",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Size",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("2.5 ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("4 Pcs ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "weight",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("10gms",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: 8,
          // ),
          GestureDetector(
            onTap: () async {
              //  Future<void> main() async {
              final pdf = pw.Document();

              pdf.addPage(
                pw.Page(
                  build: (pw.Context context) => pw.Center(
                    child: pw.Text('Hello World!'),
                  ),
                ),
              );

              final file = io.File('example.pdf');
              await file.writeAsBytes(await pdf.save());
// }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        // width: MediaQuery.of(context).size.width * 01,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                gradient2,
                                gradient1,
                              ],
                            )),
                        child: Center(
                            child: Text(
                          'Download',
                          style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontFamily: "SF-Pro-Display",
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: MediaQuery.of(context).size.width * 01,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              gradient2,
                              gradient1,
                            ],
                          )),
                      child: Center(
                          child: Text(
                        '    Share   ',
                        style: TextStyle(
                            color: white,
                            fontSize: 16,
                            fontFamily: "SF-Pro-Display",
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ))),
    );
  }
}

// Create a function to generate the PDF
Future<void> generatePDF() async {
  final pdf = pw.Document();

  // Create a page
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        // Add your UI widgets to the PDF page
        return pw.Center(
          child: pw.Text('Hello, PDF!'),
        );
      },
    ),
  );

  // Save the PDF to a file
  final outputFile = File('path/to/output.pdf');
  await outputFile.writeAsBytes(await pdf.save());
}

Widget card() => Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: white),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Product Name",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text("Gold bangle",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Size",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text("2.5 ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quantity",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text("4 Pcs ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "weight",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text("10gms",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                ],
              ),
            ],
          ),
        ),
      ),
    );
