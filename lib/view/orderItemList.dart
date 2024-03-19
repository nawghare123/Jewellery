import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:jewellery/view/orderModel.dart';
import 'package:jewellery/view/orderModelList.dart';
import 'package:jewellery/view/pdfView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'package:url_launcher/url_launcher.dart';

import 'dart:io' as io;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/Mycart.dart';
import 'package:jewellery/view/countjewellery.dart';
import 'package:jewellery/view/getCartModel.dart';

class OrderItemList extends StatefulWidget {
  String orderId;
  String address;
  String invoice;
  String date;
  OrderItemList(
      {super.key,
      required this.orderId,
      required this.address,
      required this.invoice,
      required this.date});

  @override
  State<OrderItemList> createState() => _OrderItemListState();
}

class _OrderItemListState extends State<OrderItemList> {
  OrderModelList? orderModel;
  bool isloading = false;
  DateTime now = DateTime.now();
  @override
  void initState() {
    getOrderList();
//  categorylist();
    getUserData();
    setState(() {
      isloading = true;
    });

    // _videoController = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    //   // closedCaptionFile: _loadCaptions(),
    //   videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    // );

    // _videoController.addListener(() {
    //   setState(() {});
    // });
    // _videoController.setLooping(true);
    // _videoController.initialize();
    super.initState();
  }

  String? userId;
  String? state;
  String? city;
  String? pincode;

  String? fname;
  String? lname;
  String? email;
  String? number;

  Future<void> getUserData() async {
    setState(() {
      isloading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = await prefs.getInt('id').toString();
    await prefs.getInt('is_phone_verified');
    fname = await prefs.getString('first_name') ?? "Guest";
    lname = await prefs.getString('last_name') ?? "Guest";
    email = await prefs.getString('email') ?? "Guest";
    // profileImage = await prefs.getString('image') ?? "Guest";
    number = await prefs.getString('phone') ?? "123456789";
    state = await prefs.getString('state');
    city = await prefs.getString('city');
    pincode = await prefs.getString('pincode') ?? "Guest";
    print("userid $userId, state $state, city $city, pincode $pincode");

    setState(() {
      isloading = false;
    });
  }

  Future<void> getOrderList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    orderModel = await ApiHelper.getOrderList(widget.orderId);
    orderModel!.data!.forEach((e) => print(e));

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: gradient1,
        body: ListView(
          primary: true,
          children: [
            Container(
              height: 70,
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
                                Navigator.pop(context);
                              },
                              child: 
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(left: 13.0, top: 5),
                              //   child: Image.asset(
                              //     "assets/image/menu2.png",
                              //     color: white,
                              //     height: 25,
                              //   ),
                              // )
                               Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,
                              )

                              ),
                          // Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,),

                          Text(
                            'Check Invoice',
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20.0,
                                fontFamily: "Alhadara-DEMO"),
                          ),

                          //Image.asset("assets/image/notification.png",color: white,),

                          Row(
                            children: [
                              // SvgPicture.asset("assets/image/notification.svg",
                              //     color: white),

                              // SizedBox(width: 15),

                              //  Image.asset("assets/image/cart.png"),

                              // InkWell(
                              //     onTap: () {
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => MyCart()));
                              //     },
                              //     child: SvgPicture.asset(
                              //         "assets/image/Buy.svg",
                              //         color: white)),

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
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/product_bg_image.png'),
                    fit: BoxFit.cover, // Adjust the fit as per your requirement
                  ),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: orderModel == null
                      ? SizedBox()
                      : ListView(
                          primary: false,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white.withOpacity(0.38)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/image/logo.png",
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.2,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Order Id: ",
                                          style: TextStyle(
                                              // color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),
                                        Text(
                                          widget.orderId,
                                          style: TextStyle(
                                              // color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Invoice Id: ",
                                          style: TextStyle(
                                              // color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),
                                        Text(
                                          widget.invoice,
                                          style: TextStyle(
                                              // color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),
                                      ],
                                    ),
                                     Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Date: ",
                                          style: TextStyle(
                                              // color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),
                                        Text(DateFormat("dd MMM yyyy").format( DateTime.parse((  widget.date.toString()))),
style: TextStyle( fontWeight: FontWeight.w400, fontSize: 18.0, fontFamily: "Alhadara-DEMO"),
                                        ),
                                      ],
                                    ),
                                   
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      child: Image.asset(
                                          "assets/image/divider.png"),
                                    ),
                                    ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: orderModel!.data!
                                          .map((e) => Container(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Product Name",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                            e.productName!
                                                                        .length <
                                                                    26
                                                                ? e.productName!
                                                                : "${e.productName!.substring(0, 25)}...",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))
                                                      ],
                                                    ),
                                                    Divider(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Variant",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                            "${e.variation.toString().replaceAll('"', "")}",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))
                                                      ],
                                                    ),
                                                     Divider(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Design No.",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                            "${e.design.toString().replaceAll('"', "")}",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))
                                                      ],
                                                    ),
                                                    
                                                    
                                                    Divider(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Quantity",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                            "${e.quantity.toString()} Pcs ",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15.0),
                                                      child: Image.asset(
                                                          "assets/image/divider.png"),
                                                    ),
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Name: ",
                                          style: TextStyle(
                                              // color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),
                                        Text(
                                          "$fname $lname",
                                          style: TextStyle(
                                              // color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Email: ",
                                          style: TextStyle(
                                              // color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),
                                        Text(
                                          "$email",
                                          style: TextStyle(
                                              // color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Phone: ",
                                          style: TextStyle(
                                              // color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),
                                        Text(
                                          "$number",
                                          style: TextStyle(
                                              // color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Address: ",
                                          style: TextStyle(
                                              // color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),
                                        Text(
                                          widget.address,
                                          style: TextStyle(
                                              // color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => generateAndOpenPDF(context),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          // width: MediaQuery.of(context).size.width * 01,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                                            'View',
                                            style: TextStyle(
                                                color: white,
                                                fontSize: 16,
                                                fontFamily: "SF-Pro-Display",
                                                fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () => generateAndSharePDF(context),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Container(
                                  //       height:
                                  //           MediaQuery.of(context).size.height *
                                  //               0.07,
                                  //       // width: MediaQuery.of(context).size.width * 01,
                                  //       decoration: BoxDecoration(
                                  //           borderRadius:
                                  //               BorderRadius.circular(30),
                                  //           gradient: LinearGradient(
                                  //             begin: Alignment.centerLeft,
                                  //             end: Alignment.centerRight,
                                  //             colors: [
                                  //               gradient2,
                                  //               gradient1,
                                  //             ],
                                  //           )),
                                  //       child: Center(
                                  //           child: Text(
                                  //         '    Share   ',
                                  //         style: TextStyle(
                                  //             color: white,
                                  //             fontSize: 16,
                                  //             fontFamily: "SF-Pro-Display",
                                  //             fontWeight: FontWeight.w500),
                                  //       )),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ));
  }

  void generateAndSharePDF(BuildContext context) async {
    final pdf = pw.Document();
    // final image = await imageFromAssetBundle('assets/image.png');
    final dividerImageData = (await rootBundle.load("assets/image/divider.png"))
        .buffer
        .asUint8List();
    final dividerImage = pw.MemoryImage(
      dividerImageData,
    );
    final logoImageData =
        (await rootBundle.load("assets/image/logo.png")).buffer.asUint8List();
    final logoImage = pw.MemoryImage(
      logoImageData,
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Container(
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(25),
            // color: Colors.white.withOpacity(0.38),
          ),
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(15.0),
            child: pw.Column(
              children: [
                pw.Image(
                  logoImage,
                  height: 50,
                ),
                pw.SizedBox(
                  height: 30,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "Order Id: ",
                      style: pw.TextStyle(
                        // fontWeight: pw.FontWeight.w400,
                        fontSize: 20.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                    pw.Text(
                      widget.orderId,
                      style: pw.TextStyle(
                        // fontWeight: pw.FontWeight.w400,
                        fontSize: 20.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "Invoice Id: ",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                    pw.Text(
                      widget.invoice,
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                  ],
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 15.0),
                  child: pw.Image(dividerImage),
                ),
                pw.ListView(
                  // physics: NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  children: orderModel!.data!
                      .map((e) => pw.Container(
                            child: pw.Column(
                              children: [
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Product Name",
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        // fontWeight: pw.FontWeight.w400,
                                      ),
                                    ),
                                    pw.Text(
                                        e.productName!.length < 36
                                            ? e.productName!
                                            : "${e.productName!.substring(0, 35)}...",
                                        style: pw.TextStyle(
                                          fontSize: 14,
                                          // fontWeight: pw.FontWeight.w500,
                                        ))
                                  ],
                                ),
                                pw.Divider(),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Variant",
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        // fontWeight: pw.FontWeight.w400,
                                      ),
                                    ),
                                    pw.Text(
                                        "${e.variation.toString().replaceAll('"', "")}",
                                        style: pw.TextStyle(
                                          fontSize: 14,
                                          // fontWeight: pw.FontWeight.w500,
                                        ))
                                  ],
                                ),
                                pw.Divider(),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Quantity",
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        // fontWeight: pw.FontWeight.w400,
                                      ),
                                    ),
                                    pw.Text("${e.quantity.toString()} Pcs ",
                                        style: pw.TextStyle(
                                          fontSize: 14,
                                          // fontWeight: pw.FontWeight.w500,
                                        ))
                                  ],
                                ),
                                pw.Padding(
                                  padding:
                                      pw.EdgeInsets.symmetric(vertical: 15.0),
                                  child: pw.Image(dividerImage),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Name: ",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                    pw.Text(
                      "$fname $lname",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Email: ",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                    pw.Text(
                      "$email",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Phone: ",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                    pw.Text(
                      "$number",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Address: ",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                    pw.Text(
                      widget.address,
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final pdfBytes = await pdf.save();
    final fileName = 'invoice-${widget.invoice}.pdf';

    // Save the PDF file locally
    final file = await savePDFToDeviceLocal(fileName, pdfBytes);

    // Open the PDF file using the default PDF viewer
    // openPDF(file.path);
    // print("sharing....");
    Share.shareXFiles([XFile(file.path)], text: 'Share Invoice');

    final snack = SnackBar(content: Text("Please select an app."));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void generateAndOpenPDF(BuildContext context) async {
    final pdf = pw.Document();
    // final image = await imageFromAssetBundle('assets/image.png');
    final dividerImageData = (await rootBundle.load("assets/image/divider.png"))
        .buffer
        .asUint8List();
    final dividerImage = pw.MemoryImage(
      dividerImageData,
    );
    final logoImageData =
        (await rootBundle.load("assets/image/logo.png")).buffer.asUint8List();
    final logoImage = pw.MemoryImage(
      logoImageData,
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Container(
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(25),
            // color: Colors.white.withOpacity(0.38),
          ),
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(15.0),
            child: pw.Column(
              children: [
                pw.Image(
                  logoImage,
                  height: 50,
                ),
                pw.SizedBox(
                  height: 30,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "Order Id: ",
                      style: pw.TextStyle(
                        // fontWeight: pw.FontWeight.w400,
                        fontSize: 20.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                    pw.Text(
                      widget.orderId,
                      style: pw.TextStyle(
                        // fontWeight: pw.FontWeight.w400,
                        fontSize: 20.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "Invoice Id: ",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                    pw.Text(
                      widget.invoice,
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "Date: ",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                    pw.Text(
                 DateFormat("dd MMM yyyy").format( DateTime.parse((widget.date.toString()))),
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                  ],
                ),
              
             
                 
              
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 15.0),
                  child: pw.Image(dividerImage),
                ),
                pw.ListView(
                  // physics: NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  children: orderModel!.data!
                      .map((e) => pw.Container(
                            child: pw.Column(
                              children: [
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Product Name",
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        // fontWeight: pw.FontWeight.w400,
                                      ),
                                    ),
                                    pw.Text(
                                        e.productName!.length < 36
                                            ? e.productName!
                                            : "${e.productName!.substring(0, 35)}...",
                                        style: pw.TextStyle(
                                          fontSize: 14,
                                          // fontWeight: pw.FontWeight.w500,
                                        ))
                                  ],
                                ),
                                pw.Divider(),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Variant",
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        // fontWeight: pw.FontWeight.w400,
                                      ),
                                    ),
                                    pw.Text(
                                        "${e.variation.toString().replaceAll('"', "")}",
                                        style: pw.TextStyle(
                                          fontSize: 14,
                                          // fontWeight: pw.FontWeight.w500,
                                        ))
                                  ],
                                ),
                                pw.Divider(),
                                  pw.Row(
                                                      mainAxisAlignment:
                                                          pw.MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        pw.Text(
                                                          "Design No.",
                                                          style: pw.TextStyle(
                                                              fontSize: 14,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .w400
                                                                      ),
                                                        ),
                                                        pw.Text(
                                                            "${e.design.toString().replaceAll('"', "")}",
                                                            style: pw.TextStyle(
                                                                fontSize: 14,
                                                                // fontWeight:
                                                                //     FontWeight
                                                                //         .w500
                                                                        ))
                                                      ],
                                                    ),
                                                    
                                pw.Divider(),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Quantity",
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        // fontWeight: pw.FontWeight.w400,
                                      ),
                                    ),
                                    pw.Text("${e.quantity.toString()} Pcs ",
                                        style: pw.TextStyle(
                                          fontSize: 14,
                                          // fontWeight: pw.FontWeight.w500,
                                        ))
                                  ],
                                ),
                                pw.Padding(
                                  padding:
                                      pw.EdgeInsets.symmetric(vertical: 15.0),
                                  child: pw.Image(dividerImage),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Name: ",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                    pw.Text(
                      "$fname $lname",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Email: ",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                    pw.Text(
                      "$email",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Phone: ",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                    pw.Text(
                      "$number",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Address: ",
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                    pw.Text(
                      widget.address,
                      style: pw.TextStyle(
                        // color: white,
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        // fontFamily: "Alhadara-DEMO",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final pdfBytes = await pdf.save();
    final fileName = 'invoice.pdf';

    // Save the PDF file locally
    final file = await savePDFToDevice(fileName, pdfBytes);

    // Open the PDF file using the default PDF viewer
    openPDF(file.path);

    final snack = SnackBar(content: Text("Ready To View."));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  Future<io.File> savePDFToDevice(String fileName, List<int> pdfBytes) async {
    final dir = await getApplicationDocumentsDirectory();
    // final file = io.File('/storage/emulated/0/Download/$fileName');
    final file = io.File('${dir.path}/$fileName');
    await file.writeAsBytes(pdfBytes);
    return file;
  }

  Future<io.File> savePDFToDeviceLocal(
      String fileName, List<int> pdfBytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = io.File('${dir.path}/$fileName');
    await file.writeAsBytes(pdfBytes);
    return file;
  }

  // void openPDF(String filePath) async {
  //   final fileUrl = 'file://$filePath';
  //   print("====>>>>  ${fileUrl}");
  //   if (await canLaunchUrl(Uri.parse(fileUrl))) {
  //     await launchUrl(Uri.parse(fileUrl));
  //   } else {
  //     throw 'Could not launch PDF';
  //   }
  // }

  void openPDF(String filePath) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFScreen(title: "Invoice", path: filePath),
      ),
    );
    // final result = await OpenFile.open(filePath);
    // if (result.type != ResultType.done) {
    //   // Handle error opening file
    //   print('Failed to open PDF: ${result.message}');
    // }
  }


}
