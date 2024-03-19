import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/countjewellery.dart';
import 'package:jewellery/view/home/categoriesModel.dart';
import 'package:jewellery/view/home/latestModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jewellery/view/home/productDetailsController.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int? selectedIndex;
  bool isloading = false;
  // CategoryModel? categorymodel;
  String? selectvalue;
  String? searchTerm;
  LatestModel? latestModel;
  LatestModel? catLatestModel;
  LatestModel? latestModeloriginal;

  @override
  void initState() {
    super.initState();
    latestlist();
    setState(() {
      isloading = true;
    });
  }

  Future<void> updateFilter(String value) async {
  //   if (value == "All") {
  //     latestModel = await ApiHelper.latestclass();
  //  latestModeloriginal    = latestModel;
  //     setState(() {});
  //     return;
  //   }
    // var foo = catalogueModelOriginal!.data;
    latestModeloriginal = await ApiHelper.latestclass();
    latestModel!.data = latestModeloriginal!.data!
        .where((element) => element.category == value)
        .toList();
    setState(() {});
  }

  void latestlist() async {
    latestModel = await ApiHelper.latestclass();
    latestModeloriginal = latestModel;
    latestModeloriginal!.data = latestModeloriginal!.data!.toSet().toList();
    //  latestModel!.data!.removeWhere((element) => element.category != element.id);
    // latestModel!.data!.where((element) {
    // bool categoryCondition = element.category == selectedIndex;
    //  bool nameCondition = element.name.toString().contains(searchTerm.toString());
    //   return categoryCondition && nameCondition;
    // }).toList();
    setState(() {});
    latestModeloriginal!.data!.forEach((element) {print(element.category);});
    // print("after ====>>>> ${latestModel!.data}");
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
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
                                  const EdgeInsets.only(left: 13.0, bottom: 5),
                              child: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: white,
                                size: 18,
                              ),
                            )),
                        // Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          "Categories",
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
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
                // color: bgcolor,

                image: DecorationImage(
                  image: AssetImage('assets/image/product_bg_image.png'),
                  fit: BoxFit.fill, // Adjust the fit as per your requirement
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //                 Padding(
                  //                 padding: const EdgeInsets.all(15),
                  //                 child: Container(
                  //                   // height: MediaQuery.of(context).size.height*0.05,
                  //                   child: Row(
                  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //                     children: [
                  //                       InkWell(
                  //                         onTap: () {
                  //                           showModalBottomSheet(
                  //                               isScrollControlled: true,
                  //                               context: context,
                  //                               backgroundColor: Colors.white,
                  //                               shape: RoundedRectangleBorder(
                  //                                 borderRadius: BorderRadius.only(
                  //                                     topLeft: Radius.circular(15.0),
                  //                                     topRight: Radius.circular(15.0)),
                  //                               ),
                  //                               builder: (context) {
                  //                                 return Column(
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment.start,
                  //                                   mainAxisSize: MainAxisSize.min,
                  //                                   children: <Widget>[
                  //                                     Padding(
                  //                                       padding: const EdgeInsets.all(15.0),
                  //                                       child: Row(
                  //                                         mainAxisAlignment:
                  //                                             MainAxisAlignment.spaceBetween,
                  //                                         children: [
                  //                                           Text(
                  //                                             "Sort By",
                  //                                             style: TextStyle(
                  //                                                 fontSize: 16,
                  //                                                 color: gradient1,
                  //                                                 fontWeight:
                  //                                                     FontWeight.w500),
                  //                                           ),
                  //                                           InkWell(
                  //                                               onTap: () {
                  //                                                 Navigator.pop(context);
                  //                                               },
                  //                                               child: Icon(Icons.close))
                  //                                         ],
                  //                                       ),
                  //                                     ),
                  //                                     RadioListTile(
                  //                                       title: Text("Latest First"),
                  //                                       value: "Latest First",
                  //                                       groupValue: selectvalue,
                  //                                       onChanged: (value) {
                  //                                         setState(() {
                  //                                           selectvalue = value.toString();
                  //                                         });
                  //                                       },
                  //                                     ),
                  //                                     RadioListTile(
                  //                                       title: Text("Oldest First"),
                  //                                       value: "Oldest First",
                  //                                       groupValue: selectvalue,
                  //                                       onChanged: (value) {
                  //                                         setState(() {
                  //                                           selectvalue = value.toString();
                  //                                         });
                  //                                       },
                  //                                     ),
                  //                                     RadioListTile(
                  //                                       title: Text("Gross Wt High to Low"),
                  //                                       value: "Gross Wt High to Low",
                  //                                       groupValue: selectvalue,
                  //                                       onChanged: (value) {
                  //                                         setState(() {
                  //                                           selectvalue = value.toString();
                  //                                         });
                  //                                       },
                  //                                     ),
                  //                                     RadioListTile(
                  //                                       title: Text("Gross Wt Low to High"),
                  //                                       value: "Gross Wt Low to High",
                  //                                       groupValue: selectvalue,
                  //                                       onChanged: (value) {
                  //                                         setState(() {
                  //                                           selectvalue = value.toString();
                  //                                         });
                  //                                       },
                  //                                     ),
                  //                                   ],
                  //                                 );
                  //                               });
                  //                         },
                  //                         child: Row(children: [
                  //                           Text("Sort"),
                  //                           SizedBox(
                  //                             width: 5,
                  //                           ),
                  //                           Icon(Icons.sort_outlined)
                  //                         ]),
                  //                       ),
                  //                       InkWell(
                  //                         onTap:(){
                  //  showModalBottomSheet(
                  //                               isScrollControlled: true,
                  //                               context: context,
                  //                               backgroundColor: Colors.white,
                  //                               shape: RoundedRectangleBorder(
                  //                                 borderRadius: BorderRadius.only(
                  //                                     topLeft: Radius.circular(15.0),
                  //                                     topRight: Radius.circular(15.0)),
                  //                               ),
                  //                               builder: (context) {
                  //                                 return Column(
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment.start,
                  //                                   mainAxisSize: MainAxisSize.min,
                  //                                   children: <Widget>[
                  //                                     Padding(
                  //                                       padding: const EdgeInsets.all(15.0),
                  //                                       child: Row(
                  //                                         mainAxisAlignment:
                  //                                             MainAxisAlignment.spaceBetween,
                  //                                         children: [
                  //                                           Text(
                  //                                             "Filter",
                  //                                             style: TextStyle(
                  //                                                 fontSize: 16,
                  //                                                 color: gradient1,
                  //                                                 fontWeight:
                  //                                                     FontWeight.w500),
                  //                                           ),
                  //                                           InkWell(
                  //                                               onTap: () {
                  //                                                 Navigator.pop(context);
                  //                                               },
                  //                                               child: Icon(Icons.close))
                  //                                         ],
                  //                                       ),
                  //                                     ),

                  //                                     RadioListTile(
                  //                                       title: Text("14 Kt"),
                  //                                       value: "14 Kt",
                  //                                       groupValue: selectvalue,
                  //                                       onChanged: (value) {
                  //                                         setState(() {
                  //                                           selectvalue = value.toString();
                  //                                         });
                  //                                       },
                  //                                     ),
                  //                                     RadioListTile(
                  //                                       title: Text("Oldest First"),
                  //                                       value: "Oldest First",
                  //                                       groupValue: selectvalue,
                  //                                       onChanged: (value) {
                  //                                         setState(() {
                  //                                           selectvalue = value.toString();
                  //                                         });
                  //                                       },
                  //                                     ),
                  //                                     RadioListTile(
                  //                                       title: Text("Gross Wt High to Low"),
                  //                                       value: "Gross Wt High to Low",
                  //                                       groupValue: selectvalue,
                  //                                       onChanged: (value) {
                  //                                         setState(() {
                  //                                           selectvalue = value.toString();
                  //                                         });
                  //                                       },
                  //                                     ),
                  //                                     RadioListTile(
                  //                                       title: Text("Gross Wt Low to High"),
                  //                                       value: "Gross Wt Low to High",
                  //                                       groupValue: selectvalue,
                  //                                       onChanged: (value) {
                  //                                         setState(() {
                  //                                           selectvalue = value.toString();
                  //                                         });
                  //                                       },
                  //                                     ),
                  //                                   ],
                  //                                 );
                  //                               });

                  //                         },
                  //                         child: Row(children: [
                  //                           Text("Filter"),

                  //                           SizedBox(
                  //                             width: 5,
                  //                           ),

                  //                           // Image.asset("Image/assets/filterimg1.png")

                  //                           Icon(Icons.sort)
                  //                         ]),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                    child: Text(
                      "Category",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "SF-Pro-Display",
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  !isloading && latestModeloriginal != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, bottom: 10, top: 10),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: latestModeloriginal!.data!.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  // catLatestModelOriginal!.data!
                                  // .where((element) =>
                                  //     element.type == widget.type)
                                  // .toList()
                                  // .map(
                                  //   (e) =>
                                  Row(
                                children: [
                                  // Text(latestModeloriginal!.data![index].category.toString()),
                                  //  InkWell(
                                  //                             onTap: () async {
                                  //                               // String filter = e.categoery!;
                                  //                               // setState(() {});
                                  //                               // print(filter);
                                  //                               await updateFilter("All");
                                  //                             },
                                  //                             child: Padding(
                                  //                               padding: const EdgeInsets.all(8.0),
                                  //                               child: Container(
                                  //                                 // height:
                                  //                                 //     MediaQuery.of(context).size.width * 0.55,
                                  //                                 // width:
                                  //                                 //     MediaQuery.of(context).size.width * 0.6,
                                  //                                 decoration: BoxDecoration(
                                  //                                   borderRadius: BorderRadius.circular(30),
                                  //                                   // color: white,
                                  //                                   gradient: LinearGradient(
                                  //                                     begin: Alignment.centerLeft,
                                  //                                     end: Alignment.centerRight,
                                  //                                     colors: [gradient2, gradient1],
                                  //                                   ),
                                  //                                 ),
                                  //                                 child: Padding(
                                  //                                   padding: const EdgeInsets.all(12.0),
                                  //                                   child: Text(
                                  //                                     "All",
                                  //                                     style: TextStyle(
                                  //                                       color: white,
                                  //                                     ),
                                  //                                   ),
                                  //                                 ),
                                  //                               ),
                                  //                             ),
                                  //                           ),

                                  // Row(
                                  //   children: latestModeloriginal!.data!
                                        // .where((element) =>
                                        //     element.category ==
                                        //     latestModeloriginal!
                                        //         .data![index].category
                                        //         .toString())
                                        // .toList()
                                        // .map(
                                        //   (e) => 
                                          InkWell(
                                            onTap: () async {
                                              updateFilter(latestModeloriginal!
                                                  .data![index].category
                                                  .toString());
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
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
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  // color: !isselected? white:gradient2,
                                                  color: selectedIndex == index
                                                      ? gradient1
                                                      : Colors.white,

                                                  // gradient: selectedIndex ? LinearGradient(colors:
                                                  //         [
                                                  //           gradient2,
                                                  //           gradient1,
                                                  //         ]):white,

                                                  //                   gradient: (selectedIndex == "true")
                                                  // ? LinearGradient(
                                                  //     colors: [Colors.blue, Colors.green],
                                                  //     begin: Alignment.topLeft,
                                                  //     end: Alignment.bottomRight,
                                                  //   )
                                                  // : null,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      // (latestModel!.data![index]
                                                      //                 .image !=
                                                      //             null &&
                                                      //         latestModel!.data![index]
                                                      //                 .image ==
                                                      //             "null")
                                                      //     ? Image.network(
                                                      //         (latestModel!.data![index]
                                                      //                     .image ??
                                                      //                 '')
                                                      //             .toString(),
                                                      //         height: 28)
                                                      //     : Image.asset(
                                                      //         "assets/image/kangan1.png",
                                                      //         height: 28),

                                                      //  SizedBox(width: MediaQuery.of(context).size.width*0.01,),

                                                      Text(
                                                        (latestModeloriginal!
                                                                    .data![
                                                                        index]
                                                                    .category ??
                                                                '')
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                selectedIndex ==
                                                                        index
                                                                    ? white
                                                                    : black,
                                                            fontFamily:
                                                                "SF-Pro-Display",
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  //       )
                                  //       .toList(),
                                  // )
                                ],
                              ),
                              //  )
                            ),
                          ),
                        )
                      : SizedBox(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                    child: Text(
                      "Products",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "SF-Pro-Display",
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                  latestModel == null
                      ? SizedBox()
                      : Container(
                          // height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                              // color: bgcolor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30))),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 13.0, right: 13),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: latestModel!.data!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15,
                                      mainAxisExtent: 200),
                              itemBuilder: (BuildContext context, int index) {
                                return
                                    // !isloading
                                    !isloading
                                        ?
                                        //                                   Container(
                                        //                                 decoration: BoxDecoration(
                                        //                                     borderRadius: BorderRadius.circular(30),
                                        //                                     color: white),
                                        //                                 child: Column(
                                        //                                   children: [
                                        //                                     ClipOval(
                                        //                                       child: SizedBox.fromSize(
                                        //                                           size: Size.fromRadius(
                                        //                                               50), // Image radius

                                        //                                           child: Image.asset(
                                        //                                             "assets/image/bangel.png",
                                        //                                           )),
                                        //                                     ),
                                        //                                     SizedBox(
                                        //                                       height: 5,
                                        //                                     ),
                                        //                                     Text(
                                        //                                       latestModel!.data![index].unit! + " Gms",
                                        //                                       style: TextStyle(
                                        //                                           fontSize: 14,
                                        //                                           fontWeight: FontWeight.w500),
                                        //                                     ),
                                        //                                     SizedBox(
                                        //                                       height: 8,
                                        //                                     ),
                                        //                                     InkWell(
                                        //                                       onTap: () {
                                        //                                         Navigator.push(
                                        //                                             context,
                                        //                                             MaterialPageRoute(
                                        //                                                 builder: (context) =>
                                        //                                                     CountJeweller(
                                        // // productid: latestModel!.data![index].id??0,

                                        //                                                         )));
                                        //                                       },
                                        //                                       child: Container(
                                        //                                         height:
                                        //                                             MediaQuery.of(context).size.height *
                                        //                                                 0.05,
                                        //                                         width:
                                        //                                             MediaQuery.of(context).size.width *
                                        //                                                 0.3,
                                        //                                         decoration: BoxDecoration(
                                        //                                             borderRadius:
                                        //                                                 BorderRadius.circular(25),
                                        //                                             gradient: LinearGradient(colors: [
                                        //                                               gradient2,
                                        //                                               gradient1,
                                        //                                             ])),
                                        //                                         child: Padding(
                                        //                                           padding: const EdgeInsets.all(8.0),
                                        //                                           child: Center(
                                        //                                             child: Text(
                                        //                                               'Add to card',
                                        //                                               style: TextStyle(
                                        //                                                   fontSize: 14,
                                        //                                                   color: white,
                                        //                                                   fontWeight: FontWeight.w500),
                                        //                                             ),
                                        //                                           ),
                                        //                                         ),
                                        //                                       ),
                                        //                                     ),
                                        //                                   ],
                                        //                                 ),
                                        //                               );
                                        Container(
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
                                              children: [
                                                ClipOval(
                                                  child: SizedBox.fromSize(
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
                                                                  .data![index]
                                                                  .image ??
                                                              '')
                                                          .toString()
                                                          .replaceAll('"]', "")
                                                          .replaceAll('["', ""),
                                                      progressIndicatorBuilder: (context,
                                                              url,
                                                              downloadProgress) =>
                                                          CircularProgressIndicator(
                                                              color: Colors.grey
                                                                  .shade700,
                                                              value:
                                                                  downloadProgress
                                                                      .progress),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
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
                                                  (latestModel!
                                                                  .data![index]
                                                                  .name!
                                                                  .length <
                                                              12
                                                          ? latestModel!
                                                              .data![index].name
                                                          : latestModel!
                                                                      .data![
                                                                          index]
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
                                                Text(
                                                  (latestModel!.data![index]
                                                              .unitValue)
                                                          .toString() +
                                                      (latestModel!.data![index]
                                                              .unit)
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: gradient1),
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
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              gradient2,
                                                              gradient1,
                                                            ])),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                          )
                                        : SizedBox();
                              },
                            ),
                          ))
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
