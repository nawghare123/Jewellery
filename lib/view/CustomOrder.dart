import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  TextEditingController _quantitycontroller = TextEditingController();
  // _quantitycontroller
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _firstcontroller = TextEditingController();
  TextEditingController _lastcontroller = TextEditingController();
  TextEditingController _numbercontroller = TextEditingController();
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
  TextEditingController _rolecontroller = TextEditingController();
  String dropdownvalue = 'Select Type';
  bool isLoading = false;
  String? userId;
  String? selectedState;
  String? city;
  String? pincode;
  String? name;
  String? lname;
  String? profileImage;
  Future<void> getUserData() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = await prefs.getInt('id').toString();
    await prefs.getInt('is_phone_verified');

    selectedState = await prefs.getString('state');
    city = await prefs.getString('city');
    pincode = await prefs.getString('pincode') ?? "Guest";
    name = await prefs.getString('first_name') ?? "Guest";
    lname = await prefs.getString('last_name') ?? "Guest";
    _emailcontroller.text = await prefs.getString('email') ?? "Guest";
    profileImage = await prefs.getString('image') ?? "Guest";
    _numbercontroller.text = await prefs.getString('phone') ?? "123456789";
    await prefs.getString('role') ?? "Guest";

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    print("===>>> Fetching user details...");
    getUserData();
  }

  // List of items in our dropdown menu
  var items = [
    'Select Type',
  ];

  String dropdownprice = 'Select Price';
  var itemsprice = [
    'Select Price',
  ];

  String dropdown1 = 'Select';
  var items1 = [
    'Select',
  ];

  File? _selectedImage;
  String? _selectedImagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImagePath = pickedImage.path;
        _selectedImage = File(pickedImage.path);
      });
    }
  }

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
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: ListView(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.09),
                        Center(
                            child: Image.asset(
                          "assets/image/logo.png",
                        )),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),

                        Text(
                          "Custom Order Title",
                          style: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
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
                            controller: _firstcontroller,
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
                                hintText: "Custom Order title",
                                hintStyle: TextStyle(
                                    color: hintcolor,
                                    fontFamily: "SF-Pro-Display",
                                    fontSize: 14)),
                          ),
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),

                        Text(
                          "Custom Order Size",
                          style: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
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
                            keyboardType: TextInputType.number,
                            controller: _lastcontroller,
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
                                hintText: "Custom Order Size",
                                hintStyle: TextStyle(
                                    color: hintcolor,
                                    fontFamily: "SF-Pro-Display",
                                    fontSize: 14)),
                          ),
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),

                        Text(
                          "Order Quantity",
                          style: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
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
                            keyboardType: TextInputType.number,
                            controller: _quantitycontroller,
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
                                hintText: "Order Quantity",
                                hintStyle: TextStyle(
                                    color: hintcolor,
                                    fontFamily: "SF-Pro-Display",
                                    fontSize: 14)),
                          ),
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),

//           Text("Mobile Number",style: TextStyle(fontSize: 16,color:black, fontWeight: FontWeight.w500),),
//    SizedBox(height: 5,),
//         Container(
//            height: MediaQuery.of(context).size.height*0.07,
//                width: MediaQuery.of(context).size.width*0.8,
//                 // decoration: BoxDecoration(
//                 //     borderRadius: BorderRadius.circular(25),
//                 //     border: Border.all(color:whitetran ),
//                 //    color: whitetran
//                 // ),

//                   decoration: BoxDecoration(

//                       borderRadius: BorderRadius.circular(15),

//                       border: Border.all(color:brandcolor ),

//                      color: white

//                   ),

//           child: TextFormField(
//             style: TextStyle(fontSize: 14,color: hintcolor, fontFamily: "SF-Pro-Display",),
//                                 controller: _numbercontroller,
//                                    keyboardType: TextInputType.number,
//                           inputFormatters: <TextInputFormatter>[
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                           maxLength: 10,
//                              decoration: InputDecoration(
//     counterText: '',
//                               contentPadding: EdgeInsets.all(10),
//                                     // contentPadding: EdgeInsets.only(left: 15),
//                                     fillColor: white,
//                                     focusColor:white,
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       // borderRadius: BorderRadius.circular(50),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       //  borderRadius: BorderRadius.circular(50),
//                                     ),
//                                     border: OutlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       //  borderRadius: BorderRadius.circular(50),
//                                     ),
//                                     hintText:"Mobile No",
//                                     hintStyle:
//                                     TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
//                               ),
//         ),

//         SizedBox(height: MediaQuery.of(context).size.height*0.03),
//            Text("Email",style: TextStyle(fontSize: 16,color:black, fontWeight: FontWeight.w500),),
//    SizedBox(height: 5,),
//         Container(
//            height: MediaQuery.of(context).size.height*0.07,
//                width: MediaQuery.of(context).size.width*0.8,
//                 // decoration: BoxDecoration(
//                 //     borderRadius: BorderRadius.circular(25),
//                 //     border: Border.all(color:whitetran ),
//                 //    color: whitetran
//                 // ),

//                   decoration: BoxDecoration(

//                       borderRadius: BorderRadius.circular(15),

//                       border: Border.all(color:brandcolor ),

//                      color: white

//                   ),

//           child: TextFormField(
//                                 controller: _emailcontroller,
//                                               style: TextStyle(fontSize: 14,color: hintcolor, fontFamily: "SF-Pro-Display"),
//      keyboardType: TextInputType.emailAddress,
//                              decoration: InputDecoration(

//                                     // contentPadding: EdgeInsets.only(left: 15),
//                                     fillColor: white,
//                                     focusColor:white,
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       // borderRadius: BorderRadius.circular(50),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       //  borderRadius: BorderRadius.circular(50),
//                                     ),
//                                     border: OutlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       //  borderRadius: BorderRadius.circular(50),
//                                     ),
//                                     hintText:"Email",
//                                     hintStyle:
//                                     TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
//                               ),
//         ),

//   SizedBox(height: MediaQuery.of(context).size.height*0.03),

//  Text("Product Type",style: TextStyle(fontSize: 16,color:black, fontWeight: FontWeight.w500),),
//    SizedBox(height: 5,),

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
                        // SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                        // Text(
                        //   "Price Range",
                        //   style: TextStyle(
                        //       fontSize: 16,
                        //       color: black,
                        //       fontWeight: FontWeight.w500),
                        // ),
                        // SizedBox(
                        //   height: 5,
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
                        //         value: dropdownprice,
                        //         items: itemsprice.map((String items) {
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

                        // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                        // Text(
                        //   "Description",
                        //   style: TextStyle(
                        //       fontSize: 16,
                        //       color: black,
                        //       fontWeight: FontWeight.w500),
                        // ),
                        // SizedBox(
                        //   height: 5,
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
                        //         value: dropdown1,
                        //         items: items1.map((String items) {
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
                        // SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                        Text(
                          "When Do You Need The Product?",
                          style: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
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
                            controller: _datecontroller,
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
                                  _datecontroller.text = formattedDate;
                                });
                              } else {}
                            },
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
                                hintText: "dd/mm/yyyy",
                                hintStyle: TextStyle(
                                    color: hintcolor,
                                    fontFamily: "SF-Pro-Display",
                                    fontSize: 14)),
                          ),
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),

                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
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
                            controller: _rolecontroller,
                            style: TextStyle(
                                fontSize: 14,
                                color: hintcolor,
                                fontFamily: "SF-Pro-Display"),
                            minLines: 3, // Set this
                            maxLines: 6, // and this
                            keyboardType: TextInputType.multiline,

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
                                hintText: "Description",
                                hintStyle: TextStyle(
                                    color: hintcolor,
                                    fontFamily: "SF-Pro-Display",
                                    fontSize: 14)),
                          ),
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),

                        Text(
                          "Upload image",
                          style: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: brandcolor),
                                color: white),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
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
                                  SizedBox(
                                    height: 2,
                                  ),
                                  _selectedImage == null
                                      ? Image.asset(
                                          "assets/image/upload.png",
                                          height: 16,
                                          color: hintcolor,
                                        )
                                      : Image.file(
                                          _selectedImage!,
                                          height: 16,
                                          color: hintcolor,
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
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
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
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
                        //               height: 16,
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
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
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
                        //               height: 16,
                        //               color: hintcolor,
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await ApiHelper.customOrder(
                                title: _firstcontroller.text.trim().toString(),
                                size: _lastcontroller.text.trim().toString(),
                                quantity:
                                    _quantitycontroller.text.trim().toString(),
                                date: _datecontroller.text.trim().toString(),
                                description:
                                    _rolecontroller.text.trim().toString(),
                                userId: userId ?? "guest",
                                imagePath: _selectedImagePath ?? "no image");

                            setState(() {
                              isLoading = false;
                            });
                            _firstcontroller.clear();
                            _lastcontroller.clear();
                            _quantitycontroller.clear();
                            _datecontroller.clear();
                            _rolecontroller.clear();

//   SharedPreferences pref =   await SharedPreferences.getInstance();
//                          if (_firstcontroller.text.trim().length<=0) {

//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(SnackBar(
//                                       content: Text('Please enter your first name'),
//                                     ));

//                                   } else if (_lastcontroller.text.trim().length<=0) {
//                                         ScaffoldMessenger.of(context)
//                                         .showSnackBar(SnackBar(
//                                       content: Text('Please enter your last name'),
//                                     ));
//                                       }
//                                        else if (_emailcontroller.text.trim().length<=0) {
//                                         ScaffoldMessenger.of(context)
//                                         .showSnackBar(SnackBar(
//                                       content: Text('Please enter your email'),
//                                     ));
//                                       }
//                                        else if (_numbercontroller.text.trim().length<=0) {
//                                         ScaffoldMessenger.of(context)
//                                         .showSnackBar(SnackBar(
//                                       content: Text('Please enter your mobile number'),
//                                     ));
//                                       }
//                                        else if (_passcontroller.text.trim().length<=0) {
//                                         ScaffoldMessenger.of(context)
//                                         .showSnackBar(SnackBar(
//                                       content: Text('Please enter your password'),
//                                     ));
//                                       }
//                                        else if (_rolecontroller.text.trim().length<=0) {
//                                         ScaffoldMessenger.of(context)
//                                         .showSnackBar(SnackBar(
//                                       content: Text('Please enter your role'),
//                                     ));
//                                       }
// else{   Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) => FutureBuilder<
//                                                       SignUpModel?>(
//                                                   future: ApiHelper.usersignup(

//                                                     _firstcontroller.text.toString(),
//                                                     _lastcontroller.text.toString(),
//                                                     _emailcontroller.text.toString(),
//                                                     _numbercontroller.text.toString(),
//                                                     _passcontroller.text.toString(),
//                                                     _rolecontroller.text.toString()

//                                                   ),
//                                                   builder: (BuildContext
//                                                               context,
//                                                           snapshot) =>
//                                                       (snapshot.hasData) &&
//                                                               (snapshot.data!.status
//                                                          ==  "200")
//                                                           ? Login()
//                                                           : (snapshot.hasError)
//                                                               ? Text(
//                                                                   "${snapshot.error}")
//                                                               : Center(
//                                                                   child:
//                                                                       CircularProgressIndicator()))));

//                       }
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
                              'Submit',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 16,
                                  fontFamily: "SF-Pro-Display",
                                  fontWeight: FontWeight.w500),
                            )),
                          ),
                        ),

                        //         Container(
                        //            height: MediaQuery.of(context).size.height*0.08,
                        //                width: MediaQuery.of(context).size.width*0.8,
                        //                 decoration: BoxDecoration(
                        //                     borderRadius: BorderRadius.circular(30),
                        //                     border: Border.all(color:darkgradient1 ),
                        //                    color: whitetran
                        //                 ),
                        //           child:
                        //           ElevatedButton(

                        //                     onPressed: () {},
                        //                     // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                        //                     style: ElevatedButton.styleFrom(
                        //                       backgroundColor: Colors.transparent,
                        //                         elevation: 10.0,
                        //                            shape:  RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.all(Radius.circular(25)),
                        //                 ),
                        //                  minimumSize: Size(150, 15),

                        //                         textStyle:  TextStyle(color: Colors.white)),
                        //                     child:
                        //                       GradientText(
                        //     'SignUp',
                        //     style: TextStyle(

                        //         fontSize: 16.0,
                        // fontWeight: FontWeight.w500,
                        // fontFamily:  "SF-Pro-Display"
                        //     ),

                        //      gradientType: GradientType.radial,

                        //     radius: 2.5,

                        //     colors: [
                        //           darkgradient1,

                        //         darkgradient2,
                        // darkgradient3

                        //     ],

                        // ),

                        //                     //Text('Login',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                        //                   ),

                        //           ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                      ],
                    ),
                  ),
          ],
        ));
  }
}
