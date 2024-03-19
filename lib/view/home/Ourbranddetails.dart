import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jewellery/style/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:jewellery/view/Mycart.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/countjewellery.dart';
import 'package:jewellery/view/home/categoriesModel.dart';
import 'package:jewellery/view/home/filtercontroller.dart';
import 'package:jewellery/view/home/latestModel.dart';
import 'package:jewellery/view/ourBrandController.dart';
// enum GoldKarat {
//   kt14,
//   kt16,
//   kt18,
//   kt20,
//   kt22,
//   kt24,

// }
//  enum Brand{
//  Arha,
//   Vedanta,
//   Irka
//  }

class OurBrandDetails extends StatefulWidget {
  OurBrandDetails({super.key, this.id, this.name});
  int? id;
  String? name;

  @override
  State<OurBrandDetails> createState() => _OurBrandDetailsState();
}

class _OurBrandDetailsState extends State<OurBrandDetails> {
  FilterController filtercontroller = Get.put(FilterController());
  // Brand? selectbrand;
  // GoldKarat? selectedKarat;

  @override
  void dispose() {
    ourController.onClose();
    super.dispose();
  }

  int? selectedIndex;
  bool isloading = false;
  CategoryModel? categorymodel;
  String? selectvalueCat;
  String? selectvalueDropDown;
  // GoldKarat? selectedKaratDropDown;
  String? _selectedOptionDropDown; // Variable to store the selected option

  String? _selectedOptionDropDownKt;
  List<String> stringListDropDown = [
    // "14kt",
    // "16kt",
    // "18kt",
    // "22kt",
    // "24kt",
    // "Latest First",
    // "Oldest First"
  ];
  String? _selectedOptionDropDownSortBy = "Latest Orders";
  List<String> stringListDropDownSortBy = [
    "Latest Orders", "Old Orders"
    // "14kt",
    // "16kt",
    // "18kt",
    // "22kt",
    // "24kt",
    // "Latest First",
    // "Oldest First"
  ];
  List<String> stringListDropDownKt = [
    // "14kt",
    // "16kt",
    // "18kt",
    // "22kt",
    // "24kt",
    // "Latest First",
    // "Oldest First"
  ];
  // final List<String> stringListDropDown1 = [];

  // int? selectedIndex;
  // bool isloading = false;
  // CategoryModel? categorymodel;

  OurController ourController = Get.put(OurController());
  String? selectvalue;
  String? searchTerm;

  LatestModel? latestModel;
  LatestModel? latestModeloriginal;
  LatestModel? latestModelSortNew;

  LatestModel? latestModelCategory;
  @override
  void initState() {
    categorylist();
    super.initState();
    latestlist();
    setState(() {
      isloading = true;
    });
  }

  Future<void> updateFilter(String value) async {
    // if (value == "All") {
    //   latestModeloriginal = await ApiHelper.latestclass();
    //   latestModel = latestModeloriginal;
    //   setState(() {});
    //   return;
    // }
    // var foo = catalogueModelOriginal!.data;
    // latestModeloriginal = await ApiHelper.latestclass();
    latestModel = await ApiHelper.latestclass();
    // latestModel!.data = widget.latestModel;

    //  latestModeloriginal = await ApiHelper.latestclass();
    // latestModeloriginal!.data = widget.latestModel;
    latestModel!.data!.removeWhere((element) => element.brand != widget.name);
    print("Latest list length: ${latestModel!.data!.length}");

    latestModeloriginal = latestModelSortNew ?? latestModel!;
    // latestModeloriginal!.data = latestModelSortNew!.data;
    // latestModel!.data = [];
    latestModel!.data = latestModeloriginal!.data!
        .where((element) => element.category == value)
        .toList();
    // latestModelSortNew!.data!.forEach((element) {
    //   print("Item ${element.category} ${value}");
    //   if (element.category == value) {
    //     // latestModel!.data!.add(element);
    //     setState(() {});
    //   }
    // });
    // print(latestModeloriginal!.data!.length);

    // latestModel!.data = latestModeloriginal!.data!
    //     .where((element) => element.category == value)
    //     .toList();
    setState(() {});
  }

  Future<void> updateFilterKt(String value) async {
    if (value == "All") {
      latestModel = await ApiHelper.latestclass();
      // latestModel!.data = widget.latestModel;
      latestModeloriginal = latestModel;
      setState(() {});
      return;
    }
    // var foo = catalogueModelOriginal!.data;
    latestModeloriginal = await ApiHelper.latestclass();
    // latestModeloriginal!.data = widget.latestModel;

    latestModel!.data = latestModeloriginal!.data!
        .where((element) => element.purity == value)
        .toList();
    setState(() {});
  }

  Future<void> updateFilterSortBy(String value) async {
    // if (value == "All") {
    //   latestModel = await ApiHelper.latestclass();
    //   latestModel!.data = widget.latestModel;
    //   latestModeloriginal = latestModel;
    //   setState(() {});
    //   return;
    // }
    // var foo = catalogueModelOriginal!.data;
    latestModeloriginal = await ApiHelper.latestclass();
    // latestModeloriginal!.data = widget.latestModel;
    // "Latest Orders", "Old Orders"
    if (value == "Latest Orders") latestModel!.data = latestModelSortNew!.data;
    if (value == "Old Orders")
      latestModel!.data = latestModelSortNew!.data!.reversed.toList();
    setState(() {});
  }

  void updateMultiSelect(List<String> selectedOptionsKtList) async {
    latestModel = await ApiHelper.latestclass();
    // latestModel!.data = widget.latestModel;

    //  latestModeloriginal = await ApiHelper.latestclass();
    // latestModeloriginal!.data = widget.latestModel;
    latestModel!.data!.removeWhere((element) => element.brand != widget.name);
    print("Latest list length: ${latestModel!.data!.length}");
    latestModelSortNew = latestModel; // for non null
    latestModeloriginal = latestModel;
    // latestModel!.data = [];
    // latestModelSortNew!.data = [];

    List<Datum> filteredData = [];
    print("Filtering...");
    print("Latest Original list length: ${latestModel!.data!.length}");
    // selectedOptionsBrandList.forEach((brandItem) {
    selectedOptionsKtList.forEach((ktItem) {
      print(ktItem);
      // Find items that match both brand and kt
      // var matchingItems = latestModeloriginal!.data!.where((element) {
      //   print("element purity: ${element.purity}");
      //   return element.purity == ktItem;
      // }).toList();
      latestModel!.data!.forEach((element) {
        if (element.purity == ktItem) {
          print("Item Brand: ${element.brand} ${element.purity}");
          filteredData.add(element);
        }
      });

      // filteredData.addAll(matchingItems);
    });
    // });

    latestModel!.data = filteredData;

    latestModelSortNew!.data = filteredData;

    setState(() {});
    latestModel!.data!.forEach((element) {
      print("Brand: ${element.brand} Purity: ${element.purity}");
    });
  }

  void latestlist() async {
    latestModel = await ApiHelper.latestclass();
    latestModeloriginal = latestModel;
    latestModelCategory = latestModel;
    latestModeloriginal!.data = latestModeloriginal!.data!.toSet().toList();
    latestModel!.data!.removeWhere((element) => element.brand != widget.name);
    setState(() {});
    latestModeloriginal!.data!.forEach((element) {
      print(element.category);
      stringListDropDown.add(element.brand!);
      stringListDropDownKt.add(element.purity!);
    });

    stringListDropDown = stringListDropDown.toSet().toList();
    // print("after ====>>>> ${latestModel!.data}");

    stringListDropDownKt = stringListDropDownKt.toSet().toList();
    ourController.replaceKtList(stringListDropDownKt);

    // print("after ====>>>> ${latestModel!.data}");
    setState(() {
      isloading = false;
    });
  }

  void categorylist() async {
    categorymodel = await ApiHelper.categoreyclass(widget.id ?? 0);
    print(widget.id);
    print(categorymodel);
    // setState(() {
    //   isloading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: gradient1,
      body: Container(
        decoration: BoxDecoration(
          // color: bgcolor,

          image: DecorationImage(
            image: AssetImage('assets/image/product_bg_image.png'),
            fit: BoxFit.cover, // Adjust the fit as per your requirement
          ),
          // borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 13.0, bottom: 5),
                                child: Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: white,
                                  size: 18,
                                ),
                              )),
                          // Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,),

                          Text(
                            widget.name.toString(),
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
                  // color: bgcolor,

                  image: DecorationImage(
                    image: AssetImage('assets/image/product_bg_image.png'),
                    fit: BoxFit.cover, // Adjust the fit as per your requirement
                  ),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30))),
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        // height: MediaQuery.of(context).size.height*0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0)),
                                    ),
                                    builder: (context) {
                                      return ListView(
                                        shrinkWrap: true,

                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        // mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Sort By",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: gradient1,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(Icons.close))
                                              ],
                                            ),
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount: stringListDropDownSortBy!
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final String option =
                                                  stringListDropDownSortBy[
                                                      index];
                                              return RadioListTile(
                                                title: Text(option),
                                                value: option,
                                                groupValue:
                                                    _selectedOptionDropDownSortBy,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedOptionDropDownSortBy =
                                                        value;
                                                  });
                                                  updateFilterSortBy(
                                                      _selectedOptionDropDownSortBy ??
                                                          "All");
                                                  setState(() {});
                                                  print(
                                                      "New value _selectedOptionDropDownSortBy: ${_selectedOptionDropDownSortBy}");
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Row(children: [
                                Text("Sort"),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.sort_outlined)
                              ]),
                            ),
                            // InkWell(
                            //   onTap:(){

                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0)),
                                    ),
                                    builder: (context) {
                                      return ListView(
                                        shrinkWrap: true,

                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        // mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // Purity

                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Purity",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: gradient1,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(Icons.close))
                                              ],
                                            ),
                                          ),
                                          // ListView.builder(
                                          //   shrinkWrap: true,
                                          //   primary: false,
                                          //   itemCount:
                                          //       stringListDropDownKt!.length,
                                          //   itemBuilder: (BuildContext context,
                                          //       int index) {
                                          //     final String option =
                                          //         stringListDropDownKt[index];
                                          //     return RadioListTile(
                                          //       title: Text(option),
                                          //       value: option,
                                          //       groupValue:
                                          //           _selectedOptionDropDownKt,
                                          //       onChanged: (value) {
                                          //         setState(() {
                                          //           _selectedOptionDropDownKt =
                                          //               value;
                                          //         });
                                          //         updateFilterKt(
                                          //             _selectedOptionDropDownKt ??
                                          //                 "All");
                                          //         setState(() {});
                                          //         print(
                                          //             "New value _selectedOptionDropDown: ${_selectedOptionDropDownKt}");
                                          //         Navigator.pop(context);
                                          //       },
                                          //     );
                                          //   },
                                          // ),

                                          // multi select brand
                                          GetBuilder<OurController>(
                                            init: OurController(),
                                            initState: (_) {},
                                            builder: (_) {
                                              return ListView.builder(
                                                shrinkWrap: true,
                                                primary: false,
                                                itemCount: ourController
                                                    .stringListDropDownKtList
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final String option =
                                                      ourController
                                                              .stringListDropDownKtList[
                                                          index];
                                                  return CheckboxListTile(
                                                    title: Text(option),
                                                    value: ourController
                                                        .selectedOptionsKtList
                                                        .contains(option),
                                                    onChanged: (isChecked) {
                                                      setState(() {
                                                        if (isChecked!) {
                                                          print("adding kt");
                                                          if (!ourController
                                                              .selectedOptionsKtList
                                                              .contains(
                                                                  option)) {
                                                            print("Added");
                                                            ourController
                                                                .addSelectedOptionKtList(
                                                                    option);
                                                          }
                                                        } else {
                                                          print("removing kt");
                                                          if (ourController
                                                              .selectedOptionsKtList
                                                              .contains(
                                                                  option)) {
                                                            print("removed");
                                                            ourController
                                                                .removeSelectedOptionKtList(
                                                                    option);
                                                          }
                                                        }
                                                        updateMultiSelect(
                                                            ourController
                                                                .selectedOptionsKtList);
                                                      });
                                                      // Perform any additional action on selection change here
                                                      print(
                                                          "Selected options: ${ourController.selectedOptionsKtList}");
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Row(children: [
                                Text("Filter"),

                                SizedBox(
                                  width: 5,
                                ),

                                // Image.asset("Image/assets/filterimg1.png")

                                Icon(Icons.sort)
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
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
                    !isloading && latestModelCategory != null
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
                                itemCount: latestModelCategory!.data!.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        GestureDetector(
                                  onTap: () {
                                    // setState(() {
                                    //   selectedIndex = index;
                                    // });

                                    updateFilter(latestModelCategory!
                                        .data![index].category
                                        .toString());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      width: MediaQuery.of(context).size.width *
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
                                        borderRadius: BorderRadius.circular(25),
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // (categorymodel!.data![index]
                                            //                 .image !=
                                            //             null &&
                                            //         categorymodel!.data![index]
                                            //                 .image ==
                                            //             "null")
                                            //     ? Image.network(
                                            //         (categorymodel!.data![index]
                                            //                     .image ??
                                            //                 '')
                                            //             .toString(),
                                            //         height: 28)
                                            //     : Image.asset(
                                            //         "assets/image/kangan1.png",
                                            //         height: 28),

                                            //  SizedBox(width: MediaQuery.of(context).size.width*0.01,),

                                            Text(
                                              latestModelCategory!
                                                      .data![index].category ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: selectedIndex == index
                                                      ? white
                                                      : black,
                                                  fontFamily: "SF-Pro-Display",
                                                  fontWeight: FontWeight.w500),
                                            )
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
                                  return !isloading
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
                                                            color: Colors
                                                                .grey.shade700,
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                    errorWidget:
                                                        (context, url, error) =>
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
                                                (latestModel!.data![index].name!
                                                                .length <
                                                            12
                                                        ? latestModel!
                                                            .data![index].name
                                                        : latestModel!
                                                                    .data![
                                                                        index]
                                                                    .name!
                                                                    .substring(
                                                                        0, 12) +
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
                                                    (latestModel!
                                                            .data![index].unit)
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: gradient1),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  CountJeweller(
                                                                    productid: latestModel!
                                                                            .data![index]
                                                                            .id ??
                                                                        0,
                                                                  )));
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      gradient: LinearGradient(
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
                                                        'Add to cart',
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
      ),
    );
  }

  //  String getKaratLabel(GoldKarat karat) {
  //   switch (karat) {
  //     case GoldKarat.kt14:
  //       return '14kt';
  //     case GoldKarat.kt16:
  //       return '16kt';
  //     case GoldKarat.kt18:
  //       return '18kt';
  //     case GoldKarat.kt20:
  //       return '20kt';
  //     case GoldKarat.kt22:
  //       return '22kt';
  //     case GoldKarat.kt24:
  //       return '24kt';

  //     default:
  //       return '';
  //   }
  // }

//    String getbrand(Brand brand) {
//     switch (brand) {
//      case Brand.Arha:
//         return 'Arha';
//          case Brand.Vedanta:
//         return 'Vedanta';
//          case Brand.Irka:
//         return 'Irka';
//       default:
//         return '';
// }
  //  }
}
