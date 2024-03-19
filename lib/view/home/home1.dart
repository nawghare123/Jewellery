import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jewellery/view/Login/LoginModel.dart';
import 'package:jewellery/view/blogModel.dart';
import 'package:jewellery/view/drawer.dart';
import 'package:jewellery/view/getCartModel.dart';
import 'package:jewellery/view/home/blogDetailsPage.dart';
import 'package:jewellery/view/home/blogsPage.dart';
import 'package:jewellery/view/home/homeController.dart';
import 'package:jewellery/view/home/notificationModel.dart';
import 'package:jewellery/view/home/productDetailsController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/CustomOrder.dart';
import 'package:jewellery/view/Mycart.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/catalogue.dart';
import 'package:jewellery/view/countjewellery.dart';
import 'package:jewellery/view/customDotIndicator.dart';
import 'package:jewellery/view/home/BannerModel.dart';
import 'package:jewellery/view/home/Ourbranddetails.dart';
import 'package:jewellery/view/home/brandModel.dart';
import 'package:jewellery/view/home/categoriesModel.dart';
import 'package:jewellery/view/home/latestModel.dart';
import 'package:http/http.dart' as http;
import 'package:jewellery/view/jewellerypage.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Home1 extends StatefulWidget {
  Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  int _currentIndex = 0;
  LatestModel? latestModel;
  BrandModel? brandmodel;
  BannerModel? bannermodel;
  BlogModel? blogModel;
  NotificationModel? notificationModel;
GetCardModel? getCardModel;
  CategoryModel? categorymodel;
    String? userId;
  int? tappedIndex = 0;
  int? brandid;
   List itemTotal = [];
  int? selectedIndex;
  bool isloading = false;
  bool isselected = false;
  int? countitem = 0;
  bool showPop = false;
 int totalAmount = 0;
  int totalQuantity = 0;
  late VideoPlayerController _videoController;
     int itemCount = 0;
  //  List<Map<String, dynamic>>? imageData;
  final List<String> _images = [
    // 'assets/image/slideimg1.png',
    // 'assets/image/slideimg.png',
    // 'assets/image/slideimg4.png',
  ];
  // final Set<BrandModel> apiResponse = {
  //   BrandModel()
  // };
  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    brandlist();
    latestlist();
    bannerlist();
    blogList();
    getNotifications();
    getCartList();
//  categorylist();
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

  void showVerificationDialog(BuildContext context) {
    // if (!showPop) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verification Request'),
          content: Text('You are not verified.'),
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
  }

  MyHomeController myHomeController = Get.put(MyHomeController());
  Future<void> getCartList() async {
    try {
      getCardModel = await ApiHelper.getCartList();
      getCardModel!.data!.forEach((e) {
        int thisVar = 0;
        List<Map<String, dynamic>>.from(json.decode(e.variant!
                .toString()
                .replaceAllMapped(
                    RegExp(r'(\w+):'), (match) => '"${match.group(1)}":')))
            .forEach((e) {
          // print("====>>>> $e");
          int quantity = parseQuantity(e);
          // print("=====>>>> $quantity"); // Output: 3
          // thisVar = e["price"] * e["quantity"];

          // thisVar = e["price"] * e["quantity"];

          setState(() {
            totalQuantity += quantity;
          });
          // print("====>>>> quantity: ${totalQuantity}");
          // print(e["quantity"]);
        });

        // totalAmount += thisVar;
        itemTotal.add([e.productName, thisVar]);
      });
    } catch (e) {}
    setState(() {
      isloading = false;
    });
    // print("====>>>> Last quantity: ${totalQuantity}");
  }
int parseQuantity(Map<String, dynamic> data) {
    if (data.containsKey('quantity')) {
      dynamic quantityValue = data['quantity'];
      if (quantityValue is int) {
        return quantityValue;
      } else if (quantityValue is String) {
        return int.tryParse(quantityValue) ?? 0;
      }
    }
    return 0; 
  }
  Future<void> showPopup(BuildContext context) async {
    setState(() {
      showPop = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = await prefs.getInt('id') ?? 0;
    var request = http.Request('GET',
        Uri.parse('https://veejayjewels.com/api/v1/customer/info?id=${id}'));

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    var b = jsonDecode(res);
    LoginModel? loginModel;
    loginModel = LoginModel.fromJson(b);
    if (response.statusCode == 200) {
      if (loginModel.data!.status == "unverified") {
        showVerificationDialog(context);
        myHomeController.updateVerification(false);
      }
    } else {
      myHomeController.updateVerification(true);
      print(response.reasonPhrase);
    }
  }

  void getNotifications() async {
    notificationModel = await ApiHelper.getNotifications();
  }

  void latestlist() async {
    latestModel = await ApiHelper.latestclass();

    setState(() {
      isloading = false;
    });
  }

  void blogList() async {
    blogModel = await ApiHelper.getBlogs();
  }

  void bannerlist() async {
    bannermodel = await ApiHelper.bannerclass();
    // bannermodel!.data!.forEach((element) {
    //   // print("banner ======>>>>> ${element.image}");
    // });
    String url =
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
    for (int i = 0; i < bannermodel!.data!.length; i++) {
      if (bannermodel!.data![i].type == "video") {
        // print("====>>>> Video found ${bannermodel!.data![i].image!}");
        url = bannermodel!.data![i].image!;
        //   break;
      }
    }
    setState(() {});
    print("=====>>>>> ${url}");

    _videoController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    setState(() {
      isloading = false;
    });
  }

  void brandlist() async {
    brandmodel = await ApiHelper.brandclass();
// brandmodel = BrandModel.fromJson(abc);
    print("brand");
    // print(brandmodel.data.);
    // brandmodel!.data!.forEach((element) {
    //   print("Banner Image =====>>> ${element.image}");
    // });
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!showPop) showPopup(context);
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  "assets/image/menu2.png",
                ),
              ),
            );
          },
        ),
        title: Center(
//SvgPicture.asset("assets/image/menu1.svg",height: 25,),
//
          child: GradientText(
            'Veejay Jewels',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
                fontFamily: "Alhadara-DEMO"),
            gradientType: GradientType.radial,
            radius: 2.5,
            colors: [gradient1, gradient2],
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: Colors.transparent,
                    actions: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: gradient1,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.08,

                              // height: 50,

                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Center(
                                  child: Text(
                                    "Notifications",
                                    style: TextStyle(
                                        fontFamily: "Alhadara-DEMO",
                                        color: white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                // Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceAround,
                                //     children: [
                                //       // Text(
                                //       //   "Size",
                                //       //   style: TextStyle(
                                //       //       color: white,
                                //       //       fontSize: 16,
                                //       //       fontWeight: FontWeight.w500),
                                //       // ),
                                //       // SizedBox(
                                //       //   width: 15,
                                //       // ),
                                //       // Text(
                                //       //   "Notifictions",
                                //       //   style: TextStyle(
                                //       //       color: white,
                                //       //       fontSize: 16,
                                //       //       fontWeight: FontWeight.w500),
                                //       // ),
                                //       // Row(
                                //       //   children: [
                                //       //     Text(
                                //       //       "Notifictions",
                                //       //       style: TextStyle(
                                //       //           color: white,
                                //       //           fontSize: 16,
                                //       //           fontWeight: FontWeight.w500),
                                //       //     ),
                                //       //     SizedBox(
                                //       //       width: 10,
                                //       //     ),
                                //       //     InkWell(
                                //       //         onTap: () {},
                                //       //         child: Icon(Icons.arrow_drop_down,
                                //       //             color: white))
                                //       //   ],
                                //       // )
                                //     ]),
                              ),
                            ),
                            notificationModel == null
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      decoration: BoxDecoration(
                                          // color: white,

                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/image/product_bg_image.png'),
                                            fit: BoxFit
                                                .fill, // Adjust the fit as per your requirement
                                          ),
                                          border: Border.all(
                                              color: gradient1, width: 0.3),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView(
                                          children:
                                              notificationModel!.data!.map(
                                            (e) {
                                              return e.status! == 0
                                                  ? SizedBox()
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          CachedNetworkImage(
                                                            imageUrl:
                                                                "https://veejayjewels.com/storage/app/public/notification/${e.image!}",
                                                            progressIndicatorBuilder: (context,
                                                                    url,
                                                                    downloadProgress) =>
                                                                CircularProgressIndicator(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade700,
                                                                    value: downloadProgress
                                                                        .progress),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      e.title!,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18))),
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(e
                                                                      .description!)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 17,
                      ),
                      Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.black,
                        size: 23,
                      ),
                    ],
                  ),
                  (notificationModel!.data!.isEmpty)?
SizedBox():
                  Positioned(
                    top: 10,
                    right: 0,
                    child:
                        // Text(
                        //   notificationModel!.data!.length.toString(),
                        //   style: TextStyle(color: Colors.black),
                        // ),
                        Stack(
                      children: <Widget>[
                        Icon(Icons.brightness_1,
                            size: 15.0, color: Colors.green[800]),
                        Positioned(
                            top: 3.0,
                            right: 5.0,
                            child: Center(
                              child: Text((notificationModel!.data!.length??'').toString(),
                                // (notificationModel!.data!.length??'').toString(),
                                // list.length.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              )
              //  Image.asset("assets/image/notification.png",color:Colors.black),
              //SvgPicture.asset("assets/image/notification.svg"),
              ),
          // Image.asset("assets/image/cartimg.png"),
         // Image.asset("assets/image/cartimg.png"),
          SizedBox(width: 10),


          
          Stack(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyCart()),
                    );
                  },
                  child: Center(child: SvgPicture.asset("assets/image/Buy.svg",height: 23,))),
 
// (getCardModel!.data!.isEmpty)?
// SizedBox():
 Positioned(
 top: 10.0,
                    child:  Stack(
                      children: <Widget>[
                         Icon(
                            Icons.brightness_1,
                            size: 15.0, color: Colors.green[800]),
                         Positioned(
                            top: 3.0,
                            right: 4.0,
                            child:  Center(
                              child:  Text(( getCardModel!.data!.length??'').toString(),
                                // list.length.toString(),
                                style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            )),

                  
                      ],
                    )),


            ],
          ),

          SizedBox(width: 10),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      backgroundColor: bgcolor,
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: latestModel == null
                  ? SizedBox()
                  : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/image/product_bg_image.png'),
                          fit: BoxFit
                              .cover, // Adjust the fit as per your requirement
                        ),
                        // color: bgcolor,
                        // borderRadius: BorderRadius.only(
                        //   topRight: Radius.circular(30),
                        // ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),

                          // slider
                          bannermodel == null
                              ? SizedBox()
                              : CarouselSlider(
                                  items:
                                      // [
                                      bannermodel!.data!
                                          .where((element) => (element.type ==
                                                  "first" &&
                                              !element.image!.endsWith("mp4")))
                                          .map((e) {
                                    return Image.network(e.image ?? "");
                                  }).toList(),
                                  // Image.asset("assets/image/slideimg1.png"),
                                  // Image.asset("assets/image/slideimg1.png"),
                                  // Image.asset("assets/image/slideimg1.png"),
                                  // ],
                                  options: CarouselOptions(
                                    height: 150,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    enlargeFactor: 0.3,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                  ),
                                ),
                          bannermodel == null
                              ? SizedBox()
                              : CustomDotIndicator(
                                  currentIndex: _currentIndex,
                                  itemCount: bannermodel!.data!
                                      .where(
                                          (element) => element.type == "first")
                                      .length,
                                ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15,
                                      top: 10,
                                      bottom: 10),
                                  child: Text(
                                    "Our Brand",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "SF-Pro-Display",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),

                                Column(
                                  children: [
                                    !isloading
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10,
                                                bottom: 10),
                                            child: Container(
                                              height: 100.0,
                                              child: ListView.builder(
                                                physics:
                                                    ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    brandmodel!.data!.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => OurBrandDetails(
                                                                id: brandmodel!
                                                                        .data![
                                                                            index]
                                                                        .id ??
                                                                    0,
                                                                name: brandmodel!
                                                                    .data![
                                                                        index]
                                                                    .name)));

                                                    setState(() {
                                                      //selectedIndex = index;
                                                      //  print("==="+ selectedIndex.toString());
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Container(
 width: 150,
                                                            height: 120,
                                                        decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                                      gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topCenter, // Start from the top
                                                            end: Alignment
                                                                .bottomCenter, // End at the bottom
                                                            colors: [
                                                              cardgradient1,
                                                              cardgradient2,
                                                            ],
                                                          ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              // boxShadow: [
                                                              //   BoxShadow(
                                                              //     color: Colors
                                                              //         .grey
                                                              //         .withOpacity(
                                                              //             0.5),
                                                              //     spreadRadius: 2,
                                                              //     blurRadius: 5,
                                                              //     offset: Offset(
                                                              //         0, 3),
                                                              //   ),
                                                              // ],
                                                            ),
                                                           
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Column(
                                                          children: [
                                                            // Container(
                                                            //   decoration:
                                                            //       BoxDecoration(
                                                            //     shape:
                                                            //         BoxShape.circle,
                                                            //     boxShadow: [
                                                            //       BoxShadow(
                                                            //         color: Colors
                                                            //             .grey
                                                            //             .withOpacity(
                                                            //                 0.5),
                                                            //         spreadRadius: 2,
                                                            //         blurRadius: 5,
                                                            //         offset: Offset(
                                                            //             0,
                                                            //             3), // controls the position of the shadow
                                                            //       ),
                                                            //     ],
                                                            //   ),
                                                            //   child: CircleAvatar(
                                                            //     backgroundColor:
                                                            //         brandcolor,
                                                            //     radius: 35,
                                                            //     backgroundImage:
                                                            //         CachedNetworkImageProvider(
                                                            //       (brandmodel!
                                                            //                   .data![
                                                            //                       index]
                                                            //                   .image ??
                                                            //               '')
                                                            //           .toString(),
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                            Container(
                                                              width: 70,
                                                              height: 70,
                                                            //   decoration:
                                                            //       BoxDecoration(
                                                            //     shape: BoxShape
                                                            //         .rectangle,
                                                            //             gradient:
                                                            //     LinearGradient(
                                                            //   begin: Alignment
                                                            //       .topCenter, // Start from the top
                                                            //   end: Alignment
                                                            //       .bottomCenter, // End at the bottom
                                                            //   colors: [
                                                            //     cardgradient1,
                                                            //     cardgradient2,
                                                            //   ],
                                                            // ),
                                                            //     borderRadius:
                                                            //         BorderRadius
                                                            //             .circular(
                                                            //                 20),
                                                            //     boxShadow: [
                                                            //       BoxShadow(
                                                            //         color: Colors
                                                            //             .grey
                                                            //             .withOpacity(
                                                            //                 0.5),
                                                            //         spreadRadius: 2,
                                                            //         blurRadius: 5,
                                                            //         offset: Offset(
                                                            //             0, 3),
                                                            //       ),
                                                            //     ],
                                                            //   ),
                                                              
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: brandmodel!
                                                                          .data![
                                                                              index]
                                                                          .image ??
                                                                      '',
                                                                  // fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                            ),
                                                                                                          
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape:
                                                                    BoxShape.circle,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.3),
                                                                    spreadRadius: 1,
                                                                    blurRadius: 3,
                                                                    offset: Offset(
                                                                        0,
                                                                        3), // controls the position of the shadow
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Text((brandmodel!
                                                                          .data![
                                                                              index]
                                                                          .name ??
                                                                      '')
                                                                  .toString()),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Trending",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "SF-Pro-Display",
                                            fontWeight: FontWeight.w600),
                                      ),

                                      // Text("See All", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),

                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      jewellerypage(
                                                        latestModel:
                                                            latestModel!.data!
                                                        // .where((element) =>
                                                        //     element.productType ==
                                                        //     "child")
                                                        // .toList()
                                                        ,
                                                        // type:"public"
                                                      )));
                                        },
                                        child: GradientText(
                                          'See All',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500),
                                          gradientType: GradientType.radial,
                                          radius: 2.5,
                                          colors: [
                                            gradient2,
                                            gradient1,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // !isloading?
                                Container(
                                    // height: MediaQuery.of(context).size.height *
                                    //     0.62,
                                   height: 535,
                                    decoration: BoxDecoration(
                                        // color: bgcolor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: latestModel!.data!.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 15,
                                                mainAxisSpacing: 15,
                                                mainAxisExtent: 245),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // if(latestModel!.data!.length < 4){

                                          // latestModel!.data!.length;

                                          //    } else{
                                          //     latestModel!.data!.length -1;
                                          //     latestModel!.data!.length-2;
                                          //     latestModel!.data!.length-3;
                                          //     latestModel!.data!.length-4;
                                          //    }

                                          return !isloading
                                              ? GestureDetector(
                                                  onTap: () async {
                                                    // if (!myHomeController
                                                    //     .isVerified) {
                                                    //   Get.snackbar(
                                                    //     'Verification Required',
                                                    //     'Please verify first',
                                                    //     snackPosition:
                                                    //         SnackPosition
                                                    //             .BOTTOM,
                                                    //     backgroundColor:
                                                    //         Colors.red,
                                                    //     colorText: Colors.white,
                                                    //   );
                                                    //   return;
                                                    // }
                                                    print(
                                                        "===>>>> verified ${myHomeController.isVerified}");
                                                    ProductDetailsController
                                                        productDetailsController =
                                                        Get.put(
                                                            ProductDetailsController());
                                                 
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CountJeweller(
                                                                  productid: latestModel!
                                                                          .data![
                                                                              index]
                                                                          .id ??
                                                                      0,
                                                                )));
                                                                   await productDetailsController
                                                        .updateProductId(
                                                            latestModel!
                                                                .data![index]
                                                                .id);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .topCenter, // Start from the top
                                                          end: Alignment
                                                              .bottomCenter, // End at the bottom
                                                          colors: [
                                                            cardgradient1,
                                                            cardgradient2,
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: white),
                                                    child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [

                                                              GestureDetector(
                                                          onTap: () async {
                                                            var productId =
                                                                latestModel!
                                                                    .data![
                                                                        index]
                                                                    .id!;
                                                            final SharedPreferences
                                                                prefs =
                                                                await SharedPreferences
                                                                    .getInstance();

                                                            userId = await prefs
                                                                .getInt('id')
                                                                .toString();
                                                            print({
                                                              "User Id": userId,
                                                              "product Id":
                                                                  productId,
                                                            });
                                                            try {
                                                              String res = await ApiHelper
                                                                  .addToWishList(
                                                                      userId,
                                                                      productId
                                                                          .toString());
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Success'),
                                                                    content:
                                                                        Text(
                                                                            res),
                                                                    actions: <
                                                                        Widget>[
                                                                      TextButton(
                                                                        child:
                                                                            Text(
                                                                          'OK',
                                                                          style:
                                                                              TextStyle(color: gradient1),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop(); // Close the dialog
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            } catch (e) {}
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Image.asset(
                                                                "assets/image/like.png"),
                                                          ),
                                                        ),
                                                        
                                                        // ClipOval(
                                                        // child:
                                                        Column(crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            SizedBox.fromSize(
                                                              size: Size.fromRadius(
                                                                  50), // Image radius
                                                              child:
                                                                  //  Image.network(
                                                                  //     (latestModel!
                                                                  //                 .data![
                                                                  //                     index]
                                                                  //                 .image ??
                                                                  //             '')
                                                                  //         .toString())
                                                                  CachedNetworkImage(
                                                                imageUrl: (latestModel!
                                                                            .data![
                                                                                index]
                                                                            .image ??
                                                                        '')
                                                                    .toString()
                                                                    .replaceAll(
                                                                        '"]', "")
                                                                    .replaceAll(
                                                                        '["', ""),
                                                                progressIndicatorBuilder: (context,
                                                                        url,
                                                                        downloadProgress) =>
                                                                    CircularProgressIndicator(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade700,
                                                                        value: downloadProgress
                                                                            .progress),
                                                                errorWidget:
                                                                    (context, url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error),
                                                              ),
                                                              //  (latestModel!.data![index].image != null )
                                                              //      ?Image.network( (latestModel!.data![index].image??'').replaceFirst("/", "").toString())
                                                              //      :Image.asset("assets/image/goldbangle.png",
                                                              //             ),

                                                              // Image.network( (latestModel!.data![index].image??'').replaceFirst("\"" , "").toString())
                                                            ),
                                                            // ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              (latestModel!
                                                                              .data![
                                                                                  index]
                                                                              .name!
                                                                              .length <
                                                                          12
                                                                      ? latestModel!
                                                                          .data![
                                                                              index]
                                                                          .name
                                                                      : latestModel!
                                                                                  .data![index]
                                                                                  .name!
                                                                                  .substring(0, 12) +
                                                                              "..." ??
                                                                          '')
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  (latestModel!
                                                                          .data![
                                                                              index]
                                                                          .unitValue)
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color:
                                                                          gradient1),
                                                                ),
                                                                Text(
                                                                  (latestModel!
                                                                          .data![
                                                                              index]
                                                                          .unit)
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color:
                                                                          gradient1),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),

                                                     
                                                            InkWell(
                                                              onTap: () async {
                                                                // ProductDetailsController
                                                                //     productDetailsController =
                                                                //     Get.put(
                                                                //         ProductDetailsController());
                                                                // await productDetailsController
                                                                //     .updateProductId(
                                                                //         latestModel!
                                                                //             .data![
                                                                //                 index]
                                                                //             .id);
                                                                // Navigator.push(
                                                                //     context,
                                                                //     MaterialPageRoute(
                                                                //         builder:
                                                                //             (context) =>
                                                                //                 CountJeweller(
                                                                //                   productid:
                                                                //                       latestModel!.data![index].id ?? 0,
                                                                //                 )));
                                                              },
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.05,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.3,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              25),
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      gradient2,
                                                                      gradient1,
                                                                    ],
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(8.0),
                                                                  child: Center(
                                                                    child: Text(
                                                                      'View Product',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              white,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    
                                                    
                                                    
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : SizedBox();
                                        },
                                      ),
                                    ))
                                //  :SizedBox()

                                ,
                                SizedBox(
                                  height: 5,
                                ),

                                // Padding(
                                //  padding: const EdgeInsets.only(left:15.0,right: 15,top: 10,bottom: 10),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text(
                                //         "Catalogue",
                                //         style:
                                //             TextStyle(fontSize: 16, fontFamily: "SF-Pro-Display", fontWeight: FontWeight.w600),
                                //       ),

                                //       // Text("See All", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),

                                //       GradientText(
                                //         'See All',
                                //         style: TextStyle(
                                //             fontSize: 16.0, fontWeight: FontWeight.w500),
                                //         gradientType: GradientType.radial,
                                //         radius: 2.5,
                                //         colors: [
                                //           gradient2,
                                //           gradient1,
                                //         ],
                                //       ),
                                //     ],
                                //   ),
                                // ),

                                //  Padding(
                                //             padding: const EdgeInsets.only(left:15.0,right: 15,top: 10,bottom: 10),
                                //             child: Text(
                                //               "Live Rate",
                                //               style: TextStyle(fontSize: 16,fontFamily: "SF-Pro-Display", fontWeight: FontWeight.w600),
                                //             ),
                                //           ),
                                bannermodel == null
                                    ? SizedBox()
                                    : CarouselSlider(
                                        items:
                                            // [
                                            bannermodel!.data!
                                                .where((element) =>
                                                    element.type == "second")
                                                .map((e) {
                                          // print("======>>>> Second Slider : ${e.type}");
                                          return Stack(
                                            children: [
                                              CachedNetworkImage(
                                                // height: 35,
                                                imageUrl: (e.image ?? '')
                                                    // .replaceFirst(
                                                    //     "\"", "")
                                                    .toString(),
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            color: Colors
                                                                .grey.shade700,
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                              Positioned(
                                                right: 36,
                                                top: 26,
                                                child: GradientText(
                                                  'Rs.59,000',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 20.0,
                                                      fontFamily:
                                                          "Alhadara-DEMO"),
                                                  gradientType:
                                                      GradientType.radial,
                                                  radius: 2.5,
                                                  colors: [
                                                    darkgradient1,
                                                    darkgradient2,
                                                    darkgradient3
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                        options: CarouselOptions(
                                          height: 150,
                                          aspectRatio: 16 / 9,
                                          viewportFraction: 1,
                                          initialPage: 0,
                                          enableInfiniteScroll: true,
                                          reverse: false,
                                          autoPlay: true,
                                          autoPlayInterval:
                                              Duration(seconds: 3),
                                          autoPlayAnimationDuration:
                                              Duration(milliseconds: 800),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          enlargeCenterPage: true,
                                          enlargeFactor: 0.3,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _currentIndex = index;
                                            });
                                          },
                                        ),
                                      ),
                                // Positioned(right: 50,top:35,child: Text("Gold",style: TextStyle(color: white),)),

                                CustomDotIndicator(
                                  currentIndex: _currentIndex,
                                  itemCount: bannermodel!.data!
                                      .where(
                                          (element) => element.type == "second")
                                      .length,
                                ),

                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),

                                Container(
                                  color: white,
                                  height: 35,
                                  child: ScrollLoopAutoScroll(
                                      child: GradientText(
                                        'Current Price Rs.45,000',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500),
                                        gradientType: GradientType.radial,
                                        radius: 2.5,
                                        colors: [
                                          gradient2,
                                          gradient1,
                                        ],
                                      ),

                                      //required
                                      scrollDirection:
                                          Axis.horizontal, //required
                                      delay: Duration(seconds: 1),
                                      duration: Duration(seconds: 40),
                                      gap: 30,
                                      reverseScroll: false,
                                      duplicateChild: 25,
                                      enableScrollInput: true,
                                      delayAfterScrollInput:
                                          Duration(milliseconds: 800)),
                                ),

                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),

                                //   Row(

                                //   mainAxisAlignment: MainAxisAlignment.center,

                                //   children: _images.map((image) {

                                //     int index = _images.indexOf(image);

                                //     return Container(

                                //       width: 8.0,

                                //       height: 8.0,

                                //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),

                                //       decoration: BoxDecoration(

                                //         shape: BoxShape.circle,

                                //         color: _currentIndex == index ? gradient1: Colors.grey,

                                //       ),

                                //     );

                                //   }).toList(),

                                // ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15,
                                      top: 10,
                                      bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Blog",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "SF-Pro-Display",
                                            fontWeight: FontWeight.w600),
                                      ),

                                      // Text("See All", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),

                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => BlogsPage(
                                                      // latestModel:
                                                      //     latestModel!.data!
                                                      // .where((element) =>
                                                      //     element.productType ==
                                                      //     "child")
                                                      // .toList()
                                                      // ,
                                                      // type:"public"
                                                      )));
                                        },
                                        child: GradientText(
                                          'See All',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500),
                                          gradientType: GradientType.radial,
                                          radius: 2.5,
                                          colors: [
                                            gradient2,
                                            gradient1,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: blogModel != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              right: 10,
                                              top: 10,
                                              bottom: 10),
                                          child: Row(
                                            children:
                                                blogModel!.data!.length < 4
                                                    ? blogModel!.data!
                                                        .map(
                                                          (e) =>
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          BlogDetailsPage(
                                                                            author:
                                                                                e.author,
                                                                            banner:
                                                                                "https://veejayjewels.com/storage/app/public/banner/${e.banner}",
                                                                            desc:
                                                                                e.description,
                                                                            image:
                                                                                "https://veejayjewels.com/storage/app/public/banner/${e.image}",
                                                                            title:
                                                                                e.title,
                                                                          )));
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10.0),
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.2,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.5,
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    // Image.asset(
                                                                    //     "assets/image/img2.png"),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.5,
                                                                        height:
                                                                            80,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          color:
                                                                              white,
                                                                        ),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight:
                                                                                Radius.circular(10),
                                                                          ),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                "https://veejayjewels.com/storage/app/public/banner/${e.image!}",
                                                                            imageBuilder: (context, imageProvider) =>
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                                  image: imageProvider,
                                                                                  fit: BoxFit.fitWidth, // Adjust the fit property as needed
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                                                CircularProgressIndicator(
                                                                              color: Colors.grey.shade700,
                                                                              value: downloadProgress.progress,
                                                                            ),
                                                                            errorWidget: (context, url, error) =>
                                                                                Icon(Icons.error),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        e.title!.length <
                                                                                20
                                                                            ? e.title!
                                                                            : "${e.title!.substring(0, 18)}...",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: black),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        e.description!.length <
                                                                                20
                                                                            ? e.description!
                                                                            : "${e.description!.substring(0, 18)}...",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w400,
                                                                            color:
                                                                                hintcolor,
                                                                            fontSize:
                                                                                11),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                        .toList()
                                                    : blogModel!.data!
                                                        .take(3)
                                                        .map(
                                                          (e) =>
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          BlogDetailsPage(
                                                                            author:
                                                                                e.author,
                                                                            banner:
                                                                                "https://veejayjewels.com/storage/app/public/banner/${e.banner}",
                                                                            desc:
                                                                                e.description,
                                                                            image:
                                                                                "https://veejayjewels.com/storage/app/public/banner/${e.image}",
                                                                            title:
                                                                                e.title,
                                                                          )));
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10.0),
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.2,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.5,
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30)),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    // Image.asset(
                                                                    //     "assets/image/img2.png"),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.5,
                                                                        height:
                                                                            80,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(30),
                                                                          color:
                                                                              white,
                                                                        ),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(30),
                                                                            topRight:
                                                                                Radius.circular(30),
                                                                          ),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                "https://veejayjewels.com/storage/app/public/banner/${e.image!}",
                                                                            imageBuilder: (context, imageProvider) =>
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                                  image: imageProvider,
                                                                                  fit: BoxFit.fitWidth, // Adjust the fit property as needed
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                                                CircularProgressIndicator(
                                                                              color: Colors.grey.shade700,
                                                                              value: downloadProgress.progress,
                                                                            ),
                                                                            errorWidget: (context, url, error) =>
                                                                                Icon(Icons.error),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        e.title!.length <
                                                                                20
                                                                            ? e.title!
                                                                            : "${e.title!.substring(0, 18)}...",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: black),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        e.description!.length <
                                                                                20
                                                                            ? e.description!
                                                                            : "${e.description!.substring(0, 18)}...",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w400,
                                                                            color:
                                                                                hintcolor,
                                                                            fontSize:
                                                                                11),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                          ),
                                        )
                                      : SizedBox(),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Catalogue",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "SF-Pro-Display",
                                            fontWeight: FontWeight.w600),
                                      ),

                                      // Text("See All", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),

                                      // GradientText(
                                      //   'See All',
                                      //   style: TextStyle(
                                      //       fontSize: 16.0,
                                      //       fontWeight: FontWeight.w500),
                                      //   gradientType: GradientType.radial,
                                      //   radius: 2.5,
                                      //   colors: [
                                      //     gradient2,
                                      //     gradient1,
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),

                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Catalogue(
                                                          type: "women",
                                                        )));
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: white),
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: white),
                                                  child: Image.asset(
                                                    "assets/image/women.png",
                                                    height: 150,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GradientText(
                                                      'Women',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18.0,
                                                          fontFamily:
                                                              "Alhadara-DEMO"),
                                                      gradientType:
                                                          GradientType.linear,
                                                      radius: 2.5,
                                                      colors: [
                                                        gradient2,
                                                        gradient1
                                                      ],
                                                    ),
                                                    Text(
                                                      "Explore More >",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Catalogue(
                                                          type: "men",
                                                        )));
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: white),
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: white),
                                                  child: Image.asset(
                                                    "assets/image/men.png",
                                                    height: 150,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GradientText(
                                                      'Men',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18.0,
                                                          fontFamily:
                                                              "Alhadara-DEMO"),
                                                      gradientType:
                                                          GradientType.linear,
                                                      radius: 2.5,
                                                      colors: [
                                                        gradient2,
                                                        gradient1
                                                      ],
                                                    ),
                                                    Text(
                                                      "Explore More >",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Catalogue(
                                                          type: "child",
                                                        )));
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: white),
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: white),
                                                  child: Image.asset(
                                                    "assets/image/kids.png",
                                                    height: 150,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GradientText(
                                                      'Kids',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18.0,
                                                          fontFamily:
                                                              "Alhadara-DEMO"),
                                                      gradientType:
                                                          GradientType.linear,
                                                      radius: 2.5,
                                                      colors: [
                                                        gradient2,
                                                        gradient1
                                                      ],
                                                    ),
                                                    Text(
                                                      "Explore More >",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 8.0),
                                //   child: Container(
                                //     // width: 200,
                                //     // height: 200,
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(20),
                                //       color: Colors.blue,
                                //     ),
                                //     child: ClipRRect(
                                //       borderRadius: BorderRadius.circular(20),
                                //       child:
                                Center(
                                  child: _videoController.value.isInitialized
                                      ? AspectRatio(
                                          aspectRatio: _videoController
                                              .value.aspectRatio,
                                          child: VideoPlayer(_videoController),
                                        )
                                      : CircularProgressIndicator(),
                                ),
                                //     ),
                                //   ),
                                // ),
                                // Center(
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       setState(() {
                                //         _videoController.value.isPlaying
                                //             ? _videoController.pause()
                                //             : _videoController.play();
                                //       });
                                //     },
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Icon(
                                //         _videoController.value.isPlaying
                                //             ? Icons.pause
                                //             : Icons.play_arrow,
                                //         size: 30,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Kids Bangle",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "SF-Pro-Display",
                                            fontWeight: FontWeight.w600),
                                      ),

                                      // Text("See All", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),

                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      jewellerypage(
                                                        latestModel: latestModel!
                                                            .data!
                                                            .where((element) =>
                                                                element
                                                                    .productType ==
                                                                "child")
                                                            .toList(),
                                                        // type: "child"
                                                      )));
                                        },
                                        child: GradientText(
                                          'See All',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500),
                                          gradientType: GradientType.radial,
                                          radius: 2.5,
                                          colors: [
                                            gradient2,
                                            gradient1,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                    height: latestModel!.data!
                                                .where((element) =>
                                                    element.productType ==
                                                    "child")
                                                .length >
                                            2
                                        ? MediaQuery.of(context).size.height *
                                            0.66
                                        : MediaQuery.of(context).size.height *
                                            0.39,
                                    decoration: BoxDecoration(
                                        // color: bgcolor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: latestModel!.data!
                                            .map(
                                                (e) => e.productType == "child")
                                            .toList()
                                            .length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 15,
                                                mainAxisSpacing: 15,
                                                mainAxisExtent: 245),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // if (latestModel!.data![index].productType ==
                                          //     "child")
                                          // print(
                                          //     "======>>>>>>> Child FOund ${latestModel!.data!.where((element) => element.productType == "child").length}");
                                          // print(
                                          //     "${(latestModel!.data![index].image ?? '').toString().replaceAll('"]', "").replaceAll('["', "")}");
                                          // latestModel!
                                          //             .data![index].productType ==
                                          //         "child"
                                          //     ?
                                          return
                                              //  !isloading?
                                              latestModel!.data![index]
                                                          .productType ==
                                                      "child"
                                                  ? GestureDetector(
                                                      onTap: () async {
                                                        ProductDetailsController
                                                            productDetailsController =
                                                            Get.put(
                                                                ProductDetailsController());
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        CountJeweller(
                                                                          productid:
                                                                              latestModel!.data![index].id ?? 0,
                                                                        )));
                                                                        
                                                        await productDetailsController
                                                            .updateProductId(
                                                                latestModel!
                                                                    .data![
                                                                        index]
                                                                    .id);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  begin: Alignment
                                                                      .topCenter, // Start from the top
                                                                  end: Alignment
                                                                      .bottomCenter, // End at the bottom
                                                                  colors: [
                                                                    cardgradient1,
                                                                    cardgradient2,
                                                                  ],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                color: white),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            // Text("Hello"),
                                                                 
                                                              GestureDetector(
                                                          onTap: () async {
                                                            var productId =
                                                                latestModel!
                                                                    .data![
                                                                        index]
                                                                    .id!;
                                                            final SharedPreferences
                                                                prefs =
                                                                await SharedPreferences
                                                                    .getInstance();

                                                            userId = await prefs
                                                                .getInt('id')
                                                                .toString();
                                                            print({
                                                              "User Id": userId,
                                                              "product Id":
                                                                  productId,
                                                            });
                                                            try {
                                                              String res = await ApiHelper
                                                                  .addToWishList(
                                                                      userId,
                                                                      productId
                                                                          .toString());
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Success'),
                                                                    content:
                                                                        Text(
                                                                            res),
                                                                    actions: <
                                                                        Widget>[
                                                                      TextButton(
                                                                        child:
                                                                            Text(
                                                                          'OK',
                                                                          style:
                                                                              TextStyle(color: gradient1),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop(); // Close the dialog
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            } catch (e) {}
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Image.asset(
                                                                "assets/image/like.png"),
                                                          ),
                                                        ),
                                                       




                                                            Column( crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                            
                                                            ClipOval(
                                                              child: SizedBox
                                                                  .fromSize(
                                                                size: Size
                                                                    .fromRadius(
                                                                        50), // Image radius

                                                                child:
                                                                    // Image.network((latestModel!
                                                                    //             .data![index].image ??
                                                                    //         '')
                                                                    //     .toString())
                                                                    CachedNetworkImage(
                                                                  imageUrl: (latestModel!
                                                                              .data![
                                                                                  index]
                                                                              .image ??
                                                                          '')
                                                                      .toString()
                                                                      .replaceAll(
                                                                          '"]',
                                                                          "")
                                                                      .replaceAll(
                                                                          '["',
                                                                          ""),
                                                                  progressIndicatorBuilder: (context,
                                                                          url,
                                                                          downloadProgress) =>
                                                                      CircularProgressIndicator(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade700,
                                                                          value:
                                                                              downloadProgress.progress),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                ),
                                                                //  (latestModel!.data![index].image != null )
                                                                //      ?Image.network( (latestModel!.data![index].image??'').replaceFirst("/", "").toString())
                                                                //      :Image.asset("assets/image/goldbangle.png",
                                                                //             ),

                                                                // Image.network( (latestModel!.data![index].image??'').replaceFirst("\"" , "").toString())
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              (latestModel!.data![index].name!.length <
                                                                          12
                                                                      ? latestModel!
                                                                          .data![
                                                                              index]
                                                                          .name
                                                                      : latestModel!.data![index].name!.substring(0, 12) +
                                                                              "..." ??
                                                                          '')
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),

                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  (latestModel!
                                                                          .data![
                                                                              index]
                                                                          .unitValue)
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color:
                                                                          gradient1),
                                                                ),
                                                                Text(
                                                                  (latestModel!
                                                                          .data![
                                                                              index]
                                                                          .unit)
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color:
                                                                          gradient1),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            InkWell(
                                                              // onTap: () {
                                                              //   Navigator.push(
                                                              //       context,
                                                              //       MaterialPageRoute(
                                                              //           builder: (context) =>
                                                              //               CountJeweller(
                                                              //                 productid:
                                                              //                     latestModel!.data![index].id ?? 0,
                                                              //               )));
                                                              // },
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.05,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.3,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                25),
                                                                        gradient:
                                                                            LinearGradient(colors: [
                                                                          gradient2,
                                                                          gradient1,
                                                                        ])),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Center(
                                                                    child: Text(
                                                                      'View Product',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              white,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          
                                                            ],),
                                                            
                                                        
                                                          
                                                          
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                               
                                                  : SizedBox();
                                        },
                                      ),
                                    ))

                                // SizedBox(
                                //     height: 5,
                                //   ),
                              ])
                          // :SizedBox()
                        ],
                      ),
                    ),
            ),
    );
  }
}
