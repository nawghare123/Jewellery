import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/Mycart.dart';
import 'package:jewellery/view/home/catalogueModel.dart';
import 'package:jewellery/view/pdfView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class Catalogue extends StatefulWidget {
  Catalogue({super.key, required this.type});
  String type;

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  CatalogueModel? catalogueModel;

  CatalogueModel? catalogueModelOriginal;
  bool isloading = false;
  bool isloadingPdf = false;

  String remotePDFpath = "";

  // String filter = "";
  @override
  void initState() {
    setState(() {
      isloading = true;
    });
    getCatelogList(widget.type);

    super.initState();
  }

  Future<File> createFileOfPdfUrl(String pdfurl) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = pdfurl;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  Future<void> updateFilter(String value) async {
    if (value == "All") {
      catalogueModelOriginal = await ApiHelper.getCatList();
      catalogueModel = catalogueModelOriginal;
      setState(() {});
      return;
    }
    // var foo = catalogueModelOriginal!.data;
    catalogueModelOriginal = await ApiHelper.getCatList();
    catalogueModel!.data = catalogueModelOriginal!.data!
        .where((element) => element.categoery == value)
        .toList();
    setState(() {});
  }

  Future<void> getCatelogList(String type) async {
    catalogueModelOriginal = await ApiHelper.getCatList();
    catalogueModel = catalogueModelOriginal;
    // catalogueModel!.data!.forEach(
    //   (element) {
    //     print("=======>>>>>> ${element.title}");
    //   },
    // );

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: gradient1,
      body:   isloading
          ? Center(child: CircularProgressIndicator())
     : 
    Container(
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: bgcolor,
            image: DecorationImage(
              image: AssetImage('assets/image/backgroundimg.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView(
            primary: true,
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [gradient2, gradient1])),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, bottom: 0),
                                child: Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: white,
                                  size: 18,
                                ),
                              ),
                            ),
                            Spacer(),
                            // Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,),

                            Text(
                              'Catalogue',
                              style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.0,
                                  fontFamily: "Alhadara-DEMO"),
                            ),

                            Spacer(),

                            //Image.asset("assets/image/notification.png",color: white,),

                            // Row(
                            //   children: [
                            //     SvgPicture.asset(
                            //         "assets/image/notification.svg",
                            //         color: white),

                            //     SizedBox(width: 15),

                            //     //  Image.asset("assets/image/cart.png"),

                            //     InkWell(
                            //         onTap: () {
                            //           Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                   builder: (context) => MyCart()));
                            //         },
                            //         child: SvgPicture.asset(
                            //             "assets/image/Buy.svg",
                            //             color: white)),

                            //     SizedBox(width: 10),
                            //   ],
                            // ),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
// height: MediaQuery.of(context).size.height*0.8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: bgcolor,
                      image: DecorationImage(
                        image: AssetImage('assets/image/backgroundimg.jpg'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(30))),
                  child: Padding(
                    // padding: const EdgeInsets.all(13.0),
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //     height: MediaQuery.of(context).size.height * 0.02),

                        // Text(
                        //   "Catalogue",
                        //   style: TextStyle(
                        //       fontSize: 16,
                        //       fontFamily: "SF-Pro-Display",
                        //       fontWeight: FontWeight.w600),
                        // ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  // String filter = e.categoery!;
                                  // setState(() {});
                                  // print(filter);
                                  await updateFilter("All");
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    // height:
                                    //     MediaQuery.of(context).size.width * 0.55,
                                    // width:
                                    //     MediaQuery.of(context).size.width * 0.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      // color: white,
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [gradient2, gradient1],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        "All",
                                        style: TextStyle(
                                          color: white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: catalogueModelOriginal!.data!
                                    .where((element) =>
                                        element.type == widget.type)
                                    .toList()
                                    .map(
                                      (e) =>
                                      
                                       InkWell(
                                        onTap: () async {
                                          // String filter = e.categoery!;
                                          // setState(() {});
                                          // print(filter);
                                          updateFilter(e.categoery!);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            // height:
                                            //     MediaQuery.of(context).size.width * 0.55,
                                            // width:
                                            //     MediaQuery.of(context).size.width * 0.6,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              // color: white,
                                              gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [gradient2, gradient1],
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                e.categoery!,
                                                style: TextStyle(
                                                  color: white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),

                        // SizedBox(
                        //     height: MediaQuery.of(context).size.height * 0.03),
                        (catalogueModel == null && isloading)
                            ? Center(child: CircularProgressIndicator())
                            : isloadingPdf
                                ? Center(child: CircularProgressIndicator())
                                : ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    // gridDelegate:
                                    //     SliverGridDelegateWithFixedCrossAxisCount(
                                    //         crossAxisCount: 2,
                                    //         crossAxisSpacing: 15,
                                    //         mainAxisSpacing: 15,
                                    //         mainAxisExtent: 200),
                                    children: catalogueModel!.data!
                                        .where((element) =>
                                            (element.type == widget.type))
                                        .toList()
                                        .map(
                                          (e) => InkWell(
                                            onTap: () async {
                                              setState(() {
                                                isloadingPdf = true;
                                              });
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             OpenPdf(url: e.file!)));
                                              await createFileOfPdfUrl(
                                                      "https://veejayjewels.com/storage/app/public/pdf/${e.file!}")
                                                  .then((f) {
                                                setState(() {
                                                  remotePDFpath = f.path;
                                                });
                                              });

                                              setState(() {
                                                isloadingPdf = false;
                                              });
                                              if (remotePDFpath.isNotEmpty) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PDFScreen(
                                                            title: e.title!,
                                                            path:
                                                                remotePDFpath),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.transparent,
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      catalogueModel!.data!
                                                                      .indexOf(
                                                                          e) %
                                                                  2 !=
                                                              0
                                                          ? SizedBox()
                                                          : Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.3,
                                                                height: 120,
                                                                // decoration: BoxDecoration(
                                                                //   borderRadius:
                                                                //       BorderRadius
                                                                //           .circular(30),
                                                                //   color:
                                                                //       Colors.transparent,
                                                                // ),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            50),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            50),
                                                                    topRight: Radius
                                                                        .circular(
                                                                      30,
                                                                    ),
                                                                    bottomLeft:
                                                                        Radius
                                                                            .circular(
                                                                      30,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        "https://veejayjewels.com/storage/app/public/catalog/${e.thumnail!}",
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              imageProvider,
                                                                          fit: BoxFit
                                                                              .fitWidth, // Adjust the fit property as needed
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    progressIndicatorBuilder: (context,
                                                                            url,
                                                                            downloadProgress) =>
                                                                        CircularProgressIndicator(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade700,
                                                                      value: downloadProgress
                                                                          .progress,
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                      catalogueModel!.data!
                                                                      .indexOf(
                                                                          e) %
                                                                  2 !=
                                                              0
                                                          ? SizedBox()
                                                          : SizedBox(width: 20),
                                                      Column(
                                                        // mainAxisAlignment:
                                                        //     MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GradientText(
                                                            e.title!.length < 19
                                                                ? e.title!
                                                                : "${e.title!.substring(0, 18)}...",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 22.0,
                                                                fontFamily:
                                                                    "Alhadara-DEMO"),
                                                            gradientType:
                                                                GradientType
                                                                    .linear,
                                                            radius: 2.5,
                                                            colors: [
                                                              gradient2,
                                                              gradient1
                                                            ],
                                                          ),
                                                          Text(
                                                            "Read >",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                      catalogueModel!.data!
                                                                      .indexOf(
                                                                          e) %
                                                                  2 ==
                                                              0
                                                          ? SizedBox()
                                                          : Spacer(),
                                                      catalogueModel!.data!
                                                                      .indexOf(
                                                                          e) %
                                                                  2 ==
                                                              0
                                                          ? SizedBox()
                                                          : Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.3,
                                                                height: 120,
                                                                // decoration: BoxDecoration(
                                                                //   borderRadius:
                                                                //       BorderRadius
                                                                //           .circular(30),
                                                                //   color:
                                                                //       Colors.transparent,
                                                                // ),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            50),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            50),
                                                                    topRight: Radius
                                                                        .circular(
                                                                      30,
                                                                    ),
                                                                    bottomLeft:
                                                                        Radius
                                                                            .circular(
                                                                      30,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        "https://veejayjewels.com/storage/app/public/catalog/${e.thumnail!}",
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              imageProvider,
                                                                          fit: BoxFit
                                                                              .fitWidth, // Adjust the fit property as needed
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    progressIndicatorBuilder: (context,
                                                                            url,
                                                                            downloadProgress) =>
                                                                        CircularProgressIndicator(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade700,
                                                                      value: downloadProgress
                                                                          .progress,
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                    ],
                                                  ),
                                                  Image.asset(
                                                      "assets/image/divider.png"),
                                                  // SizedBox(
                                                  //   height: 15,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    padding: EdgeInsets.all(5),
                                    shrinkWrap: true,
                                  ),

                        SizedBox(
                          height: 30,
                        ),

                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 04,
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
                            'See All ',
                            style: TextStyle(
                                color: white,
                                fontSize: 16,
                                fontFamily: "SF-Pro-Display",
                                fontWeight: FontWeight.w500),
                          )),
                        ),

                        //  Container(
                        //            decoration: BoxDecoration(
                        //              borderRadius: BorderRadius.circular(25),
                        //              gradient: LinearGradient(colors:
                        //                  [
                        //                      gradient2,
                        //                    gradient1,

                        //                ],)
                        //            ),
                        //             child: ElevatedButton(

                        //                   onPressed: () {

                        //                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>CartDetails()));
                        //                   },
                        //                   // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                        //                   style: ElevatedButton.styleFrom(
                        //                     backgroundColor: Colors.transparent,
                        //                       elevation: 10.0,
                        //                          shape:  RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.all(Radius.circular(25)),
                        //               ),
                        //                minimumSize: Size(300, 45),

                        //                       textStyle:  TextStyle(color: Colors.white)),
                        //                   child:  Text('Update Profile',style: TextStyle(fontSize: 14,fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500),),
                        //                 ),
                        //                        ),

                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
