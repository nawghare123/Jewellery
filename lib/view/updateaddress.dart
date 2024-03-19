import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/Mycart.dart';
import 'package:jewellery/view/Signup/cityModel.dart';
import 'package:jewellery/view/Signup/stateModel.dart';
import 'package:jewellery/view/drawer.dart';
import 'package:jewellery/view/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({super.key});

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _lnamecontroller = TextEditingController();
  TextEditingController _addresscontroller = TextEditingController();
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _designationcontroller = TextEditingController();
  TextEditingController _countrycontroller = TextEditingController();
  TextEditingController _statecontroller = TextEditingController();
  TextEditingController _citycontroller = TextEditingController();
  TextEditingController _pincodecontroller = TextEditingController();
  TextEditingController _currencycontroller = TextEditingController();
  TextEditingController _numbercontroller = TextEditingController();
  String? profileImage;
  String? dropdowncity;
  String? selectedState;
  bool isLoading = false;
  StateListModel? statelistmodel;
  CityModel? cityModel;
  int? stateid;
  List<String> cityDropDownList = [];
  String? userId;

  List<String> StateDropDownList = [];

  bool isLoadingCity = false;

  Future<void> getUserData() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = await prefs.getInt('id').toString();
    await prefs.getInt('is_phone_verified');

    selectedState = await prefs.getString('state');
    dropdowncity = await prefs.getString('city');
    _pincodecontroller.text = await prefs.getString('pincode') ?? "Guest";
    _namecontroller.text = await prefs.getString('first_name') ?? "Guest";
    _lnamecontroller.text = await prefs.getString('last_name') ?? "Guest";
    _addresscontroller.text = await prefs.getString('address') ??'';
    _emailcontroller.text = await prefs.getString('email') ?? "Guest";
    profileImage = await prefs.getString('image') ?? "Guest";
    _numbercontroller.text = await prefs.getString('phone') ?? "123456789";
    await prefs.getString('role') ?? "Guest";

    print(
        "===>>>> User Values : ${_namecontroller.text}, ${_lnamecontroller.text}, ${_addresscontroller.text}");

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    print("===>>> Fetching user details...");
    getUserData();
    statemainclass();
    citylist(stateid ?? 0);
  }

  Future<void> statemainclass() async {
    await statelist();
  }
  // @override
  // void initState() {
  //   // TODO: implement initState

  //   statemainclass();
  //   citylist(stateid ?? 0);
  //   loaddata();
  //   // citymainclass();
  //   super.initState();
  // }

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

  String dropdownvalue = 'Country';

  // List of items in our dropdown menu
  // var items = [
  //   'Country',
  // ];

  // // String dropdowncity = 'City';
  // var itemscity = [
  //   'City',
  // ];

  // String dropdownstate = 'State';
  // var itemsstate = [
  //   'State',
  // ];

  // String dropdowncurren = 'Currency';
  // var itemscurren = [
  //   'Currency',
  // ];
  // File? _selectedImage;
  // String? _selectedImagePath;

  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedImage != null) {
  //     setState(() {
  //       _selectedImagePath = pickedImage.path;
  //       _selectedImage = File(pickedImage.path);
  //     });
  //   }
  // }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    print("clicked...");
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: gradient1,
      body: SingleChildScrollView(
          child: Container(
              //   height: MediaQuery.of(context).size.height,

              child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.1,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [gradient2, gradient1])),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
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
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, bottom: 5),
                                              child: Icon(
                                                Icons
                                                    .arrow_back_ios_new_outlined,
                                                color: white,
                                                size: 18,
                                              ),
                                            )),// Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,),

SizedBox(width: MediaQuery.of(context).size.width*0.1,),
// n(Icons.arrow_back_ios_new_outlined,color: white,size: 20,),

                              Center(
                                child: Text(
                                  'Update Address',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20.0,
                                      fontFamily: "Alhadara-DEMO"),
                                ),
                              ),

                              //Image.asset("assets/image/notification.png",color: white,),

                              // Row(
                              //   children: [
                              //     // SvgPicture.asset(
                              //     //     "assets/image/notification.svg",
                              //     //     color: white),

                              //     // SizedBox(width: 15),

                              //     //  Image.asset("assets/image/cart.png"),

                              //     // InkWell(
                              //     //     onTap: () {
                              //     //       Navigator.push(
                              //     //           context,
                              //     //           MaterialPageRoute(
                              //     //               builder: (context) =>
                              //     //                   MyCart()));
                              //     //     },
                              //     //     child: SvgPicture.asset(
                              //     //         "assets/image/Buy.svg",
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
 height: MediaQuery.of(context).size.height*0.9,
              width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(
              //   color: bgcolor,

              //   borderRadius: BorderRadius.only(topRight: Radius.circular(30))
              // ),

              decoration: BoxDecoration(
                  color: bgcolor,
                  image: DecorationImage(
                    image: AssetImage('assets/image/backgroundimg.jpg'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30))),
              child: Padding(
                // padding: const EdgeInsets.all(13.0),
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    // Center(
                    //   child: Stack(alignment: Alignment.topCenter, children: [
                    //     Padding(
                    //       padding: EdgeInsets.only(bottom: 20),
                    //       child: CircleAvatar(
                    //         radius: 60,
                    //         backgroundColor: Colors.transparent,
                    //         child: profileImage != null
                    //             ? CachedNetworkImage(
                    //                 imageUrl:
                    //                     "https://veejayjewels.com/public/" +
                    //                         profileImage.toString(),
                    //                 progressIndicatorBuilder: (context, url,
                    //                         downloadProgress) =>
                    //                     CircularProgressIndicator(
                    //                         color: Colors.grey.shade700,
                    //                         value: downloadProgress.progress),
                    //                 errorWidget: (context, url, error) =>
                    //                     Icon(Icons.error),
                    //               )
                    //             : _selectedImage != null
                    //                 ? Image.file(_selectedImage!)
                    //                 : Image.asset(
                    //                     "assets/image/boyprofile3.png"),
                    //       ),
                    //     ),
                    //     Positioned(
                    //       bottom: 10,
                    //       child: GestureDetector(
                    //         onTap: _pickImage,
                    //         child: Image.asset(
                    //           "assets/image/drawer2.png",
                    //           height: 35,
                    //         ),
                    //       ),
                    //     )
                    //   ]),
                    // ),

                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.03,
                    // ),

                    // //  SizedBox(height: MediaQuery.of(context).size.height*0.03),

                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.07,

                    //   // width: MediaQuery.of(context).size.width*0.8,

                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       border: Border.all(color: brandcolor),
                    //       color: white),

                    //   child: TextFormField(
                    //     controller: _namecontroller,
                    //     decoration: InputDecoration(

                    //         // contentPadding: EdgeInsets.only(left: 15),

                    //         fillColor: white,
                    //         focusColor: white,
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide.none,

                    //           // borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide.none,

                    //           //  borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         border: OutlineInputBorder(
                    //           borderSide: BorderSide.none,

                    //           //  borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         hintText: "First Name ",
                    //         hintStyle: TextStyle(
                    //             color: hintcolor,
                    //             fontFamily: "SF-Pro-Display",
                    //             fontSize: 14)),
                    //   ),
                    // ),

                    // SizedBox(
                    //   height: 15,
                    // ),
                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.07,

                    //   // width: MediaQuery.of(context).size.width*0.8,

                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       border: Border.all(color: brandcolor),
                    //       color: white),

                    //   child: TextFormField(
                    //     controller: _lnamecontroller,
                    //     decoration: InputDecoration(

                    //         // contentPadding: EdgeInsets.only(left: 15),

                    //         fillColor: white,
                    //         focusColor: white,
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide.none,

                    //           // borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide.none,

                    //           //  borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         border: OutlineInputBorder(
                    //           borderSide: BorderSide.none,

                    //           //  borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         hintText: "Last Name ",
                    //         hintStyle: TextStyle(
                    //             color: hintcolor,
                    //             fontFamily: "SF-Pro-Display",
                    //             fontSize: 14)),
                    //   ),
                    // ),

                    // SizedBox(
                    //   height: 15,
                    // ),
                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.07,

                    //   // width: MediaQuery.of(context).size.width*0.8,

                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       border: Border.all(color: brandcolor),
                    //       color: white),

                    //   child: TextFormField(
                    //     controller: _numbercontroller,
                    //     decoration: InputDecoration(

                    //         // contentPadding: EdgeInsets.only(left: 15),

                    //         fillColor: white,
                    //         focusColor: white,
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide.none,

                    //           // borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide.none,

                    //           //  borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         border: OutlineInputBorder(
                    //           borderSide: BorderSide.none,

                    //           //  borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         hintText: "Number ",
                    //         hintStyle: TextStyle(
                    //             color: hintcolor,
                    //             fontFamily: "SF-Pro-Display",
                    //             fontSize: 14)),
                    //   ),
                    // ),

                    // SizedBox(
                    //   height: 15,
                    // ),

                    // // Container(
                    // //   height: MediaQuery.of(context).size.height * 0.07,

                    // //   // width: MediaQuery.of(context).size.width*0.8,

                    // //   decoration: BoxDecoration(
                    // //       borderRadius: BorderRadius.circular(15),
                    // //       border: Border.all(color: brandcolor),
                    // //       color: white),

                    // //   child: TextFormField(
                    // //     controller: _datecontroller,
                    // //     decoration: InputDecoration(

                    // //         // contentPadding: EdgeInsets.only(left: 15),

                    // //         fillColor: white,
                    // //         focusColor: white,
                    // //         enabledBorder: OutlineInputBorder(
                    // //           borderSide: BorderSide.none,

                    // //           // borderRadius: BorderRadius.circular(50),
                    // //         ),
                    // //         focusedBorder: OutlineInputBorder(
                    // //           borderSide: BorderSide.none,

                    // //           //  borderRadius: BorderRadius.circular(50),
                    // //         ),
                    // //         border: OutlineInputBorder(
                    // //           borderSide: BorderSide.none,

                    // //           //  borderRadius: BorderRadius.circular(50),
                    // //         ),
                    // //         hintText: "Date Formulation ",
                    // //         hintStyle: TextStyle(
                    // //             color: hintcolor,
                    // //             fontFamily: "SF-Pro-Display",
                    // //             fontSize: 14)),
                    // //   ),
                    // // ),

                    // // SizedBox(
                    // //   height: 15,
                    // // ),
                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.07,

                    //   // width: MediaQuery.of(context).size.width*0.8,

                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       border: Border.all(color: brandcolor),
                    //       color: white),

                    //   child: TextFormField(
                    //     controller: _emailcontroller,
                    //     decoration: InputDecoration(

                    //         // contentPadding: EdgeInsets.only(left: 15),

                    //         fillColor: white,
                    //         focusColor: white,
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide.none,

                    //           // borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide.none,

                    //           //  borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         border: OutlineInputBorder(
                    //           borderSide: BorderSide.none,

                    //           //  borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         hintText: "Email ID ",
                    //         hintStyle: TextStyle(
                    //             color: hintcolor,
                    //             fontFamily: "SF-Pro-Display",
                    //             fontSize: 14)),
                    //   ),
                    // ),

                    // SizedBox(
                    //   height: 15,
                    // ),

                    //           Container(

                    //             height: MediaQuery.of(context).size.height*0.07,

                    //                 // width: MediaQuery.of(context).size.width*0.8,

                    //                   decoration: BoxDecoration(

                    //                       borderRadius: BorderRadius.circular(15),

                    //                       border: Border.all(color:brandcolor ),

                    //                      color: white

                    //                   ),

                    //             child: TextFormField(

                    //                                  controller: _designationcontroller,

                    //                                decoration: InputDecoration(

                    //                                       // contentPadding: EdgeInsets.only(left: 15),

                    //                                       fillColor: white,

                    //                                       focusColor:white,

                    //                                       enabledBorder: OutlineInputBorder(

                    //                                         borderSide: BorderSide.none,

                    //                                         // borderRadius: BorderRadius.circular(50),

                    //                                       ),

                    //                                       focusedBorder: OutlineInputBorder(

                    //                                         borderSide: BorderSide.none,

                    //                                         //  borderRadius: BorderRadius.circular(50),

                    //                                       ),

                    //                                       border: OutlineInputBorder(

                    //                                         borderSide: BorderSide.none,

                    //                                         //  borderRadius: BorderRadius.circular(50),

                    //                                       ),

                    //                                       hintText:"Designation",

                    //                                       hintStyle:

                    //                                       TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),

                    //                                 ),

                    //           ),

                    // SizedBox(height: 15,),

                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.07,
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       border: Border.all(color: brandcolor),
                    //       color: white),
                    //   child: DropdownButtonHideUnderline(
                    //     child: ButtonTheme(
                    //       alignedDropdown: true,
                    //       child: DropdownButton(
                    //         icon: Icon(
                    //           Icons.keyboard_arrow_down,
                    //         ),
                    //         value: dropdownvalue,
                    //         items: items.map((String items) {
                    //           return DropdownMenuItem(
                    //             value: items,
                    //             child: Text(
                    //               items,
                    //               style: TextStyle(
                    //                   color: hintcolor,
                    //                   fontFamily: "SF-Pro-Display",
                    //                   fontSize: 14),
                    //             ),
                    //           );
                    //         }).toList(),
                    //         onChanged: (newValue) {
                    //           setState(() {
                    //             dropdownvalue = newValue!;
                    //           });
                    //         },
                    //         style: TextStyle(fontSize: 12, color: Colors.black),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // SizedBox(
                    //   height: 15,
                    // ),

                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.07,
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       border: Border.all(color: brandcolor),
                    //       color: white),
                    //   child: DropdownButtonHideUnderline(
                    //     child: ButtonTheme(
                    //       alignedDropdown: true,
                    //       child: DropdownButton(
                    //         icon: Icon(
                    //           Icons.keyboard_arrow_down,
                    //         ),
                    //         value: dropdownstate,
                    //         items: itemsstate.map((String items) {
                    //           return DropdownMenuItem(
                    //             value: items,
                    //             child: Text(
                    //               items,
                    //               style: TextStyle(
                    //                   color: hintcolor,
                    //                   fontFamily: "SF-Pro-Display",
                    //                   fontSize: 14),
                    //             ),
                    //           );
                    //         }).toList(),
                    //         onChanged: (newValue) {
                    //           setState(() {
                    //             dropdownvalue = newValue!;
                    //           });
                    //         },
                    //         style: TextStyle(fontSize: 12, color: Colors.black),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // SizedBox(
                    //   height: 15,
                    // ),

                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.07,
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       border: Border.all(color: brandcolor),
                    //       color: white),
                    //   child: DropdownButtonHideUnderline(
                    //     child: ButtonTheme(
                    //       alignedDropdown: true,
                    //       child: DropdownButton(
                    //         icon: Icon(
                    //           Icons.keyboard_arrow_down,
                    //         ),
                    //         value: dropdowncity,
                    //         items: itemscity.map((String items) {
                    //           return DropdownMenuItem(
                    //             value: items,
                    //             child: Text(
                    //               items,
                    //               style: TextStyle(
                    //                   color: hintcolor,
                    //                   fontFamily: "SF-Pro-Display",
                    //                   fontSize: 14),
                    //             ),
                    //           );
                    //         }).toList(),
                    //         onChanged: (newValue) {
                    //           setState(() {
                    //             dropdownvalue = newValue!;
                    //           });
                    //         },
                    //         style: TextStyle(fontSize: 12, color: Colors.black),
                    //       ),
                    //     ),
                    //   ),
                    // )

                    //             TextFormField(

                    //                                   controller: _datecontroller,

                    //                                decoration: InputDecoration(

                    // prefixIcon: Icon(Icons.),
                    //                                       // contentPadding: EdgeInsets.only(left: 15),

                    //                                       fillColor: white,

                    //                                       focusColor:white,

                    //                                       enabledBorder: OutlineInputBorder(

                    //                                         borderSide: BorderSide.none,

                    //                                         // borderRadius: BorderRadius.circular(50),

                    //                                       ),

                    //                                       focusedBorder: OutlineInputBorder(

                    //                                         borderSide: BorderSide.none,

                    //                                         //  borderRadius: BorderRadius.circular(50),

                    //                                       ),

                    //                                       border: OutlineInputBorder(

                    //                                         borderSide: BorderSide.none,

                    //                                         //  borderRadius: BorderRadius.circular(50),

                    //                                       ),

                    //                                       hintText:"Country ",

                    //                                       hintStyle:

                    //                                       TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),

                    //                                 ),

                    // ,

                    SizedBox(
                      height: 15,
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: brandcolor),
                          color: white),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                            ),
                            value: selectedState,
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
                            hint: Text("State",
                                style: TextStyle(
                                    color: hintcolor,
                                    fontFamily: "SF-Pro-Display",
                                    fontSize: 14)),
                            // items: StateDropDownList!.map<DropdownMenuItem<String>>(
                            //               (String? value) {
                            //         return DropdownMenuItem<String>(
                            //           value: value!.isNotEmpty ? value : null,
                            //           child: Text(
                            //             value!,
                            //            // style: state.textFieldTextStyle,
                            //           ),
                            //         );
                            //       }).toList(),
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
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    // !isLoadingCity
                    //     ? Container(
                    //         height: MediaQuery.of(context).size.height * 0.07,
                    //         width: MediaQuery.of(context).size.width,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(15),
                    //             border: Border.all(color: brandcolor),
                    //             color: white),
                    //         child: DropdownButtonHideUnderline(
                    //           child: ButtonTheme(
                    //             alignedDropdown: true,
                    //             child: DropdownButton(
                    //               icon: Icon(
                    //                 Icons.keyboard_arrow_down,
                    //               ),
                    //               value:
                    //                   // dropdowncity != null
                    //                   //     ?
                    //                   dropdowncity
                    //               // : "null"
                    //               ,
                    //               items: cityDropDownList!.map((item) {
                    //                 // print("===>>>> got value $item");
                    //                 return DropdownMenuItem(
                    //                   value: item,
                    //                   child: new Text(item,
                    //                       style: TextStyle(
                    //                           color: black,
                    //                           fontFamily: "SF-Pro-Display",
                    //                           fontSize: 14)),
                    //                 );
                    //               }).toList(),
                    //               hint: Text("City",
                    //                   style: TextStyle(
                    //                       color: hintcolor,
                    //                       fontFamily: "SF-Pro-Display",
                    //                       fontSize: 14)),
                    //               onChanged: (String? newValue) {
                    //                 setState(() {
                    //                   // dropdowncity = null;
                    //                   dropdowncity = newValue!;
                    //                 });
                    //               },
                    //               style: TextStyle(
                    //                   fontSize: 12, color: Colors.black),
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     : Center(child: CircularProgressIndicator()),
                    !isLoadingCity
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: brandcolor),
                              color: white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  value: dropdowncity,
                                  items: cityDropDownList!.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          color: black,
                                          fontFamily: "SF-Pro-Display",
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Text(
                                    "City",
                                    style: TextStyle(
                                      color: hintcolor,
                                      fontFamily: "SF-Pro-Display",
                                      fontSize: 14,
                                    ),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdowncity = newValue!;
                                    });
                                  },
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ),
                            ),
                          )
                        : Center(child: CircularProgressIndicator()),

                    SizedBox(
                      height: 15,
                    ),

                    
                   Container(
                 height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: brandcolor),
                              color: white,
                            ),

                    child: TextFormField(
                      controller: _addresscontroller,
                      // style: TextStyle(
                      //     fontSize: 14,
                      //     color: hintcolor,
                      //     fontFamily: "SF-Pro-Display"),
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
                  

                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.07,
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       border: Border.all(color: brandcolor),
                    //       color: white),
                    //   child: DropdownButtonHideUnderline(
                    //     child: ButtonTheme(
                    //       alignedDropdown: true,
                    //       child: DropdownButton(
                    //         icon: Icon(
                    //           Icons.keyboard_arrow_down,
                    //         ),
                    //         value: dropdowncurren,
                    //         items: itemscurren.map((String items) {
                    //           return DropdownMenuItem(
                    //             value: items,
                    //             child: Text(
                    //               items,
                    //               style: TextStyle(
                    //                   color: hintcolor,
                    //                   fontFamily: "SF-Pro-Display",
                    //                   fontSize: 14),
                    //             ),
                    //           );
                    //         }).toList(),
                    //         onChanged: (newValue) {
                    //           setState(() {
                    //             dropdownvalue = newValue!;
                    //           });
                    //         },
                    //         style: TextStyle(fontSize: 12, color: Colors.black),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // SizedBox(
                    //   height: 15,
                    // ),
                    // upload Documents
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       height: MediaQuery.of(context).size.height * 0.1,
                    //       width: MediaQuery.of(context).size.width * 0.4,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(15),
                    //           border: Border.all(color: brandcolor),
                    //           color: white),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(15.0),
                    //         child: Column(
                    //           children: [
                    //             Text(
                    //               "Upload",
                    //               style: TextStyle(
                    //                   color: hintcolor,
                    //                   fontFamily: "SF-Pro-Display",
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w400),
                    //             ),
                    //             SizedBox(
                    //               height: 2,
                    //             ),
                    //             Image.asset(
                    //               "assets/image/upload.png",
                    //               height: 18,
                    //               color: hintcolor,
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       height: MediaQuery.of(context).size.height * 0.1,
                    //       width: MediaQuery.of(context).size.width * 0.4,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(15),
                    //           border: Border.all(color: brandcolor),
                    //           color: white),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(15.0),
                    //         child: Column(
                    //           children: [
                    //             Text(
                    //               "Upload",
                    //               style: TextStyle(
                    //                   color: hintcolor,
                    //                   fontFamily: "SF-Pro-Display",
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w400),
                    //             ),
                    //             SizedBox(
                    //               height: 2,
                    //             ),
                    //             Image.asset(
                    //               "assets/image/upload.png",
                    //               height: 18,
                    //               color: hintcolor,
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),

                    // SizedBox(
                    //   height: 30,
                    // ),

                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await ApiHelper.updateProfileAdd(
                          _namecontroller.text,
                          _lnamecontroller.text,
                          _emailcontroller.text,
                          _numbercontroller.text,
                          selectedState ?? "",
                          dropdowncity ?? "",
                          _addresscontroller.text,
                          _pincodecontroller.text,
                          // _selectedImagePath ?? "",
                          // null,
                          userId.toString(),
                        );

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
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
                          'Update Address',
                          style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontFamily: "SF-Pro-Display",
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // GestureDetector(
                    //     onTap: () async {
                    //       final SharedPreferences prefs =
                    //           await SharedPreferences.getInstance();
                    //       await prefs.remove('login');
                    //       await prefs.remove('role');
                    //       await prefs.remove('phone');
                    //       await prefs.remove('is_phone_verified');
                    //       await prefs.remove('image');
                    //       await prefs.remove('email');
                    //       await prefs.remove('address');
                    //       await prefs.remove('last_name');
                    //       await prefs.remove('first_name');
                    //       await prefs.remove('id');
                    //       Navigator.pushReplacement(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => Splash()));
                    //     },
                    //     child: Container(
                    //       height: MediaQuery.of(context).size.height * 0.08,
                    //       width: MediaQuery.of(context).size.width * 04,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(30),
                    //           gradient: LinearGradient(
                    //             begin: Alignment.centerLeft,
                    //             end: Alignment.centerRight,
                    //             colors: [
                    //               gradient2,
                    //               gradient1,
                    //             ],
                    //           )),
                    //       child: Center(
                    //           child: Text(
                    //         'Logout',
                    //         style: TextStyle(
                    //             color: white,
                    //             fontSize: 16,
                    //             fontFamily: "SF-Pro-Display",
                    //             fontWeight: FontWeight.w500),
                    //       )),
                    //     )),

                    //  Container(
                    //            decoration: BoxDecoration(
                    //              borderRadius: BorderRadius.circular(25),
                    //              gradient: LinearGradient(colors:
                    //                  [
                    //                      gradient2,
                    //                    gradient1,

                    //                ],)
                    //            ),
                    //             child: ElevatedButton(

                    //                   onPressed: () {

                    //                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>CartDetails()));
                    //                   },
                    //                   // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                    //                   style: ElevatedButton.styleFrom(
                    //                     backgroundColor: Colors.transparent,
                    //                       elevation: 10.0,
                    //                          shape:  RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.all(Radius.circular(25)),
                    //               ),
                    //                minimumSize: Size(300, 45),

                    //                       textStyle:  TextStyle(color: Colors.white)),
                    //                   child:  Text('Update Profile',style: TextStyle(fontSize: 14,fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500),),
                    //                 ),
                    //                        ),

                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ))
        ],
      ))),
    );
  }
}
