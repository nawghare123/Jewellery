import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:jewellery/view/drawer.dart';
import 'package:jewellery/view/orderItemList.dart';
import 'package:jewellery/view/orderModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/Mycart.dart';
import 'package:jewellery/view/countjewellery.dart';
import 'package:jewellery/view/getCartModel.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  OrderModel? orderModel;
  bool isloading = false;
  DateTime now = DateTime.now();
  @override
  void initState() {
    getCartList();
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

  Future<void> getUserData() async {
    setState(() {
      isloading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = await prefs.getInt('id').toString();
    await prefs.getInt('is_phone_verified');

    state = await prefs.getString('state');
    city = await prefs.getString('city');
    pincode = await prefs.getString('pincode') ?? "Guest";
    print("userid $userId, state $state, city $city, pincode $pincode");

    setState(() {
      isloading = false;
    });
  }

  Future<void> getCartList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    orderModel = await ApiHelper.getOrdersList(
        await prefs.getInt('id').toString() ?? "0");
    orderModel!.data!.forEach((e) => print(e));
    orderModel!.data = orderModel!.data!.reversed.toList();
    setState(() {
      isloading = false;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    print("clicked...");
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: drawer(context),
        // backgroundColor: gradient1,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/product_bg_image.png'),
               fit: BoxFit.fill, // Adjust the fit as per your requirement
            ),
          ),
          child: ListView(
            primary: true,
            children: [
              Container(
                // height: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [gradient2, gradient1])),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: _openDrawer,
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
                            // Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,),
SizedBox(width: 55),
                            Center(
                              child: Text(
                                'Order History',textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0,
                                    fontFamily: "Alhadara-DEMO"),
                              ),
                            ),

                            //Image.asset("assets/image/notification.png",color: white,),

                          //   Row(
                          //     children: [
                          //       // SvgPicture.asset("assets/image/notification.svg",
                          //       //     color: white),

                          //       // SizedBox(width: 15),

                          //       //  Image.asset("assets/image/cart.png"),

                          //       InkWell(
                          //           onTap: () {
                          //             Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                     builder: (context) => MyCart()));
                          //           },
                          //           child: SvgPicture.asset(
                          //               "assets/image/Buy.svg",
                          //               color: white)),

                          //       SizedBox(width: 10),
                          //     ],
                          //   ),
                           ]),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  // height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      // color: bgcolor,

                      image: DecorationImage(
                        image: AssetImage('assets/image/product_bg_image.png'),
                        fit: BoxFit
                            .cover, // Adjust the fit as per your requirement
                      ),
                      // image: DecorationImage(
                      //   image: AssetImage('assets/image/backgroundimg.jpg'),
                      //   fit: BoxFit.fill,
                      // ),
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: orderModel == null
                          ? SizedBox()
                          : Column(
                              children: orderModel!.data!
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderItemList(
                                                        orderId:
                                                            e.id.toString(),
                                                        address: e
                                                            .deliveryAddress
                                                            .toString(),
                                                        invoice: e.invoice
                                                            .toString(),
                                                            date: e.createdAt
                                                            .toString(),
                                                      )));
                                        },
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            //  height: MediaQuery.of(context).size.height*0.3,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment
                                                      .centerLeft, // Start from the top
                                                  end: Alignment
                                                      .centerRight, // End at the bottom
                                                  colors: [
                                                    cardgradient1,
                                                    cardgradient2,
                                                  ],
                                                ),
                                                // color: white,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Image.asset(
                                                        "assets/image/logo.png"),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right:13.0,top:5),
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                         Text(DateFormat("dd MMM yyyy").format( DateTime.parse((e.createdAt.toString()))),
                                                                //  DateFormat('dd-MM-yyyy').format(e.createdAt.toString()),
                                                                       // e.id.toString(),
                                                                   // e.productName!.length < 20
                                                                   //     ? e.productName!
                                                                   //     : "${e.productName!.substring(0, 18)}...",
                                                                   style: TextStyle(
                                                                       fontSize: 12,
                                                                fontFamily:
                                                                    "SF-Pro-Display",
                                                                fontWeight:
                                                                    FontWeight.w500),
                                                                 ),
                                                                                               SizedBox(
                                                        height: 3,
                                                      ),
                                                
                                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "Order Id: " +
                                                                e.id.toString(),
                                                            // e.productName!.length < 20
                                                            //     ? e.productName!
                                                            //     : "${e.productName!.substring(0, 18)}...",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "SF-Pro-Display",
                                                                fontWeight:
                                                                    FontWeight.w500),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                
                                                          // Text(
                                                          //   List<Map<String, dynamic>>.from(json.decode(e.variant!.toString())).
                                                          //   ,
                                                          //   style: TextStyle(
                                                          //       fontSize: 14,
                                                          //       fontFamily:
                                                          //           "SF-Pro-Display",
                                                          //       fontWeight:
                                                          //           FontWeight.w400),
                                                          // ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          // Text(e.variant!.toString()),
                                                          Text("Order Status: " +
                                                              e.orderStatus!),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                
                                                          
                                                          Text(
                                                            // "Address: " +
                                                            e.deliveryAddress
                                                                        .toString()
                                                                        .length <
                                                                    20
                                                                ? "Address : ${e.deliveryAddress!}"
                                                                : "Address : ${e.deliveryAddress!.substring(0, 19)}...",
                                                            // e.productName!.length < 20
                                                            //     ? e.productName!
                                                            //     : "${e.productName!.substring(0, 18)}...",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    "SF-Pro-Display",
                                                                fontWeight:
                                                                    FontWeight.w500),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                         ],
                                            )
                                            // Row(
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment.center,
                                            //     children: [
                                            //       // Container(
                                            //       //   height: MediaQuery.of(context)
                                            //       //           .size
                                            //       //           .height *
                                            //       //       0.2,
                                            //       //   width: MediaQuery.of(context)
                                            //       //           .size
                                            //       //           .width *
                                            //       //       0.3,
                                            //       //   decoration: BoxDecoration(
                                            //       //       color: white,
                                            //       //       borderRadius:
                                            //       //           BorderRadius.circular(
                                            //       //               30)),
                                            //       //   child: Padding(
                                            //       //     padding:
                                            //       //         const EdgeInsets.all(
                                            //       //             15.0),
                                            //       //     child: Image.network(
                                            //       //       "https://veejayjewels.com/storage/app/public/product/${e.image!}",
                                            //       //       height: 100,
                                            //       //     ),
                                            //       //   ),
                                            //       // ),
                                            //       // SizedBox(
                                            //       //   width: MediaQuery.of(context)
                                            //       //           .size
                                            //       //           .width *
                                            //       //       0.0,
                                            //       // ),
                                            //       Column(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment.center,
                                            //         crossAxisAlignment:
                                            //             CrossAxisAlignment.center,
                                            //         children: [
                                            //           // Text(
                                            //           //   e.id.toString(),
                                            //           //   // e.productName!.length < 20
                                            //           //   //     ? e.productName!
                                            //           //   //     : "${e.productName!.substring(0, 18)}...",
                                            //           //   style: TextStyle(
                                            //           //       fontSize: 16,
                                            //           //       fontFamily:
                                            //           //           "SF-Pro-Display",
                                            //           //       fontWeight:
                                            //           //           FontWeight.w500),
                                            //           // ),
                                            //           // SizedBox(
                                            //           //   height: 5,
                                            //           // ),

                                            //           // // Text(
                                            //           // //   List<Map<String, dynamic>>.from(json.decode(e.variant!.toString())).
                                            //           // //   ,
                                            //           // //   style: TextStyle(
                                            //           // //       fontSize: 14,
                                            //           // //       fontFamily:
                                            //           // //           "SF-Pro-Display",
                                            //           // //       fontWeight:
                                            //           // //           FontWeight.w400),
                                            //           // // ),
                                            //           // SizedBox(
                                            //           //   height: 5,
                                            //           // ),
                                            //           // // Text(e.variant!.toString()),
                                            //           // Text(e.orderStatus!),
                                            //           // SizedBox(
                                            //           //   height: 5,
                                            //           // ),
                                            //           //               Row(
                                            //           //                                 children: [
                                            //           //                                   Container(
                                            //           //                                     width: 25,
                                            //           //                                     height: 25,
                                            //           //                                     decoration: BoxDecoration(
                                            //           //                                       shape: BoxShape.circle,
                                            //           //                                      // color: gradient1,
                                            //           // gradient: LinearGradient(begin: Alignment.centerLeft,
                                            //           // end: Alignment.centerRight,
                                            //           // colors: [
                                            //           //   gradient2,gradient1
                                            //           // ])
                                            //           //                                     ),
                                            //           //                                     child: Center(
                                            //           //                                       child:Text("-",style: TextStyle(color: white,fontSize: 18),)
                                            //           //                                       //  Icon(
                                            //           //                                       //   Icons.minimize,
                                            //           //                                       //   size: 8,
                                            //           //                                       //   color: Colors.white,
                                            //           //                                       // ),
                                            //           //                                     ),
                                            //           //                                   ),
                                            //           //                                   SizedBox(
                                            //           //                                     width: 10,
                                            //           //                                   ),
                                            //           //                                   Container(
                                            //           //                                       width: 60,
                                            //           //                                       height: 30,
                                            //           //                                       decoration: BoxDecoration(

                                            //           //                                           // shape: BoxShape.circle,

                                            //           //                                           borderRadius:
                                            //           //                                               BorderRadius.circular(50),
                                            //           //                                           border:
                                            //           //                                               Border.all(color: gradient1)

                                            //           //                                           // color: gradient1,

                                            //           //                                           ),
                                            //           //                                       child: Center(
                                            //           //                                           child: Text(
                                            //           //                                         "4",
                                            //           //                                         style: TextStyle(
                                            //           //                                             fontWeight: FontWeight.w500),
                                            //           //                                       ))),
                                            //           //                                   SizedBox(
                                            //           //                                     width: 10,
                                            //           //                                   ),
                                            //           //                                   Container(
                                            //           //                                     width: 25,
                                            //           //                                     height: 25,
                                            //           //                                     decoration: BoxDecoration(
                                            //           //                                       shape: BoxShape.circle,
                                            //           //                                       gradient: LinearGradient(begin: Alignment.centerLeft,
                                            //           // end: Alignment.centerRight,
                                            //           // colors: [
                                            //           //   gradient2,gradient1
                                            //           // ]),

                                            //           //                                     ),
                                            //           //                                     child: Icon(
                                            //           //                                       Icons.add,size: 15,
                                            //           //                                       color: Colors.white,
                                            //           //                                     ),
                                            //           //                                   ),
                                            //           //                                 ],
                                            //           //                               )
                                            //         ],
                                            //       )
                                            //     ]),

                                            ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Image.asset("assets/image/divider.png"),
                                  )
                                  .toList(),
                              //-----------------------

                              //     [
                              //   Container(
                              //       //  height: MediaQuery.of(context).size.height*0.3,
                              //       decoration: BoxDecoration(
                              //           color: white,
                              //           borderRadius:
                              //               BorderRadius.circular(30)),
                              //       child: Row(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.center,
                              //           children: [
                              //             Container(
                              //               height: MediaQuery.of(context)
                              //                       .size
                              //                       .height *
                              //                   0.2,
                              //               width: MediaQuery.of(context)
                              //                       .size
                              //                       .width *
                              //                   0.3,
                              //               decoration: BoxDecoration(
                              //                   color: white,
                              //                   borderRadius:
                              //                       BorderRadius.circular(30)),
                              //               child: Padding(
                              //                 padding:
                              //                     const EdgeInsets.all(15.0),
                              //                 child: Image.asset(
                              //                   "assets/image/goldbangal.png",
                              //                   height: 100,
                              //                 ),
                              //               ),
                              //             ),
                              //             SizedBox(
                              //               width: MediaQuery.of(context)
                              //                       .size
                              //                       .width *
                              //                   0.08,
                              //             ),
                              //             Column(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 Text(
                              //                   "Gold Bangle",
                              //                   style: TextStyle(
                              //                       fontSize: 16,
                              //                       fontFamily:
                              //                           "SF-Pro-Display",
                              //                       fontWeight:
                              //                           FontWeight.w500),
                              //                 ),
                              //                 SizedBox(
                              //                   height: 5,
                              //                 ),

                              //                 Text(
                              //                   "Weight 10gms",
                              //                   style: TextStyle(
                              //                       fontSize: 14,
                              //                       fontFamily:
                              //                           "SF-Pro-Display",
                              //                       fontWeight:
                              //                           FontWeight.w400),
                              //                 ),
                              //                 SizedBox(
                              //                   height: 5,
                              //                 ),

                              //                 Row(
                              //                   children: [
                              //                     Text(
                              //                       "Size : 2.5 ",
                              //                       style: TextStyle(
                              //                           fontSize: 14,
                              //                           fontFamily:
                              //                               "SF-Pro-Display",
                              //                           fontWeight:
                              //                               FontWeight.w400),
                              //                     ),
                              //                     SizedBox(width: 10),
                              //                     Text(
                              //                       "Quantity : 4",
                              //                       style: TextStyle(
                              //                           fontSize: 14,
                              //                           fontFamily:
                              //                               "SF-Pro-Display",
                              //                           fontWeight:
                              //                               FontWeight.w400),
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 SizedBox(
                              //                   height: 5,
                              //                 ),
                              //                 //               Row(
                              //                 //                                 children: [
                              //                 //                                   Container(
                              //                 //                                     width: 25,
                              //                 //                                     height: 25,
                              //                 //                                     decoration: BoxDecoration(
                              //                 //                                       shape: BoxShape.circle,
                              //                 //                                      // color: gradient1,
                              //                 // gradient: LinearGradient(begin: Alignment.centerLeft,
                              //                 // end: Alignment.centerRight,
                              //                 // colors: [
                              //                 //   gradient2,gradient1
                              //                 // ])
                              //                 //                                     ),
                              //                 //                                     child: Center(
                              //                 //                                       child:Text("-",style: TextStyle(color: white,fontSize: 18),)
                              //                 //                                       //  Icon(
                              //                 //                                       //   Icons.minimize,
                              //                 //                                       //   size: 8,
                              //                 //                                       //   color: Colors.white,
                              //                 //                                       // ),
                              //                 //                                     ),
                              //                 //                                   ),
                              //                 //                                   SizedBox(
                              //                 //                                     width: 10,
                              //                 //                                   ),
                              //                 //                                   Container(
                              //                 //                                       width: 60,
                              //                 //                                       height: 30,
                              //                 //                                       decoration: BoxDecoration(

                              //                 //                                           // shape: BoxShape.circle,

                              //                 //                                           borderRadius:
                              //                 //                                               BorderRadius.circular(50),
                              //                 //                                           border:
                              //                 //                                               Border.all(color: gradient1)

                              //                 //                                           // color: gradient1,

                              //                 //                                           ),
                              //                 //                                       child: Center(
                              //                 //                                           child: Text(
                              //                 //                                         "4",
                              //                 //                                         style: TextStyle(
                              //                 //                                             fontWeight: FontWeight.w500),
                              //                 //                                       ))),
                              //                 //                                   SizedBox(
                              //                 //                                     width: 10,
                              //                 //                                   ),
                              //                 //                                   Container(
                              //                 //                                     width: 25,
                              //                 //                                     height: 25,
                              //                 //                                     decoration: BoxDecoration(
                              //                 //                                       shape: BoxShape.circle,
                              //                 //                                       gradient: LinearGradient(begin: Alignment.centerLeft,
                              //                 // end: Alignment.centerRight,
                              //                 // colors: [
                              //                 //   gradient2,gradient1
                              //                 // ]),

                              //                 //                                     ),
                              //                 //                                     child: Icon(
                              //                 //                                       Icons.add,size: 15,
                              //                 //                                       color: Colors.white,
                              //                 //                                     ),
                              //                 //                                   ),
                              //                 //                                 ],
                              //                 //                               )
                              //               ],
                              //             )
                              //           ])),
                              //   SizedBox(
                              //     height: 10,
                              //   ),
                              //   Image.asset("assets/image/divider.png"),

                              //   // SizedBox(
                              //   //   height: 10,
                              //   // ),
                              //   // Container(
                              //   //     decoration: BoxDecoration(
                              //   //         color: white,
                              //   //         borderRadius: BorderRadius.circular(30)),
                              //   //     child: Row(
                              //   //         crossAxisAlignment: CrossAxisAlignment.center,
                              //   //         children: [
                              //   //           Container(
                              //   //             height:
                              //   //                 MediaQuery.of(context).size.height *
                              //   //                     0.2,
                              //   //             width: MediaQuery.of(context).size.width *
                              //   //                 0.3,
                              //   //             decoration: BoxDecoration(
                              //   //                 color: white,
                              //   //                 borderRadius:
                              //   //                     BorderRadius.circular(30)),
                              //   //             child: Padding(
                              //   //               padding: const EdgeInsets.all(15.0),
                              //   //               child: Image.asset(
                              //   //                 "assets/image/kangan0.png",
                              //   //                 height: 100,
                              //   //               ),
                              //   //             ),
                              //   //           ),
                              //   //           SizedBox(
                              //   //             width: MediaQuery.of(context).size.width *
                              //   //                 0.08,
                              //   //           ),
                              //   //           Column(
                              //   //             crossAxisAlignment:
                              //   //                 CrossAxisAlignment.start,
                              //   //             children: [
                              //   //               Text(
                              //   //                 "Gold Bangle",
                              //   //                 style: TextStyle(
                              //   //                     fontSize: 16,
                              //   //                     fontFamily: "SF-Pro-Display",
                              //   //                     fontWeight: FontWeight.w500),
                              //   //               ),
                              //   //               SizedBox(
                              //   //                 height: 5,
                              //   //               ),

                              //   //               Text(
                              //   //                 "Weight 10gms",
                              //   //                 style: TextStyle(
                              //   //                     fontSize: 14,
                              //   //                     fontFamily: "SF-Pro-Display",
                              //   //                     fontWeight: FontWeight.w400),
                              //   //               ),
                              //   //               SizedBox(
                              //   //                 height: 5,
                              //   //               ),

                              //   //               Row(
                              //   //                 children: [
                              //   //            our brand       Text(
                              //   //                     "Size : 2.5 ",
                              //   //                     style: TextStyle(
                              //   //                         fontSize: 14,
                              //   //                         fontFamily: "SF-Pro-Display",
                              //   //                         fontWeight: FontWeight.w400),
                              //   //                   ),
                              //   //                   SizedBox(width: 10),
                              //   //                   Text(
                              //   //                     "Quantity : 4",
                              //   //                     style: TextStyle(
                              //   //                         fontSize: 14,
                              //   //                         fontFamily: "SF-Pro-Display",
                              //   //                         fontWeight: FontWeight.w400),
                              //   //                   ),
                              //   //                 ],
                              //   //               ),
                              //   //               SizedBox(
                              //   //                 height: 5,
                              //   //               ),
                              //   //               //               Row(
                              //   //               //                                 children: [
                              //   //               //                                   Container(
                              //   //               //                                     width: 25,
                              //   //               //                                     height: 25,
                              //   //               //                                     decoration: BoxDecoration(
                              //   //               //                                       shape: BoxShape.circle,
                              //   //               //                                      // color: gradient1,
                              //   //               // gradient: LinearGradient(begin: Alignment.centerLeft,
                              //   //               // end: Alignment.centerRight,
                              //   //               // colors: [
                              //   //               //   gradient2,gradient1
                              //   //               // ])
                              //   //               //                                     ),
                              //   //               //                                     child: Center(
                              //   //               //                                       child:Text("-",style: TextStyle(color: white,fontSize: 18),)
                              //   //               //                                       //  Icon(
                              //   //               //                                       //   Icons.minimize,
                              //   //               //                                       //   size: 8,
                              //   //               //                                       //   color: Colors.white,
                              //   //               //                                       // ),
                              //   //               //                                     ),
                              //   //               //                                   ),
                              //   //               //                                   SizedBox(
                              //   //               //                                     width: 10,
                              //   //               //                                   ),
                              //   //               //                                   Container(
                              //   //               //                                       width: 60,
                              //   //               //                                      height: 30,
                              //   //               //                                       decoration: BoxDecoration(

                              //   //               //                                           // shape: BoxShape.circle,

                              //   //               //                                           borderRadius:
                              //   //               //                                               BorderRadius.circular(50),
                              //   //               //                                           border:
                              //   //               //                                               Border.all(color: gradient1)

                              //   //               //                                           // color: gradient1,

                              //   //               //                                           ),
                              //   //               //                                       child: Center(
                              //   //               //                                           child: Text(
                              //   //               //                                         "4",
                              //   //               //                                         style: TextStyle(
                              //   //               //                                             fontWeight: FontWeight.w500),
                              //   //               //                                       ))),
                              //   //               //                                   SizedBox(
                              //   //               //                                     width: 10,
                              //   //               //                                   ),
                              //   //               //                                   Container(
                              //   //               //                                     width: 25,
                              //   //               //                                     height: 25,
                              //   //               //                                     decoration: BoxDecoration(
                              //   //               //                                       shape: BoxShape.circle,
                              //   //               //                                       gradient: LinearGradient(begin: Alignment.centerLeft,
                              //   //               // end: Alignment.centerRight,
                              //   //               // colors: [
                              //   //               //   gradient2,gradient1
                              //   //               // ]),

                              //   //               //                                     ),
                              //   //               //                                     child: Icon(
                              //   //               //                                       Icons.add,size: 15,
                              //   //               //                                       color: Colors.white,
                              //   //               //                                     ),
                              //   //               //                                   ),
                              //   //               //                                 ],
                              //   //               //                               )
                              //   //             ],
                              //   //           )
                              //   //         ])),
                              //   // SizedBox(
                              //   //   height: 10,
                              //   // ),
                              //   // Image.asset("assets/image/divider.png"),
                              //   // SizedBox(
                              //   //   height: 10,
                              //   // ),
                              //   // Container(
                              //   //     decoration: BoxDecoration(
                              //   //         color: white,
                              //   //         borderRadius: BorderRadius.circular(30)),
                              //   //     child: Row(
                              //   //         crossAxisAlignment: CrossAxisAlignment.center,
                              //   //         children: [
                              //   //           Container(
                              //   //             height:
                              //   //                 MediaQuery.of(context).size.height *
                              //   //                     0.2,
                              //   //             width: MediaQuery.of(context).size.width *
                              //   //                 0.3,
                              //   //             decoration: BoxDecoration(
                              //   //                 color: white,
                              //   //                 borderRadius:
                              //   //                     BorderRadius.circular(30)),
                              //   //             child: Padding(
                              //   //               padding: const EdgeInsets.all(15.0),
                              //   //               child: Image.asset(
                              //   //                 "assets/image/kangan9.png",
                              //   //                 height: 100,
                              //   //               ),
                              //   //             ),
                              //   //           ),
                              //   //           SizedBox(
                              //   //             width: MediaQuery.of(context).size.width *
                              //   //                 0.08,
                              //   //           ),
                              //   //           Column(
                              //   //             crossAxisAlignment:
                              //   //                 CrossAxisAlignment.start,
                              //   //             children: [
                              //   //               Text(
                              //   //                 "Gold Bangle",
                              //   //                 style: TextStyle(
                              //   //                     fontSize: 16,
                              //   //                     fontFamily: "SF-Pro-Display",
                              //   //                     fontWeight: FontWeight.w500),
                              //   //               ),
                              //   //               SizedBox(
                              //   //                 height: 5,
                              //   //               ),

                              //   //               Text(
                              //   //                 "Weight 10gms",
                              //   //                 style: TextStyle(
                              //   //                     fontSize: 14,
                              //   //                     fontFamily: "SF-Pro-Display",
                              //   //                     fontWeight: FontWeight.w400),
                              //   //               ),
                              //   //               SizedBox(
                              //   //                 height: 5,
                              //   //               ),

                              //   //               Row(
                              //   //                 children: [
                              //   //                   Text(
                              //   //                     "Size : 2.5 ",
                              //   //                     style: TextStyle(
                              //   //                         fontSize: 14,
                              //   //                         fontFamily: "SF-Pro-Display",
                              //   //                         fontWeight: FontWeight.w400),
                              //   //                   ),
                              //   //                   SizedBox(width: 10),
                              //   //                   Text(
                              //   //                     "Quantity : 4",
                              //   //                     style: TextStyle(
                              //   //                         fontSize: 14,
                              //   //                         fontFamily: "SF-Pro-Display",
                              //   //                         fontWeight: FontWeight.w400),
                              //   //                   ),
                              //   //                 ],
                              //   //               ),
                              //   //               SizedBox(
                              //   //                 height: 5,
                              //   //               ),
                              //   //               //               Row(
                              //   //               //                                 children: [
                              //   //               //                                   Container(
                              //   //               //                                     width: 25,
                              //   //               //                                     height: 25,
                              //   //               //                                     decoration: BoxDecoration(
                              //   //               //                                       shape: BoxShape.circle,
                              //   //               //                                      // color: gradient1,
                              //   //               // gradient: LinearGradient(begin: Alignment.centerLeft,
                              //   //               // end: Alignment.centerRight,
                              //   //               // colors: [
                              //   //               //   gradient2,gradient1
                              //   //               // ])
                              //   //               //                                     ),
                              //   //               //                                     child: Center(
                              //   //               //                                       child:Text("-",style: TextStyle(color: white,fontSize: 18),)
                              //   //               //                                       //  Icon(
                              //   //               //                                       //   Icons.minimize,
                              //   //               //                                       //   size: 8,
                              //   //               //                                       //   color: Colors.white,
                              //   //               //                                       // ),
                              //   //               //                                     ),
                              //   //               //                                   ),
                              //   //               //                                   SizedBox(
                              //   //               //                                     width: 10,
                              //   //               //                                   ),
                              //   //               //                                   Container(
                              //   //               //                                       width: 60,
                              //   //               //                                        height: 30,
                              //   //               //                                       decoration: BoxDecoration(

                              //   //               //                                           // shape: BoxShape.circle,

                              //   //               //                                           borderRadius:
                              //   //               //                                               BorderRadius.circular(50),
                              //   //               //                                           border:
                              //   //               //                                               Border.all(color: gradient1)

                              //   //               //                                           // color: gradient1,

                              //   //               //                                           ),
                              //   //               //                                       child: Center(
                              //   //               //                                           child: Text(
                              //   //               //                                         "4",
                              //   //               //                                         style: TextStyle(
                              //   //               //                                             fontWeight: FontWeight.w500),
                              //   //               //                                       ))),
                              //   //               //                                   SizedBox(
                              //   //               //                                     width: 10,
                              //   //               //                                   ),
                              //   //               //                                   Container(
                              //   //               //                                     width: 25,
                              //   //               //                                     height: 25,
                              //   //               //                                     decoration: BoxDecoration(
                              //   //               //                                       shape: BoxShape.circle,
                              //   //               //                                       gradient: LinearGradient(begin: Alignment.centerLeft,
                              //   //               // end: Alignment.centerRight,
                              //   //               // colors: [
                              //   //               //   gradient2,gradient1
                              //   //               // ]),

                              //   //               //                                     ),
                              //   //               //                                     child: Icon(
                              //   //               //                                       Icons.add,size: 15,
                              //   //               //                                       color: Colors.white,
                              //   //               //                                     ),
                              //   //               //                                   ),
                              //   //               //                                 ],
                              //   //               //                               )
                              //   //             ],
                              //   //           )
                              //   //         ])),

                              //   //             Container(
                              //   //               height: MediaQuery.of(context).size.height*0.08,
                              //   //               width: MediaQuery.of(context).size.width*04,
                              //   //      decoration: BoxDecoration(
                              //   //        borderRadius: BorderRadius.circular(30),

                              //   //        gradient: LinearGradient(
                              //   //         begin: Alignment.centerLeft,
                              //   // end: Alignment.centerRight,
                              //   // colors:
                              //   //            [
                              //   //                gradient2,
                              //   //              gradient1,

                              //   //          ],)
                              //   //      ),

                              //   //      child: Center(child:  Text('Order',style: TextStyle(color:white,fontSize: 16,fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500),)),
                              //   //     //   child: ElevatedButton(

                              //   //     //         onPressed: () {

                              //   //     //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>CartDetails()));
                              //   //     //         },
                              //   //     //         // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                              //   //     //         style: ElevatedButton.styleFrom(
                              //   //     //           backgroundColor: Colors.transparent,
                              //   //     //             elevation: 10.0,
                              //   //     //                shape:  RoundedRectangleBorder(
                              //   //     //     borderRadius: BorderRadius.all(Radius.circular(25)),
                              //   //     //     ),
                              //   //     // minimumSize: Size(300, 45),

                              //   //     //             textStyle:  TextStyle( color:Colors.white)),
                              //   //     //         child:  Text('Order',style: TextStyle(fontSize: 14,fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500),),
                              //   //     //       ),

                              //   //                  ),
                              // ],
                            ),
                    ),
                  )),
            ],
          ),
        ));
  }
}
