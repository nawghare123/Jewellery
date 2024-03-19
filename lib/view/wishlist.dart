import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/countjewellery.dart';
import 'package:jewellery/view/home/latestModel.dart';
import 'package:jewellery/view/home/productDetailsController.dart';
import 'package:jewellery/view/wishlistModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishList extends StatefulWidget {
  WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  WishlistModel? wishlistModel;
  bool isloading = false;

  @override
  void initState() {
    latestlist();
    setState(() {
      isloading = true;
    });
    super.initState();
  }

  var userId;

  Future<void> latestlist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = await prefs.getInt('id').toString();

    wishlistModel = await ApiHelper.getWishList(userId);

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              primary: true,
              shrinkWrap: true,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
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
                                    padding: const EdgeInsets.only(
                                        left: 13.0, bottom: 7),
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
               
               wishlistModel!.product == null ? Center(child: CircularProgressIndicator())
                    : wishlistModel!.wishlist == null ? Center(child: CircularProgressIndicator())
                    : 
                (wishlistModel!.product!.isEmpty)
                
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            // color: bgcolor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: wishlistModel!.wishlist!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    mainAxisExtent: 245),
                            itemBuilder: (BuildContext context, int index) {
                              // if(wishlistModel.length < 4){

                              // wishlistModel.length;

                              //    } else{
                              //     wishlistModel.length -1;
                              //     wishlistModel.length-2;
                              //     wishlistModel.length-3;
                              //     wishlistModel.length-4;
                              //    }

                              return wishlistModel!.product![index].isEmpty
                                  ? SizedBox()
                                  : !isloading
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
                                                .updateProductId(wishlistModel!
                                                    .product![index][0].id);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CountJeweller(
                                                          productid:
                                                              wishlistModel!
                                                                      .product![
                                                                          index]
                                                                          [0]
                                                                      .id ??
                                                                  0,
                                                        )));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
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
                                                    BorderRadius.circular(30),
                                                color: white),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    // String itemId = wishlistModel!
                                                    //     .product![index][0].id
                                                    //     .toString();
                                                    // print(itemId);

                                                    // wishlistModel!.product!.removeWhere(
                                                    //     (element) =>
                                                    //         element[0].id ==
                                                    //         wishlistModel!
                                                    //             .product![index][0].id);
                                                    // setState(() {});
                                                    await ApiHelper
                                                        .removeFromWishList(
                                                            wishlistModel!
                                                                .wishlist![
                                                                    index]
                                                                .id
                                                                .toString());
                                                    await latestlist();
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(Icons.delete),
                                                  ),
                                                ),

                                                // ClipOval(
                                                // child:
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox.fromSize(
                                                      size: Size.fromRadius(
                                                          50), // Image radius
                                                      child:
                                                          //  Image.network(
                                                          //     (wishlistModel                .data![
                                                          //                     index]
                                                          //                 .image ??
                                                          //             '')
                                                          //         .toString())
                                                          CachedNetworkImage(
                                                        imageUrl: (wishlistModel!
                                                                    .product![
                                                                        index]
                                                                        [0]
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
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                      //  (wishlistModel[index].image != null )
                                                      //      ?Image.network( (wishlistModel[index].image??'').replaceFirst("/", "").toString())
                                                      //      :Image.asset("assets/image/goldbangle.png",
                                                      //             ),

                                                      // Image.network( (wishlistModel[index].image??'').replaceFirst("\"" , "").toString())
                                                    ),
                                                    // ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      (wishlistModel!
                                                                      .product![
                                                                          index]
                                                                          [0]
                                                                      .name!
                                                                      .length <
                                                                  12
                                                              ? wishlistModel!
                                                                  .product![
                                                                      index][0]
                                                                  .name
                                                              : wishlistModel!
                                                                          .product![
                                                                              index]
                                                                              [
                                                                              0]
                                                                          .name!
                                                                          .substring(
                                                                              0,
                                                                              12) +
                                                                      "..." ??
                                                                  '')
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                                                          (wishlistModel!
                                                                  .product![
                                                                      index][0]!
                                                                  .unitValue)
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: gradient1),
                                                        ),
                                                        Text(
                                                          (wishlistModel!
                                                                  .product![
                                                                      index][0]
                                                                  .unit)
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: gradient1),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),

                                                    InkWell(
                                                      onTap: () async {
                                                        ProductDetailsController
                                                            productDetailsController =
                                                            Get.put(
                                                                ProductDetailsController());
                                                        await productDetailsController
                                                            .updateProductId(
                                                                wishlistModel!
                                                                    .product![
                                                                        index]
                                                                        [0]
                                                                    .id);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        CountJeweller(
                                                                          productid:
                                                                              wishlistModel!.product![index][0].id ?? 0,
                                                                        )));
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
                                                                  .circular(25),
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
                                                                  fontSize: 14,
                                                                  color: white,
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
              ],
            ),
    );
  }
}
