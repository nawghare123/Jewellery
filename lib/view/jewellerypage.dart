import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Mycart.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jewellery/view/countjewellery.dart';
import 'package:jewellery/view/home/homeController.dart';
import 'package:jewellery/view/home/latestModel.dart' as latMod;
import 'package:jewellery/view/home/latestModel.dart';
import 'package:jewellery/view/home/productDetailsController.dart';
import 'package:jewellery/view/jwellerypageController.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

// enum GoldKarat {
//   kt14,
//   kt16,
//   kt18,
//   kt20,
//   kt22,
//   kt24,
// }

class jewellerypage extends StatefulWidget {
  jewellerypage({super.key, this.type, required this.latestModel});
  List<latMod.Datum>? latestModel;
  String? type;

  @override
  State<jewellerypage> createState() => _jewellerypageState();
}

class _jewellerypageState extends State<jewellerypage> {
  bool isloading = false;
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

  String? _selectedOptionDropDownSortBy = "Latest Orders";
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

  int? selectedIndex;
  // bool isloading = false;
  // CategoryModel? categorymodel;
  String? selectvalue;
  String? searchTerm;
  LatestModel? latestModel;
  LatestModel? latestModelSortNew;
  LatestModel? catLatestModel;
  LatestModel? latestModeloriginal;
  @override
  void initState() {
    // latestlist();
    latestlist();

    super.initState();
    // setState(() {
    //   isloading = true;
    // });
  }

  @override
  void dispose() {
    jwelleryPageController.onClose();
    super.dispose();
  }

  // @override
  // void latestlist() async {
  //   latestModel = await ApiHelper.latestclass();
  //   setState(() {
  //     isloading = false;
  //   });
  // }

  Future<void> updateFilter(String value) async {
    if (value == "All") {
      latestModel = await ApiHelper.latestclass();
      latestModel!.data = widget.latestModel;
      latestModeloriginal = latestModel;
      setState(() {});
      return;
    }
    // var foo = catalogueModelOriginal!.data;
    latestModeloriginal = await ApiHelper.latestclass();
    latestModeloriginal!.data = latestModelSortNew!.data;

    latestModel!.data = latestModeloriginal!.data!
        .where((element) => element.category == value)
        .toList();
    setState(() {});
  }

  Future<void> updateFilterBrand(String value) async {
    if (value == "All") {
      latestModel = await ApiHelper.latestclass();
      latestModel!.data = widget.latestModel;
      latestModeloriginal = latestModel;
      setState(() {});
      return;
    }
    // var foo = catalogueModelOriginal!.data;
    latestModeloriginal = await ApiHelper.latestclass();
    latestModeloriginal!.data = widget.latestModel;

    latestModel!.data = latestModeloriginal!.data!
        .where((element) => element.brand == value)
        .toList();
    setState(() {});
  }

  Future<void> updateFilterKt(String value) async {
    if (value == "All") {
      latestModel = await ApiHelper.latestclass();
      latestModel!.data = widget.latestModel;
      latestModeloriginal = latestModel;
      setState(() {});
      return;
    }
    // var foo = catalogueModelOriginal!.data;
    latestModeloriginal = await ApiHelper.latestclass();
    latestModeloriginal!.data = widget.latestModel;

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
    latestModeloriginal!.data = widget.latestModel;
    // "Latest Orders", "Old Orders"
    if (value == "Latest Orders") latestModel!.data = latestModelSortNew!.data;
    if (value == "Old Orders")
      latestModel!.data = latestModelSortNew!.data!.reversed.toList();
    setState(() {});
  }

  void latestlist() async {
    latestModel = await ApiHelper.latestclass();
    latestModel!.data = widget.latestModel;
    latestModeloriginal = latestModel;
    latestModeloriginal!.data = latestModeloriginal!.data!.toSet().toList();
    //  latestModel!.data!.removeWhere((element) => element.category != element.id);
    // latestModel!.data!.where((element) {
    // bool categoryCondition = element.category == selectedIndex;
    //  bool nameCondition = element.name.toString().contains(searchTerm.toString());
    //   return categoryCondition && nameCondition;
    // }).toList();
    setState(() {});
    latestModeloriginal!.data!.forEach((element) {
      // print(element.category);
      stringListDropDown.add(element.brand!);
      stringListDropDownKt.add(element.purity!);
    });
    stringListDropDown = stringListDropDown.toSet().toList();
    jwelleryPageController.replaceBrandList(stringListDropDown);
    // print("after ====>>>> ${latestModel!.data}");

    stringListDropDownKt = stringListDropDownKt.toSet().toList();
    jwelleryPageController.replaceKtList(stringListDropDownKt);
    setState(() {
      isloading = false;
    });
  }

  JwelleryPageController jwelleryPageController =
      Get.put(JwelleryPageController());

  void updateMultiSelect(List<String> selectedOptionsBrandList,
      List<String> selectedOptionsKtList) async {
    //     if (value == "All") {
    //   latestModel = await ApiHelper.latestclass();
    //   latestModel!.data = widget.latestModel;
    //   latestModeloriginal = latestModel;
    //   setState(() {});
    //   return;
    // }
    // var foo = catalogueModelOriginal!.data;
    latestModeloriginal = await ApiHelper.latestclass();
    latestModeloriginal!.data = widget.latestModel;
    latestModelSortNew = latestModeloriginal;
    latestModel!.data = [];
    latestModelSortNew!.data = [];

    // selectedOptionsBrandList.forEach((item) {
    //   latestModeloriginal!.data!.forEach((element) {
    //     if (element.brand == item) {
    //       latestModel!.data!.add(element);
    //     } else {
    //       latestModel!.data!.remove(element);
    //     }
    //   });
    // });

    // selectedOptionsKtList.forEach((item) {
    //   latestModeloriginal!.data!.forEach((element) {
    //     if (element.purity == item) {
    //       latestModel!.data!.add(element);
    //     } else {
    //       latestModel!.data!.remove(element);
    //     }
    //   });
    // });

    // setState(() {});
    // latestModel!.data!.forEach(
    //   (element) {
    //     print("Brand: ${element.brand} purity ${element.purity}");
    //   },
    // );
    latestModeloriginal!.data = widget.latestModel;
    latestModel!.data = [];

    List<Datum> filteredData = [];

    selectedOptionsBrandList.forEach((brandItem) {
      selectedOptionsKtList.forEach((ktItem) {
        // Find items that match both brand and kt
        var matchingItems = latestModeloriginal!.data!.where((element) {
          return element.brand == brandItem && element.purity == ktItem;
        }).toList();

        filteredData.addAll(matchingItems);
      });
    });

    latestModel!.data = filteredData;

    latestModelSortNew!.data = filteredData;

    setState(() {});
    latestModel!.data!.forEach((element) {
      print("Brand: ${element.brand} Purity: ${element.purity}");
    });
  }

  // List<String> _selectedOptionsList = []; // List to store selected options

  // final List<String> stringListDropDownSortByList = [
  //   "Option 1",
  //   "Option 2",
  //   "Option 3"
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: gradient1,
      body: ListView(
        primary: true,
        shrinkWrap: true,
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
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          'Veejay Jewels',
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0,
                              fontFamily: "Alhadara-DEMO"),
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
                        //           child: SvgPicture.asset("assets/image/Buy.svg",
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
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/product_bg_image.png'),
                    fit: BoxFit.fill, // Adjust the fit as per your requirement
                  ),
                  // color: bgcolor,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30))),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
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
                                                MainAxisAlignment.spaceBetween,
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
                                                  child: Icon(Icons.close)),
                                            ],
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount:
                                              stringListDropDownSortBy!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final String option =
                                                stringListDropDownSortBy[index];
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
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Brand",
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
                                        // multi select brand
                                        GetBuilder<JwelleryPageController>(
                                          init: JwelleryPageController(),
                                          initState: (_) {},
                                          builder: (_) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              primary: false,
                                              itemCount: jwelleryPageController
                                                  .stringListDropDownBrandList
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final String option =
                                                    jwelleryPageController
                                                            .stringListDropDownBrandList[
                                                        index];
                                                return CheckboxListTile(
                                                  title: Text(option),
                                                  value: jwelleryPageController
                                                      .selectedOptionsBrandList
                                                      .contains(option),
                                                  onChanged: (isChecked) {
                                                    setState(() {
                                                      if (isChecked!) {
                                                        print("adding brand");
                                                        if (!jwelleryPageController
                                                            .selectedOptionsBrandList
                                                            .contains(option)) {
                                                          print("Added");
                                                          jwelleryPageController
                                                              .addSelectedOptionBrandList(
                                                                  option);
                                                        }
                                                      } else {
                                                        print("removing brand");
                                                        if (jwelleryPageController
                                                            .selectedOptionsBrandList
                                                            .contains(option)) {
                                                          print("removed");
                                                          jwelleryPageController
                                                              .removeSelectedOptionBrandList(
                                                                  option);
                                                        }
                                                      }
                                                      updateMultiSelect(
                                                          jwelleryPageController
                                                              .selectedOptionsBrandList,
                                                          jwelleryPageController
                                                              .selectedOptionsKtList);
                                                    });
                                                    // Perform any additional action on selection change here
                                                    print(
                                                        "Selected options: ${jwelleryPageController.selectedOptionsBrandList}");
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                       
                                       
                                        // ListView.builder(
                                        //   shrinkWrap: true,
                                        //   primary: false,
                                        //   itemCount: stringListDropDown!.length,
                                        //   itemBuilder: (BuildContext context,
                                        //       int index) {
                                        //     final String option =
                                        //         stringListDropDown[index];
                                        //     return RadioListTile(
                                        //       title: Text(option),
                                        //       value: option,
                                        //       groupValue:
                                        //           _selectedOptionDropDown,
                                        //       onChanged: (value) {
                                        //         setState(() {
                                        //           _selectedOptionDropDown =
                                        //               value;
                                        //         });
                                        //         updateFilterBrand(
                                        //             _selectedOptionDropDown ??
                                        //                 "All");
                                        //         setState(() {});
                                        //         print(
                                        //             "New value _selectedOptionDropDown: ${_selectedOptionDropDown}");
                                        //         Navigator.pop(context);
                                        //       },
                                        //     );
                                        //   },
                                        // ),
                                        // Purity

                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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

                                        // multi select brand
                                        GetBuilder<JwelleryPageController>(
                                          init: JwelleryPageController(),
                                          initState: (_) {},
                                          builder: (_) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              primary: false,
                                              itemCount: jwelleryPageController
                                                  .stringListDropDownKtList
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final String option =
                                                    jwelleryPageController
                                                            .stringListDropDownKtList[
                                                        index];
                                                return CheckboxListTile(
                                                  title: Text(option),
                                                  value: jwelleryPageController
                                                      .selectedOptionsKtList
                                                      .contains(option),
                                                  onChanged: (isChecked) {
                                                    setState(() {
                                                      if (isChecked!) {
                                                        print("adding kt");
                                                        if (!jwelleryPageController
                                                            .selectedOptionsKtList
                                                            .contains(option)) {
                                                          print("Added");
                                                          jwelleryPageController
                                                              .addSelectedOptionKtList(
                                                                  option);
                                                        }
                                                      } else {
                                                        print("removing kt");
                                                        if (jwelleryPageController
                                                            .selectedOptionsKtList
                                                            .contains(option)) {
                                                          print("removed");
                                                          jwelleryPageController
                                                              .removeSelectedOptionKtList(
                                                                  option);
                                                        }
                                                      }
                                                      updateMultiSelect(
                                                          jwelleryPageController
                                                              .selectedOptionsBrandList,
                                                          jwelleryPageController
                                                              .selectedOptionsKtList);
                                                    });
                                                    // Perform any additional action on selection change here
                                                    print(
                                                        "Selected options: ${jwelleryPageController.selectedOptionsKtList}");
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

                          //   },
                          //   child: Row(children: [
                          //     Text("Filter"),

                          //     SizedBox(
                          //       width: 5,
                          //     ),

                          //     // Image.asset("Image/assets/filterimg1.png")

                          //     Icon(Icons.sort)
                          //   ]),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  !isloading && latestModeloriginal != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, bottom: 10, top: 10),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    // String filter = e.categoery!;
                                    // setState(() {});
                                    // print(filter);
                                    await updateFilter("All");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
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
                                        // color: selectedIndex == index
                                        //     ? gradient1
                                        //     : Colors.white,

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
                                              "All",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  // color:
                                                  //     selectedIndex == index
                                                  //         ? white
                                                  //         : black,
                                                  fontFamily: "SF-Pro-Display",
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: latestModeloriginal!.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          // catLatestModelOriginal!.data!
                                          // .where((element) =>
                                          //     element.type == widget.type)
                                          // .toList()
                                          // .map(
                                          //   (e) =>
                                          //   Row(
                                          // children: [
                                          InkWell(
                                    onTap: () async {
                                      updateFilter(latestModeloriginal!
                                          .data![index].category
                                          .toString());
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                            .data![index]
                                                            .category ??
                                                        '')
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        selectedIndex == index
                                                            ? white
                                                            : black,
                                                    fontFamily:
                                                        "SF-Pro-Display",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //   ],
                                  // ),
                                  //  )
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  !isloading
                      ? Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Container(
                            // height: MediaQuery.of(context).size.height * 0.9,
                            decoration: BoxDecoration(
                                // color: bgcolor,

                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/image/product_bg_image.png'),
                                  fit: BoxFit
                                      .fill, // Adjust the fit as per your requirement
                                ),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30))),
                            child: SingleChildScrollView(
                                child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                shrinkWrap: true,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 10),
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
                                                  topRight:
                                                      Radius.circular(30))),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 13.0, right: 13),
                                            child: GridView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  latestModel!.data!.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 15,
                                                      mainAxisSpacing: 15,
                                                      mainAxisExtent: 200),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return
                                                    // !isloading
                                                    !isloading
                                                        ? Container(
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
                                                                        BorderRadius.circular(
                                                                            30),
                                                                    color:
                                                                        white),
                                                            child: Column(
                                                              children: [
                                                                ClipOval(
                                                                  child: SizedBox
                                                                      .fromSize(
                                                                    size: Size
                                                                        .fromRadius(
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
                                                                      imageUrl: (latestModel!.data![index].image ??
                                                                              '')
                                                                          .toString()
                                                                          .replaceAll(
                                                                              '"]',
                                                                              "")
                                                                          .replaceAll(
                                                                              '["',
                                                                              ""),
                                                                      progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(
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
                                                                          : latestModel!.data![index].name!.substring(0, 12) + "..." ??
                                                                              '')
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  (latestModel!
                                                                              .data![
                                                                                  index]
                                                                              .unitValue)
                                                                          .toString() +
                                                                      (latestModel!
                                                                              .data![index]
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
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    ProductDetailsController
                                                                        productDetailsController =
                                                                        Get.put(
                                                                            ProductDetailsController());

                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => CountJeweller(
                                                                                  productid: latestModel!.data![index].id ?? 0,
                                                                                )));
                                                                    await productDetailsController.updateProductId(
                                                                        latestModel!
                                                                            .data![index]
                                                                            .id);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.05,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.3,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(25),
                                                                            gradient: LinearGradient(colors: [
                                                                              gradient2,
                                                                              gradient1,
                                                                            ])),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'View Product',
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: white,
                                                                              fontWeight: FontWeight.w500),
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
                          ))
                      : SizedBox()
                ],
              ))
        ],
      ),
    );
  }

  // String getKaratLabel(GoldKarat karat) {
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
}
