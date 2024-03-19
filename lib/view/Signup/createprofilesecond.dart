import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:jewellery/Other/snackbar.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Login/Login.dart';
import 'package:jewellery/view/Signup/cityModel.dart';
import 'package:jewellery/view/Signup/stateModel.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Createprofilesecond extends StatefulWidget {
  Createprofilesecond(
      {super.key,
      this.Firstname,
      this.lastname,
      this.mobilenumber,
      this.email,
      this.password});
  String? Firstname;
  String? lastname;
  String? mobilenumber;
  String? email;
  String? password;

  @override
  State<Createprofilesecond> createState() => _CreateprofilesecondState();
}

class _CreateprofilesecondState extends State<Createprofilesecond> {
  StateListModel? statelistmodel;
  int? stateid;
  File? file;
  String networkurl = '';
  bool isLoadingCity = false;
//    TextEditingController _emailcontroller = TextEditingController();
//    TextEditingController _firstcontroller = TextEditingController();
//      TextEditingController _lastcontroller = TextEditingController();
//  TextEditingController _numbercontroller = TextEditingController();
//    TextEditingController _passcontroller = TextEditingController();
  TextEditingController _confpasscontroller = TextEditingController();
  TextEditingController _rolecontroller = TextEditingController();

  TextEditingController _companynamecontroller = TextEditingController();
  TextEditingController _addresscontroller = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController _gstcontroller = TextEditingController();
  TextEditingController _pincodecontroller = TextEditingController();
  String filepath = '';
  String filename = '';
  CityModel? cityModel;

  @override
  void initState() {
    // TODO: implement initState

    statemainclass();
    citylist(stateid ?? 0);
    loaddata();
    // citymainclass();
    super.initState();
  }

  Future<void> statelist() async {
    statelistmodel = await ApiHelper.stateclass();

    statelistmodel!.state!.forEach((element) {
      StateDropDownList!.add(element.stateName ?? '');
    });

    setState(() {});

//       StateDropDownList!.forEach ((element) {

//   print(element);
//  });
  }

  Future<void> citylist(int? stateid) async {
    cityModel = await ApiHelper.cityclass(stateid.toString(), context);
    // isLoadingCity = true;
    // setState(() {});

    // if (cityModel != null) {
    cityDropDownList = [];
    setState(() {});
    cityModel!.state!.forEach((element) {
      cityDropDownList!.add(element.cityName ?? '');
      cityDropDownList = cityDropDownList.toSet().toList();
      setState(() {});
      // print("City ===>>> " + element.cityName.toString());
    });
    // }
    // cityDropDownList.forEach((element) {
    //   print("City ===>>> " + element.toString());
    // });
    // isLoadingCity = false;
    // setState(() {});
  }

  Future<void> statemainclass() async {
    await statelist();
  }

//   Future <void> citymainclass() async {

// await ();

//   }

  Future getImageGallery() async {
    var image = await ImagePicker.platform
        .getImage(source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      filename = image!.name;
      filepath = image!.path;
      file = File(image!.path);
      print('Image Path $file');
    });
  }

  Future getImageCamera() async {
    var image = await ImagePicker.platform
        .getImage(source: ImageSource.camera, imageQuality: 25);

    setState(() {
      filename = image!.name;
      filepath = image!.path;
      file = File(image!.path);
      print('Image Path $file');
    });
  }

  void loaddata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      if (pref.getString("profilepic") != null) {
        networkurl = pref.getString("profilepic")!;
        print('demo $file');
      }
      if (pref.getString("filepath") != null) {
        filepath = pref.getString("filepath")!;
      }
    });
  }

  Future openCameraPopup(BuildContext context) async {
    showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.bottomCenter,
          insetPadding: EdgeInsets.all(0),
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
              height: 150,
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            // color: border,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Createprofilesecond()));
                          },
                        ),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  FloatingActionButton(
                                    backgroundColor: Colors.black,
                                    onPressed: () async {
                                      await getImageGallery();
                                      Navigator.pop(context);
                                    },
                                    tooltip: "Pick Image form gallery",
                                    child: Icon(Icons.photo),
                                  ),
                                  SizedBox(height: 5),
                                  Text('Gallery',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              Column(
                                children: [
                                  FloatingActionButton(
                                    backgroundColor: Colors.black,
                                    onPressed: () async {
                                      await getImageCamera();
                                      Navigator.pop(context);

                                      await Future.delayed(
                                          Duration(seconds: 2));
                                    },
                                    tooltip: "Pick Image from camera",
                                    child: Icon(Icons.camera_alt),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Camera',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ))
                ],
              )),
        );
      },
    );
  }

  String? dropdowncity;
  List<String> cityDropDownList = [];

  String? selectedState;
  List<String> StateDropDownList = [];
  final List<String> items = [
    'A_Item1',
    'A_Item2',
    'A_Item3',
    'A_Item4',
    'B_Item1',
    'B_Item2',
    'B_Item3',
    'B_Item4',
  ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child:
                    //SvgPicture.asset("assets/image/splash.svg",fit: BoxFit.cover)
                    Image.asset(
                  "assets/image/backgroundimg.jpg",
                 fit: BoxFit.fill
                )),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: ListView(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                  Center(
                      child: Image.asset(
                    "assets/image/logo.png",
                  )),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.8,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(25),
                    //     border: Border.all(color:whitetran ),
                    //    color: whitetran
                    // ),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: brandcolor),
                        color: white),

                    child: TextFormField(
                      controller: _companynamecontroller,
                      style: TextStyle(
                          fontSize: 14,
                          color: hintcolor,
                          fontFamily: "SF-Pro-Display"),
                      decoration: InputDecoration(

                          // contentPadding: EdgeInsets.only(left: 15),
                          fillColor: white,
                          focusColor: white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            // borderRadius: BorderRadius.circular(50),
                          ),
                          // contentPadding: EdgeInsets.all(10),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            //  borderRadius: BorderRadius.circular(50),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            //  borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: "Company Name",
                          hintStyle: TextStyle(
                              color: hintcolor,
                              fontFamily: "SF-Pro-Display",
                              fontSize: 14)),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: brandcolor),
                        color: white),
                    child: TextFormField(
                      controller: dateController,
                      style: TextStyle(
                          fontSize: 14,
                          color: hintcolor,
                          fontFamily: "SF-Pro-Display"),
                      decoration: InputDecoration(

                          // contentPadding: EdgeInsets.only(left: 15),
                          fillColor: white,
                          focusColor: white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            // borderRadius: BorderRadius.circular(50),
                          ),
                          // contentPadding: EdgeInsets.all(10),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            //  borderRadius: BorderRadius.circular(50),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            //  borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: "DD/MM/YYYY",
                          hintStyle: TextStyle(
                              color: hintcolor,
                              fontFamily: "SF-Pro-Display",
                              fontSize: 14)),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1800),
                            // DateTime.now(),
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);

                          print(formattedDate);
                          setState(() {
                            dateController.text = formattedDate;
                          });
                        } else {}
                      },
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  // DropdownButtonHideUnderline(
                  //   child: DropdownButton2<String>(
                  //     isExpanded: true,
                  //     hint: Text(
                  //       'Select city',
                  //       style: TextStyle(
                  //         fontSize: 14,
                  //         color: Theme.of(context).hintColor,
                  //       ),
                  //     ),
                  //     items: cityDropDownList!.map((item) {
                  //       // print("===>>>> got value $item");
                  //       return DropdownMenuItem(
                  //         value: item,
                  //         child: new Text(item,
                  //             style: TextStyle(
                  //                 color: black,
                  //                 fontFamily: "SF-Pro-Display",
                  //                 fontSize: 14)),
                  //       );
                  //     }).toList(),
                  //     value: dropdowncity != null ? dropdowncity : null,
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         dropdowncity = null;
                  //         dropdowncity = newValue!;
                  //       });
                  //     },
                  //     buttonStyleData: const ButtonStyleData(
                  //       padding: EdgeInsets.symmetric(horizontal: 16),
                  //       height: 40,
                  //       width: 200,
                  //     ),
                  //     dropdownStyleData: const DropdownStyleData(
                  //       maxHeight: 200,
                  //     ),
                  //     menuItemStyleData: const MenuItemStyleData(
                  //       height: 40,
                  //     ),
                  //     dropdownSearchData: DropdownSearchData(
                  //       searchController: textEditingController,
                  //       searchInnerWidgetHeight: 50,
                  //       searchInnerWidget: Container(
                  //         height: 50,
                  //         padding: const EdgeInsets.only(
                  //           top: 8,
                  //           bottom: 4,
                  //           right: 8,
                  //           left: 8,
                  //         ),
                  //         child: TextFormField(
                  //           expands: true,
                  //           maxLines: null,
                  //           controller: textEditingController,
                  //           decoration: InputDecoration(
                  //             isDense: true,
                  //             contentPadding: const EdgeInsets.symmetric(
                  //               horizontal: 10,
                  //               vertical: 8,
                  //             ),
                  //             hintText: 'Search state...',
                  //             hintStyle: const TextStyle(fontSize: 12),
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       searchMatchFn: (item, searchValue) {
                  //         return item.value.toString().contains(searchValue);
                  //       },
                  //     ),
                  //     //This to clear the search value when you close the menu
                  //     onMenuStateChange: (isOpen) {
                  //       if (!isOpen) {
                  //         textEditingController.clear();
                  //       }
                  //     },
                  //   ),
                  // ),

                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: brandcolor),
                        color: white),
                    child:
                        // DropdownButtonHideUnderline(
                        //   child: ButtonTheme(
                        //     alignedDropdown: true,
                        //     child: DropdownButton(
                        //       icon: Icon(
                        //         Icons.keyboard_arrow_down,
                        //       ),
                        //       value: selectedState,
                        //       items: StateDropDownList!.map((item) {
                        //         return DropdownMenuItem(
                        //           value: item,
                        //           child: new Text(item,
                        //               style: TextStyle(
                        //                   color: black,
                        //                   fontFamily: "SF-Pro-Display",
                        //                   fontSize: 14)),
                        //         );
                        //       }).toList(),
                        //       hint: Text("State",
                        //           style: TextStyle(
                        //               color: hintcolor,
                        //               fontFamily: "SF-Pro-Display",
                        //               fontSize: 14)),
                        //       onChanged: (String? value) async {
                        //         selectedState = value!;
                        //         setState(() {});
                        //         statelistmodel!.state!.forEach((element) async {
                        //           if (element.stateName == value) {
                        //             stateid = element!.id;
                        //             print("stateid");
                        //             isLoadingCity = true;
                        //             setState(() {});
                        //             print("====>>>>>" + stateid.toString());
                        //             await citylist(stateid ?? 0);
                        //             isLoadingCity = false;
                        //             setState(() {});
                        //           }

                        //           setState(() {});
                        //         });
                        //       },
                        //       style: TextStyle(fontSize: 12, color: Colors.black),
                        //     ),
                        //   ),
                        // ),
                        DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select state',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        // items: items
                        //     .map((item) => DropdownMenuItem(
                        //           value: item,
                        //           child: Text(
                        //             item,
                        //             style: const TextStyle(
                        //               fontSize: 14,
                        //             ),
                        //           ),
                        //         ))
                        //     .toList(),
                        items: StateDropDownList!.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: new Text(item,
                                style: TextStyle(
                                    color: black,
                                    fontFamily: "SF-Pro-Display",
                                    fontSize: 14)),
                          );
                        }).toList(),
                        // value: selectedValue,
                        value: selectedState,
                        // onChanged: (value) {
                        //   setState(() {
                        //     selectedValue = value;
                        //   });
                        // },
                        onChanged: (String? value) async {
                          selectedState = value!;
                          setState(() {});
                          statelistmodel!.state!.forEach((element) async {
                            if (element.stateName == value) {
                              stateid = element!.id;
                              print("stateid");
                              isLoadingCity = true;
                              setState(() {});
                              print("====>>>>>" + stateid.toString());
                              await citylist(stateid ?? 0);
                              isLoadingCity = false;
                              setState(() {});
                            }

                            setState(() {});
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: textEditingController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: textEditingController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search state...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return item.value
                                .toString()
                                .toLowerCase()
                                .contains(searchValue);
                          },
                        ),
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            textEditingController.clear();
                          }
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  !isLoadingCity
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: brandcolor),
                              color: white),
                          child:
                              // DropdownButtonHideUnderline(
                              //   child: ButtonTheme(
                              //     alignedDropdown: true,
                              //     child: DropdownButton(
                              //       icon: Icon(
                              //         Icons.keyboard_arrow_down,
                              //       ),
                              //       value:
                              //           dropdowncity != null ? dropdowncity : null,
                              //       items: cityDropDownList!.map((item) {
                              //         // print("===>>>> got value $item");
                              //         return DropdownMenuItem(
                              //           value: item,
                              //           child: new Text(item,
                              //               style: TextStyle(
                              //                   color: black,
                              //                   fontFamily: "SF-Pro-Display",
                              //                   fontSize: 14)),
                              //         );
                              //       }).toList(),
                              //       hint: Text("City",
                              //           style: TextStyle(
                              //               color: hintcolor,
                              //               fontFamily: "SF-Pro-Display",
                              //               fontSize: 14)),
                              //       onChanged: (String? newValue) {
                              //         setState(() {
                              //           dropdowncity = null;
                              //           dropdowncity = newValue!;
                              //         });
                              //       },
                              //       style: TextStyle(
                              //           fontSize: 12, color: Colors.black),
                              //     ),
                              //   ),
                              // ),

                              DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select city',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: cityDropDownList!.map((item) {
                                // print("===>>>> got value $item");
                                return DropdownMenuItem(
                                  value: item,
                                  child: new Text(item,
                                      style: TextStyle(
                                          color: black,
                                          fontFamily: "SF-Pro-Display",
                                          fontSize: 14)),
                                );
                              }).toList(),
                              value: dropdowncity != null ? dropdowncity : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdowncity = null;
                                  dropdowncity = newValue!;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 200,
                              ),
                              dropdownStyleData: const DropdownStyleData(
                                maxHeight: 200,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                              dropdownSearchData: DropdownSearchData(
                                searchController: textEditingController,
                                searchInnerWidgetHeight: 50,
                                searchInnerWidget: Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 4,
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: TextFormField(
                                    expands: true,
                                    maxLines: null,
                                    controller: textEditingController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      hintText: 'Search state...',
                                      hintStyle: const TextStyle(fontSize: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  return item.value
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchValue);
                                },
                              ),
                              //This to clear the search value when you close the menu
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  textEditingController.clear();
                                }
                              },
                            ),
                          ),
                        )
                      : Center(child: CircularProgressIndicator()),

                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.8,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(25),
                    //     border: Border.all(color:whitetran ),
                    //    color: whitetran
                    // ),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: brandcolor),
                        color: white),

                    child: TextFormField(
                      controller: _pincodecontroller,
                      style: TextStyle(
                          fontSize: 14,
                          color: hintcolor,
                          fontFamily: "SF-Pro-Display"),
                      decoration: InputDecoration(

                          // contentPadding: EdgeInsets.only(left: 15),
                          fillColor: white,
                          focusColor: white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            // borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            //  borderRadius: BorderRadius.circular(50),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            //  borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: "Pincode",
                          hintStyle: TextStyle(
                              color: hintcolor,
                              fontFamily: "SF-Pro-Display",
                              fontSize: 14)),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                   Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.8,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(25),
                    //     border: Border.all(color:whitetran ),
                    //    color: whitetran
                    // ),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: brandcolor),
                        color: white),

                    child: TextFormField(
                      controller: _addresscontroller,
                      style: TextStyle(
                          fontSize: 14,
                          color: hintcolor,
                          fontFamily: "SF-Pro-Display"),
                      decoration: InputDecoration(

                          // contentPadding: EdgeInsets.only(left: 15),
                          fillColor: white,
                          focusColor: white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            // borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            //  borderRadius: BorderRadius.circular(50),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            //  borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: "Address",
                          hintStyle: TextStyle(
                              color: hintcolor,
                              fontFamily: "SF-Pro-Display",
                              fontSize: 14)),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.8,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(25),
                    //     border: Border.all(color:whitetran ),
                    //    color: whitetran
                    // ),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: brandcolor),
                        color: white),

                    child: TextFormField(
                      controller: _gstcontroller,
                      //  keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                          fontSize: 14,
                          color: hintcolor,
                          fontFamily: "SF-Pro-Display"),
                      decoration: InputDecoration(

                          // contentPadding: EdgeInsets.only(left: 15),
                          fillColor: white,
                          focusColor: white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            // borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            //  borderRadius: BorderRadius.circular(50),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            //  borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: "GST Number",
                          hintStyle: TextStyle(
                              color: hintcolor,
                              fontFamily: "SF-Pro-Display",
                              fontSize: 14)),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  InkWell(
                    onTap: () {
                      openCameraPopup(context);
                    },
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: brandcolor),
                          color: white),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Upload",
                                  style: TextStyle(
                                      color: hintcolor,
                                      fontFamily: "SF-Pro-Display",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Image.asset(
                                  "assets/image/upload.png",
                                  height: 18,
                                  color: hintcolor,
                                )
                              ],
                            ),
                            Text(
                              filename,
                              style: TextStyle(
                                  color: hintcolor,
                                  fontFamily: "SF-Pro-Display",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     InkWell(
                  //       onTap: () {
                  //         openCameraPopup(context);
                  //       },
                  //       child: Container(
                  //         height: MediaQuery.of(context).size.height * 0.1,
                  //         width: MediaQuery.of(context).size.width * 0.4,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(15),
                  //             border: Border.all(color: brandcolor),
                  //             color: white),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(15.0),
                  //           child: Column(
                  //             children: [
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Text(
                  //                     "Upload",
                  //                     style: TextStyle(
                  //                         color: hintcolor,
                  //                         fontFamily: "SF-Pro-Display",
                  //                         fontSize: 14,
                  //                         fontWeight: FontWeight.w400),
                  //                   ),
                  //                   Image.asset(
                  //                     "assets/image/upload.png",
                  //                     height: 18,
                  //                     color: hintcolor,
                  //                   )
                  //                 ],
                  //               ),
                  //               Text(
                  //                 filename,
                  //                 style: TextStyle(
                  //                     color: hintcolor,
                  //                     fontFamily: "SF-Pro-Display",
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //         openCameraPopup(context);
                  //       },
                  //       child: Container(
                  //         height: MediaQuery.of(context).size.height * 0.1,
                  //         width: MediaQuery.of(context).size.width * 0.4,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(15),
                  //             border: Border.all(color: brandcolor),
                  //             color: white),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(15.0),
                  //           child: Column(
                  //             children: [
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Text(
                  //                     "Upload",
                  //                     style: TextStyle(
                  //                         color: hintcolor,
                  //                         fontFamily: "SF-Pro-Display",
                  //                         fontSize: 14,
                  //                         fontWeight: FontWeight.w400),
                  //                   ),
                  //                   Image.asset(
                  //                     "assets/image/upload.png",
                  //                     height: 18,
                  //                     color: hintcolor,
                  //                   )
                  //                 ],
                  //               ),
                  //               Text(
                  //                 filename,
                  //                 style: TextStyle(
                  //                     color: hintcolor,
                  //                     fontFamily: "SF-Pro-Display",
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                  InkWell(
                    onTap: () async {
                      if (_companynamecontroller!.text.isEmpty) {
                        showCustomSnackBar(
                          'enter company name',
                          context,
                        );
                      } else if (dateController!.text.isEmpty) {
                        showCustomSnackBar(
                            'enter company foundation date', context);
                      } else if (_pincodecontroller!.text.isEmpty) {
                        showCustomSnackBar('enter pincode', context);
                      } else if (_gstcontroller!.text.isEmpty) {
                        showCustomSnackBar('enter GST numbe', context);
                      } else {
                        ApiHelper.usersignup(
                            widget.Firstname.toString(),
                            widget.lastname.toString(),
                            widget.email.toString(),
                            widget.mobilenumber.toString(),
                            "seller",
                            widget.password.toString(),
                            "null",
                            _companynamecontroller.text,
                            dateController.text,
                            selectedState.toString(),
                            dropdowncity.toString(),
                            _addresscontroller.text.toString(),
                            _pincodecontroller.text,
                            _gstcontroller.text,
                            filepath,
                            filepath,
                            context);

                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.8,
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
                        'Create Account',
                        style: TextStyle(
                            color: white,
                            fontSize: 16,
                            fontFamily: "SF-Pro-Display",
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  //  InkWell(onTap: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                  // },child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text("Login",style: TextStyle(fontSize: 14,fontFamily:  "SF-Pro-Display",color: hintcolor),),SizedBox(width: 5,),
                  //     Icon(Icons.arrow_forward_outlined,color: hintcolor,size: 18,)
                  //   ],
                  // )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                ],
              ),
            ),
          ],
        ));
  }
}
