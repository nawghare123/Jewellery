import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Mycart.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jewellery/view/blogModel.dart';
import 'package:jewellery/view/countjewellery.dart';
import 'package:jewellery/view/home/blogDetailsPage.dart';
import 'package:jewellery/view/home/latestModel.dart' as latMod;
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlogsPage extends StatefulWidget {
  BlogsPage({
    super.key,
  });

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  bool isloading = false;
  String? selectvalue;
  BlogModel? blogModel;

  @override
  void initState() {
    // latestlist();

    setState(() {
      isloading = true;
    });

    super.initState();

    blogList();
    // setState(() {
    //   isloading = true;
    // });
  }

  void blogList() async {
    blogModel = await ApiHelper.getBlogs();

    setState(() {
      isloading = false;
    });
  }

  // @override
  // void latestlist() async {
  //   latestModel = await ApiHelper.latestclass();
  //   setState(() {
  //     isloading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradient1,
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

                          Text(
                            'Blogs',
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

                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyCart()));
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
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: bgcolor,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(15),
                    //   child: Container(
                    //     // height: MediaQuery.of(context).size.height*0.05,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         InkWell(
                    //           onTap: () {
                    //             showModalBottomSheet(
                    //                 isScrollControlled: true,
                    //                 context: context,
                    //                 backgroundColor: Colors.white,
                    //                 shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.only(
                    //                       topLeft: Radius.circular(15.0),
                    //                       topRight: Radius.circular(15.0)),
                    //                 ),
                    //                 builder: (context) {
                    //                   return Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     mainAxisSize: MainAxisSize.min,
                    //                     children: <Widget>[
                    //                       Padding(
                    //                         padding: const EdgeInsets.all(15.0),
                    //                         child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment
                    //                                   .spaceBetween,
                    //                           children: [
                    //                             Text(
                    //                               "Sort By",
                    //                               style: TextStyle(
                    //                                   fontSize: 16,
                    //                                   color: gradient1,
                    //                                   fontWeight:
                    //                                       FontWeight.w500),
                    //                             ),
                    //                             InkWell(
                    //                                 onTap: () {
                    //                                   Navigator.pop(context);
                    //                                 },
                    //                                 child: Icon(Icons.close))
                    //                           ],
                    //                         ),
                    //                       ),
                    //                       RadioListTile(
                    //                         title: Text("Latest First"),
                    //                         value: "Latest First",
                    //                         groupValue: selectvalue,
                    //                         onChanged: (value) {
                    //                           setState(() {
                    //                             selectvalue = value.toString();
                    //                           });
                    //                         },
                    //                       ),
                    //                       RadioListTile(
                    //                         title: Text("Oldest First"),
                    //                         value: "Oldest First",
                    //                         groupValue: selectvalue,
                    //                         onChanged: (value) {
                    //                           setState(() {
                    //                             selectvalue = value.toString();
                    //                           });
                    //                         },
                    //                       ),
                    //                       RadioListTile(
                    //                         title: Text("Gross Wt High to Low"),
                    //                         value: "Gross Wt High to Low",
                    //                         groupValue: selectvalue,
                    //                         onChanged: (value) {
                    //                           setState(() {
                    //                             selectvalue = value.toString();
                    //                           });
                    //                         },
                    //                       ),
                    //                       RadioListTile(
                    //                         title: Text("Gross Wt Low to High"),
                    //                         value: "Gross Wt Low to High",
                    //                         groupValue: selectvalue,
                    //                         onChanged: (value) {
                    //                           setState(() {
                    //                             selectvalue = value.toString();
                    //                           });
                    //                         },
                    //                       ),
                    //                     ],
                    //                   );
                    //                 });
                    //           },
                    //           child: Row(children: [
                    //             Text("Sort"),
                    //             SizedBox(
                    //               width: 5,
                    //             ),
                    //             Icon(Icons.sort_outlined)
                    //           ]),
                    //         ),
                    //         Row(children: [
                    //           Text("Filter"),

                    //           SizedBox(
                    //             width: 5,
                    //           ),

                    //           // Image.asset("Image/assets/filterimg1.png")

                    //           Icon(Icons.sort)
                    //         ]),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    !isloading
                        ? Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: blogModel!.data!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                        mainAxisExtent: 200),
                                itemBuilder: (BuildContext context, int index) {
                                  return !isloading
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlogDetailsPage(
                                                          author: blogModel!
                                                              .data![index]
                                                              .author,
                                                          banner:
                                                              "https://veejayjewels.com/storage/app/public/banner/${blogModel!.data![index].banner}",
                                                          desc: blogModel!
                                                              .data![index]
                                                              .description,
                                                          image:
                                                              "https://veejayjewels.com/storage/app/public/banner/${blogModel!.data![index].image}",
                                                          title: blogModel!
                                                              .data![index]
                                                              .title,
                                                        )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Image.asset(
                                                  //     "assets/image/img2.png"),
                                                  // Align(
                                                  //   alignment: Alignment.center,
                                                  //   child: Container(
                                                  //     width:
                                                  //         MediaQuery.of(context)
                                                  //                 .size
                                                  //                 .width *
                                                  //             0.5,
                                                  //     height: 80,
                                                  //     decoration: BoxDecoration(
                                                  //         borderRadius:
                                                  //             BorderRadius
                                                  //                 .circular(30),
                                                  //         color: white),
                                                  //     child: ClipRRect(
                                                  //       borderRadius:
                                                  //           BorderRadius.only(
                                                  //         topLeft:
                                                  //             Radius.circular(
                                                  //                 30),
                                                  //         topRight:
                                                  //             Radius.circular(
                                                  //                 30),
                                                  //       ),
                                                  //       child: AspectRatio(
                                                  //         aspectRatio: 16 / 9,
                                                  //         child:
                                                  //             CachedNetworkImage(
                                                  //           // height: 60,
                                                  //           imageUrl:
                                                  //               "https://veejayjewels.com/storage/app/public/banner/${blogModel!.data![index].image!}",
                                                  //           progressIndicatorBuilder: (context,
                                                  //                   url,
                                                  //                   downloadProgress) =>
                                                  //               CircularProgressIndicator(
                                                  //                   color: Colors
                                                  //                       .grey
                                                  //                       .shade700,
                                                  //                   value: downloadProgress
                                                  //                       .progress),
                                                  //           errorWidget:
                                                  //               (context, url,
                                                  //                       error) =>
                                                  //                   Icon(Icons
                                                  //                       .error),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      height: 117,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: white,
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                        ),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              "https://veejayjewels.com/storage/app/public/banner/${blogModel!.data![index].image!}",
                                                          imageBuilder: (context,
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
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      downloadProgress) =>
                                                                  CircularProgressIndicator(
                                                            color: Colors
                                                                .grey.shade700,
                                                            value:
                                                                downloadProgress
                                                                    .progress,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(height: 10),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      blogModel!
                                                                  .data![index]
                                                                  .title!
                                                                  .length <
                                                              20
                                                          ? blogModel!
                                                              .data![index]
                                                              .title!
                                                          : "${blogModel!.data![index].title!.substring(0, 18)}...",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: black),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        blogModel!
                                                                    .data![
                                                                        index]
                                                                    .description!
                                                                    .length <
                                                                30
                                                            ? blogModel!
                                                                .data![index]
                                                                .description!
                                                            : "${blogModel!.data![index].description!.toLowerCase().substring(0, 29)}...",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: hintcolor,
                                                            fontSize: 11),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox();

                                  //           if(widget.type == "child")
                                  //   return   !isloading?
                                  //     Container(
                                  //       decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(30),
                                  //           color: white),
                                  //       child: Column(
                                  //         children: [

                                  //           ClipOval(
                                  //             child: SizedBox.fromSize(
                                  //                 size: Size.fromRadius(50), // Image radius

                                  //                 child: (widget.latestModel![index].image != null )
                                  //                ?Image.network( (widget.latestModel![index].image??'').replaceFirst("\"" , "").toString())
                                  //                :Image.asset("assets/image/goldbangle.png",
                                  //                       ),

                                  //                 // Image.network( (widget.latestModel![index].image??'').replaceFirst("\"" , "").toString())
                                  //                 // Image.asset(
                                  //                 //   "assets/image/bangel.png",
                                  //                 // )

                                  //                 ),
                                  //           ),
                                  //    SizedBox(
                                  //             height: 5,
                                  //           ),

                                  //           Text(
                                  //           (widget.latestModel![index].name).toString(),
                                  //             style: TextStyle(
                                  //                 fontSize: 14, fontWeight: FontWeight.w500),
                                  //           ),

                                  //           SizedBox(
                                  //             height: 5,
                                  //           ),

                                  //           Text(
                                  //           (widget.latestModel![index].unit).toString(),
                                  //             style: TextStyle(
                                  //                 fontSize: 14, fontWeight: FontWeight.w500,color: gradient1),
                                  //           ),

                                  //           SizedBox(
                                  //             height: 8,
                                  //           ),

                                  //             InkWell(

                                  //               onTap: (){
                                  //                 Navigator.push(
                                  //             context,
                                  //             MaterialPageRoute(
                                  //                 builder: (context) => CountJeweller(
                                  // productid: widget.latestModel![index].id??0,
                                  //                 )));
                                  //               },
                                  //               child: Container(
                                  //               height: MediaQuery.of(context).size.height * 0.05,
                                  //               width: MediaQuery.of(context).size.width * 0.3,
                                  //               decoration: BoxDecoration(
                                  //                   borderRadius: BorderRadius.circular(25),
                                  //                   gradient: LinearGradient(colors: [
                                  //                     gradient2,
                                  //                     gradient1,
                                  //                   ])),
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.all(8.0),
                                  //                 child: Center(
                                  //                   child: Text(
                                  //                     'Add to cart',
                                  //                     style: TextStyle(
                                  //                         fontSize: 14,
                                  //                         color: white,
                                  //                         fontWeight: FontWeight.w500),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //                                       ),
                                  //             ),

                                  //         ],
                                  //       ),
                                  //     )

                                  //      :SizedBox();
                                },
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ))
          ],
        )),
      ),
    );
  }
}
