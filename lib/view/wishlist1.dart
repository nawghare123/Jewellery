import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/countjewellery.dart';
import 'package:jewellery/view/home/latestModel.dart';
import 'package:jewellery/view/home/productDetailsController.dart';

class WishList extends StatefulWidget {
   WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {

        LatestModel? latestModel;
       bool isloading = false;

 @override
  void initState() {
 
    latestlist();
   
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
 
 void latestlist() async {
    latestModel = await ApiHelper.latestclass();

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: 
      isloading
          ? Center(child: CircularProgressIndicator())
     : ListView(
        primary: true,
        shrinkWrap: true,
        children: [
     Container(
             height: MediaQuery.of(context).size.height*0.1,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [gradient2, gradient1])),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 13.0, bottom: 7),
                              child: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: white,
                                size: 18,
                              ),
                            )),
                        // Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,),
 SizedBox(width: 50),
                        Text(
                          'WishList',
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0,
                              fontFamily: "Alhadara-DEMO"),
                        ),

                        //Image.asset("assets/image/notification.png",color: white,),

                        // Row(
                        //   children: [
                        //     // SvgPicture.asset("assets/image/notification.svg",
                        //     //     color: white),

                        //     // SizedBox(width: 15),

                        //     //  Image.asset("assets/image/cart.png"),

                        //     // InkWell(
                        //     //     onTap: () {
                        //     //       Navigator.push(
                        //     //           context,
                        //     //           MaterialPageRoute(
                        //     //               builder: (context) => MyCart()));
                        //     //     },
                        //     //     child: SvgPicture.asset("assets/image/Buy.svg",
                        //     //         color: white)),

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
                                    height: MediaQuery.of(context).size.height  ,
                                    // height: 535,
                                   decoration: BoxDecoration(
                  // color: bgcolor,

                  image: DecorationImage(
                    image: AssetImage('assets/image/product_bg_image.png'),
                     fit: BoxFit.fill// Adjust the fit as per your requirement
                  ),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30))),
              
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
                                                mainAxisExtent: 235),
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
                                                    // print(
                                                    //     "===>>>> verified ${myHomeController.isVerified}");
                                                    ProductDetailsController
                                                        productDetailsController =
                                                        Get.put(
                                                            ProductDetailsController());
                                                    await productDetailsController
                                                        .updateProductId(
                                                            latestModel!
                                                                .data![index]
                                                                .id);
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

                                                           Padding(
                                                             padding: const EdgeInsets.all(8.0),
                                                             child: Image.asset("assets/image/like.png"),
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
                                                                      'Add to cart',
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
                                                        
      ],),
    );
  }
}