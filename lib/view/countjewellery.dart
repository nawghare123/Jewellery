import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Mycart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/customDotIndicator.dart';
import 'package:jewellery/view/home/Ourbranddetails.dart';
import 'package:jewellery/view/home/homeController.dart';
import 'package:jewellery/view/home/jewellerydetailsModel.dart';
import 'package:jewellery/view/home/productDetailsController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CountJeweller extends StatefulWidget {
  CountJeweller({super.key, this.productid});
  int? productid;
  @override
  State<CountJeweller> createState() => _CountJewellerState();
}

class _CountJewellerState extends State<CountJeweller> {
  @override
  void dispose() {
    productDetailsController.clearFields();
    super.dispose();
  }

  ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());

  // String dropdownvalue = '1';
  // List<dynamic>? quantityList = [];
  // List<bool>? isSelectedList = [];
  // dynamic? listToSend = {};

  // // List of items in our dropdown menu
  // var items = [
  //   '1',
  //   '2',
  //   '3',
  //   '4',
  //   '5',
  // ];
  // bool isloading = false;
  // int _currentIndex = 0;
  // JewelleryDetailsModel? jewellerydetailsmodel;
  // String? size;
  // String? userId;
  // @override
  // void initState() {
  //   setState(() {
  //     isloading = true;
  //   });
  //   jewellerydetailslist();
  //   getUserDetails();

  //   super.initState();
  // }

  // Future<void> getUserDetails() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   userId = await prefs.getInt('id').toString();

  //   setState(() {
  //     // isLoading = true;
  //   });
  // }

  // Future<void> jewellerydetailslist() async {
  //   jewellerydetailsmodel =
  //       await ApiHelper.jewellerydetailsclass(widget.productid ?? 0);
  //   jewellerydetailsmodel!.data!.variations!.forEach((element) {
  //     // {"variant": element.type, "quantity": 0}
  //     quantityList!.add(0);
  //     isSelectedList!.add(false);
  //   });

  //   setState(() {
  //     isloading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// appBar: AppBar(
//   // /backgroundColor: Colors.white,
//   flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: <Color>[
//            gradient2,
//               gradient1,
//             ])
//          ),
//      ),
// leading:InkWell(onTap: (){
//   Navigator.pop(context);
// },child: Icon(Icons.arrow_back)),
// title:Center(
// //SvgPicture.asset("assets/image/menu1.svg",height: 25,),
// //
//   child:

//    Text( 'Veejay Jewels',
//    style: TextStyle(
//   color: white,
//           fontSize: 18.0,

//       ),

//   ),
// ),
// actions: [
//   SvgPicture.asset("assets/image/notification.svg",color: white),
//   // Image.asset("assets/image/cartimg.png"),
//   SizedBox(width: 10),
//   SvgPicture.asset("assets/image/cart.svg",color: white),
//    SizedBox(width: 10),
// ],

//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         bottom: Radius.circular(30),
//       ),
// ),),

      backgroundColor: gradient1,
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      // floatingActionButton: Container(
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(25),
      //       gradient: LinearGradient( begin: Alignment.centerLeft,
      //                     end: Alignment.centerRight,colors: [gradient2, gradient1])),
      //   child: FloatingActionButton.extended(
      //     onPressed: () {},
      //     // isExtended: true,
      //     backgroundColor: Colors.transparent,
      //     icon: Icon(Icons.add),
      //     label: Text("Add Item"),
      //   ),
      // ),

      // child:Row(mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //   Icon(Icons.add),
      //   Text("Add Item")

      // ]),

      body: GetBuilder<ProductDetailsController>(
        init: productDetailsController,
        builder: (_) {
          return SingleChildScrollView(
            child: Container(

                //  height: MediaQuery.of(context).size.height,

                child: productDetailsController.isloading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          Container(
                            //  height: MediaQuery.of(context).size.height*0.13,
                            height: 100,

                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [gradient2, gradient1])),

                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, bottom: 0),
                                              child: Icon(
                                                Icons
                                                    .arrow_back_ios_new_outlined,
                                                color: white,
                                                size: 18,
                                              ),
                                            )),
                                        // Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,),

                                        Text(
                                          productDetailsController
                                                      .jewellerydetailsmodel!
                                                      .data!
                                                      .name!
                                                      .toString()
                                                      .length <
                                                  28
                                              ? productDetailsController
                                                  .jewellerydetailsmodel!
                                                  .data!
                                                  .name!
                                                  .toString()
                                              : productDetailsController
                                                      .jewellerydetailsmodel!
                                                      .data!
                                                      .name!
                                                      .toString()
                                                      .substring(0, 25) +
                                                  "...",
                                          style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20.0,
                                              fontFamily: "Alhadara-DEMO"),
                                        ),

                                        //Image.asset("assets/image/notification.png",color: white,),

                                        Row(
                                          children: [
                                            // SvgPicture.asset(
                                            //     "assets/image/notification.svg",
                                            //     color: white),

                                            // SizedBox(width: 15),

                                            //  Image.asset("assets/image/cart.png"),

                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyCart()));
                                                },
                                                child: SvgPicture.asset(
                                                    "assets/image/Buy.svg",
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
                            // height: MediaQuery.of(context).size.height*0.87,
                            width: MediaQuery.of(context).size.width,

                            decoration: BoxDecoration(
                                color: bgcolor,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/image/backgroundimg.jpg'),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30))),

                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      productDetailsController
                                                  .jewellerydetailsmodel!
                                                  .data!
                                                  .name!
                                                  .toString()
                                                  .length <
                                              40
                                          ? productDetailsController
                                              .jewellerydetailsmodel!
                                              .data!
                                              .name!
                                              .toString()
                                          : productDetailsController
                                                  .jewellerydetailsmodel!
                                                  .data!
                                                  .name!
                                                  .toString()
                                                  .substring(0, 35) +
                                              "...",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "SF-Pro-Display",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.39,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: white,
                                      border: Border.all(
                                          color: Colors.black26, width: 0.3),
                                      borderRadius: BorderRadius.circular(25)),
                                  child:
// Image.asset("assets/image/like.png")
                                      Stack(
                                    children: [
                                      // Positioned(
                                      //     right: 20,
                                      //     top: 15,
                                      //     child: SvgPicture.asset(
                                      //         "assets/image/like.svg")),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                          ),
                                          CarouselSlider(
                                            items:
                                                //  jewellerydetailsmodel!
                                                //         .data!.image!.isNotEmpty
                                                //     ?
                                                productDetailsController
                                                    .jewellerydetailsmodel!
                                                    .data!
                                                    .image!
                                                    .map(
                                              (e) {
                                                return FullScreenWidget(
                                                  disposeLevel:
                                                      DisposeLevel.High,
                                                  child: CachedNetworkImage(
                                                    //  height: 10,

                                                    imageUrl:
                                                        ("https://veejayjewels.com/storage/app/public/product/$e")
                                                            // .replaceFirst(
                                                            //     "\"", "")
                                                            .toString(),
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            Center(
                                                      child: CircularProgressIndicator(
                                                          color: Colors
                                                              .grey.shade700,
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            // : [
                                            //     Image.asset(
                                            //         "assets/image/goldbangle12.png"),
                                            //     Image.asset(
                                            //         "assets/image/goldbangle12.png"),
                                            //     Image.asset(
                                            //         "assets/image/goldbangle12.png"),
                                            //   ],
                                            options: CarouselOptions(
                                              height: 155,
                                              aspectRatio: 16 / 9,
                                              viewportFraction: 0.9,
                                              initialPage: 0,
                                              enableInfiniteScroll: true,
                                              reverse: false,
                                              autoPlay: true,
                                              autoPlayInterval:
                                                  Duration(seconds: 3),
                                              autoPlayAnimationDuration:
                                                  Duration(milliseconds: 800),
                                              autoPlayCurve:
                                                  Curves.fastOutSlowIn,
                                              enlargeCenterPage: true,
                                              enlargeFactor: 0.3,
                                              onPageChanged: (index, reason) {
                                                // setState(() {
                                                //   _currentIndex = index;
                                                // });
                                                productDetailsController
                                                    .updateCurrentIndex(index);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          CustomDotIndicator(
                                            currentIndex:
                                                productDetailsController
                                                    .currentIndex,
                                            itemCount: productDetailsController
                                                .jewellerydetailsmodel!
                                                .data!
                                                .image!
                                                .length,
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: white,
                                      border: Border.all(
                                          color: Colors.black26, width: 0.3),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Product Name",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                                productDetailsController
                                                            .jewellerydetailsmodel!.data!.name!
                                                            .toString()
                                                            .length <
                                                        20
                                                    ? productDetailsController
                                                        .jewellerydetailsmodel!
                                                        .data!
                                                        .name!
                                                        .toString()
                                                    : productDetailsController
                                                            .jewellerydetailsmodel!
                                                            .data!
                                                            .name!
                                                            .toString()
                                                            .substring(0, 18) +
                                                        "...",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Product By",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            InkWell(
                                                onTap: () {
//                                                   Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                           builder: (context) =>
//                                                               OurBrandDetails(
// // name:  productDetailsController
// //                                                             .jewellerydetailsmodel!.data!.brand.toString(),
// //                                                             id:  productDetailsController
// //                                                             .jewellerydetailsmodel!.data!.id??0,

//                                                               )));
                                                },
                                                child: Text(
                                                    productDetailsController
                                                                .jewellerydetailsmodel!
                                                                .data!
                                                                .brand !=
                                                            null
                                                        ? productDetailsController
                                                            .jewellerydetailsmodel!
                                                            .data!
                                                            .brand!
                                                            .toString()
                                                        : "Arha",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500))

                                                //  Image.asset(
                                                // "assets/image/brand3.png",
                                                //   height: 40,
                                                // )

                                                )
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Gold Weight",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                                productDetailsController
                                                            .jewellerydetailsmodel!
                                                            .data!
                                                            .unitValue !=
                                                        null
                                                    ? productDetailsController
                                                            .jewellerydetailsmodel!
                                                            .data!
                                                            .unitValue!
                                                            .toString() +
                                                        productDetailsController
                                                            .jewellerydetailsmodel!
                                                            .data!
                                                            .unit!
                                                            .toString()
                                                    : "10Gm",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // SizedBox(height: 8,),
                                //                   Text(
                                //                     "Gold Current Price",
                                //                     style: TextStyle(
                                //                         fontSize: 14,   fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500),
                                //                   ),

                                // SizedBox(height: 8,),
                                //                   GradientText(
                                //                     '₹ 59,410',
                                //                     style: TextStyle(
                                //                       fontSize: 16.0,
                                //                       fontWeight: FontWeight.w500,
                                //                         fontFamily: "SF-Pro-Display",
                                //                     ),
                                //                     gradientType: GradientType.radial,
                                //                     radius: 2.5,
                                //                     colors: [

                                //                       gradient2, gradient1],
                                //                   ),

                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Container(
                                  // height:MediaQuery.of(context).size.height*0.3,
                                  decoration: BoxDecoration(
                                      color: gradient1,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30))),

                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,

                                        // height: 50,

                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Size",
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                // SizedBox(width: 10,),

                                                Row(
                                                  children: [
                                                    Text(
                                                      "Pcs Quantity",
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    //                   InkWell(onTap: (){
                                                    //  },child:

                                                    //                   Icon(Icons.arrow_drop_down, color:white)

                                                    //                   )
                                                  ],
                                                )
                                              ]),
                                        ),
                                      ),
                                      productDetailsController
                                              .jewellerydetailsmodel!
                                              .data!
                                              .variations!
                                              .isEmpty
                                          ? SizedBox()
                                          : Container(
                                              // height:MediaQuery.of(context).size.height*0.4,

                                              decoration: BoxDecoration(
                                                  //                  image: DecorationImage(
                                                  //   image: AssetImage(
                                                  //       'assets/image/backgroundimg.jpg'),
                                                  //   fit: BoxFit.fill,
                                                  // ),

                                                  color: white,
                                                  border: Border.all(
                                                      color: gradient1,
                                                      width: 0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),

                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(children: [
                                                  // Row(children: [
                                                  //     Text("1.5",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                                                  // ],)
                                                  Stack(
                                                    children: [
                                                      RadioListTile(
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              productDetailsController
                                                                      .jewellerydetailsmodel!
                                                                      .data!
                                                                      .variations![
                                                                          0]
                                                                      .type ??
                                                                  "empty",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 25,
                                                                  height: 25,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    gradient: LinearGradient(
                                                                        begin: Alignment
                                                                            .centerLeft,
                                                                        end: Alignment.centerRight,
                                                                        colors: [
                                                                          gradient2,
                                                                          gradient1
                                                                        ]),
                                                                  ),
                                                                  // child:
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      productDetailsController.decrementVariant(productDetailsController
                                                                          .jewellerydetailsmodel!
                                                                          .data!
                                                                          .variations![0]);
                                                                      // productDetailsController.quantityList![productDetailsController
                                                                      //     .jewellerydetailsmodel!
                                                                      //     .data!
                                                                      //     .variations!
                                                                      //     .indexOf(productDetailsController
                                                                      //         .jewellerydetailsmodel!
                                                                      //         .data!
                                                                      //         .variations![0])]--;
                                                                      print(
                                                                          "${productDetailsController.jewellerydetailsmodel!.data!.variations![0].type} ${productDetailsController.quantityList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(productDetailsController.jewellerydetailsmodel!.data!.variations![0])]}");
                                                                      // setState(
                                                                      //     () {});
                                                                    },
                                                                    child: Center(
                                                                        child: Text(
                                                                      "-",
                                                                      style: TextStyle(
                                                                          color:
                                                                              white,
                                                                          fontSize:
                                                                              18),
                                                                    )
                                                                        //  Icon(
                                                                        //   Icons.minimize,
                                                                        //   size: 8,
                                                                        //   color: Colors.white,
                                                                        // ),
                                                                        ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                    height: 30,
                                                                    width: 60,
                                                                    decoration: BoxDecoration(

                                                                        // shape: BoxShape.circle,

                                                                        borderRadius: BorderRadius.all(Radius.elliptical(100, 50)),
                                                                        border: Border.all(color: gradient1)

                                                                        // color: gradient1,

                                                                        ),
                                                                    child: Center(
                                                                        child: Text(
                                                                      productDetailsController
                                                                          .quantityList![productDetailsController
                                                                              .jewellerydetailsmodel!
                                                                              .data!
                                                                              .variations!
                                                                              .indexOf(productDetailsController.jewellerydetailsmodel!.data!.variations![0])]
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ))),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    productDetailsController.incrementVariant(productDetailsController
                                                                        .jewellerydetailsmodel!
                                                                        .data!
                                                                        .variations![0]);
                                                                    // productDetailsController.quantityList![productDetailsController
                                                                    //     .jewellerydetailsmodel!
                                                                    //     .data!
                                                                    //     .variations!
                                                                    //     .indexOf(productDetailsController
                                                                    //         .jewellerydetailsmodel!
                                                                    //         .data!
                                                                    //         .variations![0])]++;
                                                                    // setState(
                                                                    //     () {});
                                                                    print(
                                                                        "${productDetailsController.jewellerydetailsmodel!.data!.variations![0].type} ${productDetailsController.quantityList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(productDetailsController.jewellerydetailsmodel!.data!.variations![0])]}");
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 25,
                                                                    height: 25,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      gradient: LinearGradient(
                                                                          begin:
                                                                              Alignment.centerLeft,
                                                                          end: Alignment.centerRight,
                                                                          colors: [
                                                                            gradient2,
                                                                            gradient1
                                                                          ]),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      size: 15,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        value: "female",
                                                        groupValue: productDetailsController
                                                                .isSelectedList![
                                                            productDetailsController
                                                                .jewellerydetailsmodel!
                                                                .data!
                                                                .variations!
                                                                .indexOf(productDetailsController
                                                                    .jewellerydetailsmodel!
                                                                    .data!
                                                                    .variations![0])],
                                                        activeColor: gradient1,
                                                        onChanged: (value) {
                                                          //  onTap: () {
                                                          print("Tappped...");
                                                          if (productDetailsController
                                                                      .isSelectedList![
                                                                  productDetailsController
                                                                      .jewellerydetailsmodel!
                                                                      .data!
                                                                      .variations!
                                                                      .indexOf(productDetailsController
                                                                          .jewellerydetailsmodel!
                                                                          .data!
                                                                          .variations![0])] ==
                                                              false) {
                                                            productDetailsController
                                                                .updateVartionTrue(
                                                                    productDetailsController
                                                                        .jewellerydetailsmodel!
                                                                        .data!
                                                                        .variations![0]);
                                                            // productDetailsController
                                                            //         .isSelectedList![
                                                            //     productDetailsController
                                                            //         .jewellerydetailsmodel!
                                                            //         .data!
                                                            //         .variations!
                                                            //         .indexOf(productDetailsController
                                                            //             .jewellerydetailsmodel!
                                                            //             .data!
                                                            //             .variations![0])] = true;
                                                          } else {
                                                            productDetailsController
                                                                .updateVartionFalse(
                                                                    productDetailsController
                                                                        .jewellerydetailsmodel!
                                                                        .data!
                                                                        .variations![0]);
                                                            // productDetailsController
                                                            //         .isSelectedList![
                                                            //     productDetailsController
                                                            //         .jewellerydetailsmodel!
                                                            //         .data!
                                                            //         .variations!
                                                            //         .indexOf(productDetailsController
                                                            //             .jewellerydetailsmodel!
                                                            //             .data!
                                                            //             .variations![0])] = false;
                                                          }
                                                          // setState(() {});
                                                          print(
                                                              "Changed to =====>>>> ${productDetailsController.isSelectedList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(productDetailsController.jewellerydetailsmodel!.data!.variations![0])]}");
                                                          for (int i = 0;
                                                              i <
                                                                  productDetailsController
                                                                      .isSelectedList!
                                                                      .length;
                                                              i++) {
                                                            print(
                                                                "===>>>> variant: ${productDetailsController.jewellerydetailsmodel!.data!.variations![0].type} quantity: ${productDetailsController.quantityList![i]} selected: ${productDetailsController.isSelectedList![i]}");
                                                          }
                                                          // },
                                                        },
                                                      ),
                                                      productDetailsController
                                                                      .isSelectedList![
                                                                  productDetailsController
                                                                      .jewellerydetailsmodel!
                                                                      .data!
                                                                      .variations!
                                                                      .indexOf(productDetailsController
                                                                          .jewellerydetailsmodel!
                                                                          .data!
                                                                          .variations![0])] ==
                                                              true
                                                          ? Positioned(
                                                              left: 20,
                                                              top: 10,
                                                              child: Icon(
                                                                Icons.check,
                                                                size: 30,
                                                                color:
                                                                    gradient1,
                                                              ))
                                                          : SizedBox()
                                                    ],
                                                  ),
                                                  Divider(
                                                    color: black,
                                                    thickness: 0.5,
                                                    endIndent: 10,
                                                    indent: 10,
                                                  ),

                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (ctx) =>
                                                              GetBuilder<
                                                                  ProductDetailsController>(
                                                            init:
                                                                productDetailsController,
                                                            // initState: (_) {},
                                                            builder: (_) {
                                                              return BackdropFilter(
                                                                filter: ImageFilter
                                                                    .blur(
                                                                        sigmaX:
                                                                            10.0,
                                                                        sigmaY:
                                                                            10.0),
                                                                child:
                                                                    AlertDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  actions: [
                                                                    Container(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      decoration: BoxDecoration(
                                                                          color:
                                                                              gradient1,
                                                                          borderRadius: BorderRadius.only(
                                                                              topRight: Radius.circular(30),
                                                                              topLeft: Radius.circular(30),
                                                                              bottomLeft: Radius.circular(30),
                                                                              bottomRight: Radius.circular(30))),
                                                                      child:
                                                                          Column(
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.08,

                                                                            // height: 50,

                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 15, right: 15),
                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                                                                Text(
                                                                                  "Size",
                                                                                  style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w500),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 15,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "Pcs Quantity",
                                                                                      style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    // InkWell(onTap: () {}, child: Icon(Icons.arrow_drop_down, color: white))
                                                                                  ],
                                                                                )
                                                                              ]),
                                                                            ),
                                                                          ),

                                                                          Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.4,
                                                                            decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                                  image: AssetImage('assets/image/backgroundimg.jpg'),
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                                color: white,
                                                                                border: Border.all(color: gradient1, width: 0.3),
                                                                                borderRadius: BorderRadius.circular(25)),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: ListView(children: [
                                                                                // Row(children: [
                                                                                //     Text("1.5",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                                                                                // ],)
                                                                                ListView(
                                                                                  shrinkWrap: true,
                                                                                  primary: false,
                                                                                  children: productDetailsController.jewellerydetailsmodel!.data!.variations!.map((e) {
                                                                                    return Stack(
                                                                                      children: [
                                                                                        RadioListTile(
                                                                                          title: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                                e.type ?? "empty",
                                                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                                                              ),
                                                                                              Row(
                                                                                                children: [
                                                                                                  Container(
                                                                                                    width: 25,
                                                                                                    height: 25,
                                                                                                    decoration: BoxDecoration(
                                                                                                      shape: BoxShape.circle,
                                                                                                      gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [gradient2, gradient1]),
                                                                                                    ),
                                                                                                    child: GestureDetector(
                                                                                                      onTap: () {
                                                                                                        productDetailsController.decrementVariant(e);
                                                                                                        // productDetailsController.quantityList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(e)]--;
                                                                                                        print("${e.type} ${productDetailsController.quantityList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(e)]}");
                                                                                                        // setState(() {});
                                                                                                      },
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "-",
                                                                                                        style: TextStyle(color: white, fontSize: 18),
                                                                                                      )
                                                                                                          //  Icon(
                                                                                                          //   Icons.minimize,
                                                                                                          //   size: 8,
                                                                                                          //   color: Colors.white,
                                                                                                          // ),
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    width: 10,
                                                                                                  ),
                                                                                                  Container(
                                                                                                      height: 30,
                                                                                                      width: 60,
                                                                                                      decoration: BoxDecoration(

                                                                                                          // shape: BoxShape.circle,

                                                                                                          borderRadius: BorderRadius.all(Radius.elliptical(100, 50)),
                                                                                                          border: Border.all(color: gradient1)

                                                                                                          // color: gradient1,

                                                                                                          ),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        productDetailsController.quantityList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(e)].toString(),
                                                                                                        style: TextStyle(fontWeight: FontWeight.w500),
                                                                                                      ))),
                                                                                                  SizedBox(
                                                                                                    width: 10,
                                                                                                  ),
                                                                                                  GestureDetector(
                                                                                                    onTap: () {
                                                                                                      productDetailsController.incrementVariant(e);
                                                                                                      // productDetailsController.quantityList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(e)]++;
                                                                                                      // setState(() {});
                                                                                                      print("${e.type} ${productDetailsController.quantityList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(e)]}");
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      width: 25,
                                                                                                      height: 25,
                                                                                                      decoration: BoxDecoration(
                                                                                                        shape: BoxShape.circle,
                                                                                                        gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [gradient2, gradient1]),
                                                                                                      ),
                                                                                                      child: Icon(
                                                                                                        Icons.add,
                                                                                                        size: 15,
                                                                                                        color: Colors.white,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                          value: "female",
                                                                                          groupValue: productDetailsController.isSelectedList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(e)],
                                                                                          activeColor: gradient1,
                                                                                          onChanged: (value) {
                                                                                            //  onTap: () {
                                                                                            print("Tappped...");
                                                                                            if (productDetailsController.isSelectedList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(e)] == false) {
                                                                                              // productDetailsController.isSelectedList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(e)] = true;
                                                                                              productDetailsController.updateVartionTrue(e);
                                                                                            } else {
                                                                                              // productDetailsController.isSelectedList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(e)] = false;
                                                                                              productDetailsController.updateVartionFalse(e);
                                                                                            }
                                                                                            // setState(() {});
                                                                                            print("Changed to =====>>>> ${productDetailsController.isSelectedList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(e)]}");
                                                                                            // },
                                                                                            for (int i = 0; i < productDetailsController.isSelectedList!.length; i++) {
                                                                                              print("===>>>> variant: ${e.type} quantity: ${productDetailsController.quantityList![i]} selected: ${productDetailsController.isSelectedList![i]}");
                                                                                            }
                                                                                          },
                                                                                        ),
                                                                                        productDetailsController.isSelectedList![productDetailsController.jewellerydetailsmodel!.data!.variations!.indexOf(e)] == true
                                                                                            ? Positioned(
                                                                                                left: 20,
                                                                                                top: 10,
                                                                                                child: Icon(
                                                                                                  Icons.check,
                                                                                                  size: 30,
                                                                                                  color: gradient1,
                                                                                                ))
                                                                                            : SizedBox()
                                                                                      ],
                                                                                    );
                                                                                  }).toList(),
                                                                                ),
                                                                                Divider(
                                                                                  color: black,
                                                                                  thickness: 0.5,
                                                                                  endIndent: 10,
                                                                                  indent: 10,
                                                                                ),

                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: InkWell(
                                                                                    onTap: () async {
                                                                                      // Get.back();
                                                                                      MyHomeController myHomeController = Get.put(MyHomeController());
                                                                                      print("user verification: ====>>>> ${myHomeController.isVerified}");

                                                                                      if (myHomeController.isVerified == false) {
                                                                                        final snack = SnackBar(content: Text("Please verify first."));
                                                                                        ScaffoldMessenger.of(context).showSnackBar(snack);
                                                                                        // Get.snackbar(
                                                                                        //   'Verification Required',
                                                                                        //   'Please verify first',
                                                                                        //   snackPosition: SnackPosition.BOTTOM,
                                                                                        //   backgroundColor: Colors.red,
                                                                                        //   colorText: Colors.white,
                                                                                        // );
                                                                                        return;
                                                                                      }
                                                                                      print("====>>> adding item to cart ");
                                                                                      productDetailsController.listToSend = {
                                                                                        "data": {
                                                                                          "user-id": productDetailsController.userId,
                                                                                          "product-id": productDetailsController.jewellerydetailsmodel!.data!.id!,
                                                                                          "product-name": productDetailsController.jewellerydetailsmodel!.data!.name!,
                                                                                          //     "design":
                                                                                          // productDetailsController
                                                                                          //     .jewellerydetailsmodel!
                                                                                          //     .data!
                                                                                          //     .design!,
                                                                                          "product-image": "https://veejayjewels.com/storage/app/public/product/" + productDetailsController.jewellerydetailsmodel!.data!.image![0],
                                                                                        },
                                                                                        "variants": []
                                                                                      };
                                                                                      // listToSend!.add();

                                                                                      for (int i = 0; i < productDetailsController.isSelectedList!.length; i++) {
                                                                                        print("===>>>> variant: ${productDetailsController.jewellerydetailsmodel!.data!.variations![i].type} price: ${productDetailsController.jewellerydetailsmodel!.data!.variations![i].price} quantity: ${productDetailsController.quantityList![i]} selected: ${productDetailsController.isSelectedList![i]}");
                                                                                        if (productDetailsController.isSelectedList![i]) {
                                                                                          productDetailsController.listToSend!["variants"].add({
                                                                                            "variant": productDetailsController.jewellerydetailsmodel!.data!.variations![i].type,
                                                                                            // "price": jewellerydetailsmodel!
                                                                                            //     .data!.variations![i].price,
                                                                                            "quantity": productDetailsController.quantityList![i],
                                                                                          });
                                                                                        }
                                                                                      }
                                                                                      // setState(() {
                                                                                      productDetailsController.updateLoading(true);
                                                                                      // });
                                                                                      // print(listToSend);
                                                                                      try {
                                                                                        await ApiHelper.addToCart(productDetailsController.listToSend);
                                                                                        showDialog(
                                                                                          context: context,
                                                                                          builder: (BuildContext context) {
                                                                                            return AlertDialog(
                                                                                              title: Text('Success'),
                                                                                              content: Text('Item Added.'),
                                                                                              actions: <Widget>[
                                                                                                TextButton(
                                                                                                  child: Text(
                                                                                                    'OK',
                                                                                                    style: TextStyle(color: gradient1),
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    Navigator.of(context).pop(); // Close the dialog
                                                                                                  },
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          },
                                                                                        );
                                                                                      } catch (e) {}
                                                                                      // setState(() {
                                                                                      //   productDetailsController.isloading =
                                                                                      //       false;
                                                                                      // });
                                                                                      productDetailsController.updateLoading(false);
                                                                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => MyCart()));
                                                                                    },
                                                                                    child: Container(
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
                                                                                        'Add to cart ',
                                                                                        style: TextStyle(color: white, fontSize: 16, fontFamily: "SF-Pro-Display", fontWeight: FontWeight.w500),
                                                                                      )),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ]),
                                                                            ),
                                                                          ),

                                                                          // TextButton(
                                                                          //   onPressed: () {
                                                                          //     Navigator.of(ctx).pop();
                                                                          //   },
                                                                          //   child: Container(
                                                                          //     color: Colors.green,
                                                                          //     padding: const EdgeInsets.all(14),
                                                                          //     child: const Text("okay"),
                                                                          //   ),
                                                                          // ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.07,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            03,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                gradient:
                                                                    LinearGradient(
                                                                  begin: Alignment
                                                                      .centerLeft,
                                                                  end: Alignment
                                                                      .centerRight,
                                                                  colors: [
                                                                    gradient2,
                                                                    gradient1,
                                                                  ],
                                                                )),
                                                        child: Center(
                                                            child: Text(
                                                          'Show more size',
                                                          style: TextStyle(
                                                              color: white,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  "SF-Pro-Display",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Product details",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "SF-Pro-Display",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: white,
                                      border: Border.all(
                                          color: Colors.black26, width: 0.3),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Design No.",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                                productDetailsController
                                                    .jewellerydetailsmodel!
                                                    .data!
                                                    .design!
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total Weight",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                                productDetailsController
                                                        .jewellerydetailsmodel!
                                                        .data!
                                                        .totalWeight! +
                                                    productDetailsController
                                                        .jewellerydetailsmodel!
                                                        .data!
                                                        .unit!,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Jewelry Type",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                                productDetailsController
                                                    .jewellerydetailsmodel!
                                                    .data!
                                                    .jewelryType!,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: white,
                                      border: Border.all(
                                          color: Colors.black26, width: 0.3),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child:
                                          // Text(
                                          Html(
                                        data: productDetailsController
                                            .jewellerydetailsmodel!
                                            .data!
                                            .description!
                                            .toString(),
                                      )
                                      // .data ??
                                      // "",
                                      //   style: TextStyle(
                                      //       fontSize: 14,
                                      //       fontWeight: FontWeight.w500),
                                      // ),
                                      ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      MyHomeController myHomeController =
                                          Get.put(MyHomeController());
                                      print(
                                          "user verification: ====>>>> ${myHomeController.isVerified}");

                                      if (myHomeController.isVerified ==
                                          false) {
                                        final snack = SnackBar(
                                            content:
                                                Text("Please verify first."));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snack);
                                        // Get.snackbar(
                                        //   'Verification Required',
                                        //   'Please verify first',
                                        //   snackPosition: SnackPosition.BOTTOM,
                                        //   backgroundColor: Colors.red,
                                        //   colorText: Colors.white,
                                        // );
                                        return;
                                      }
                                      print("====>>> adding item to cart ");
                                      productDetailsController.listToSend = {
                                        "data": {
                                          "user-id":
                                              productDetailsController.userId,
                                          "product-id": productDetailsController
                                              .jewellerydetailsmodel!.data!.id!,
                                          "product-name":
                                              productDetailsController
                                                  .jewellerydetailsmodel!
                                                  .data!
                                                  .name!,
                                          // "design":
                                          //                                                           productDetailsController
                                          //                                                               .jewellerydetailsmodel!
                                          //                                                               .data!
                                          //                                                               .design!,
                                          "product-image":
                                              "https://veejayjewels.com/storage/app/public/product/" +
                                                  productDetailsController
                                                      .jewellerydetailsmodel!
                                                      .data!
                                                      .image![0],
                                        },
                                        "variants": []
                                      };
                                      // listToSend!.add();

                                      for (int i = 0;
                                          i <
                                              productDetailsController
                                                  .isSelectedList!.length;
                                          i++) {
                                        print(
                                            "===>>>> variant: ${productDetailsController.jewellerydetailsmodel!.data!.variations![i].type} price: ${productDetailsController.jewellerydetailsmodel!.data!.variations![i].price} quantity: ${productDetailsController.quantityList![i]} selected: ${productDetailsController.isSelectedList![i]}");
                                        if (productDetailsController
                                            .isSelectedList![i]) {
                                          productDetailsController
                                              .listToSend!["variants"]
                                              .add({
                                            "variant": productDetailsController
                                                .jewellerydetailsmodel!
                                                .data!
                                                .variations![i]
                                                .type,
                                            // "price": jewellerydetailsmodel!
                                            //     .data!.variations![i].price,
                                            "quantity": productDetailsController
                                                .quantityList![i],
                                          });
                                        }
                                      }
                                      // setState(() {
                                      productDetailsController
                                          .updateLoading(true);
                                      // });
                                      // print(listToSend);
                                      try {
                                        await ApiHelper.addToCart(
                                            productDetailsController
                                                .listToSend);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Success'),
                                              content: Text('Item Added.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: gradient1),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } catch (e) {}

                                      // setState(() {
                                      //   productDetailsController.isloading =
                                      //       false;
                                      // });
                                      productDetailsController
                                          .updateLoading(false);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => MyCart()));
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          04,
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
                                        'Add to cart ',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 16,
                                            fontFamily: "SF-Pro-Display",
                                            fontWeight: FontWeight.w500),
                                      )),
                                    ),
                                  ),
                                ),

                                // Container(
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(25),
                                //       gradient: LinearGradient(
                                //         colors: [
                                //           gradient2,
                                //           gradient1,
                                //         ],
                                //       )),
                                //   child: ElevatedButton(
                                //     onPressed: () {
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (context) => MyCart()));
                                //     },

                                //     // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),

                                //     style: ElevatedButton.styleFrom(
                                //         backgroundColor: Colors.transparent,
                                //         elevation: 10.0,
                                //         shape: RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.all(Radius.circular(25)),
                                //         ),
                                //          minimumSize: Size(300, 45),
                                //         textStyle: TextStyle(color: Colors.white)),

                                //     child: Text(
                                //       'Add to cart',
                                //       style: TextStyle(
                                //           fontSize: 14,fontFamily: "SF-Pro-Display", fontWeight: FontWeight.w500),
                                //     ),
                                //   ),
                                // ),
                              ]),
                            ),
                          )
                        ],
                      )),
          );
        },
      ),
    );
  }

//   ImageFilter.blur({
//   double sigmaX = 0.0,
//   double sigmaY = 0.0,
//   TileMode tileMode = TileMode.clamp
// });
}
