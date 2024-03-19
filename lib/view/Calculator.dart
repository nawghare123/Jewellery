import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/style/colors.dart';
import 'package:http/http.dart' as http;
import 'package:jewellery/view/Mycart.dart';
import 'package:jewellery/view/drawer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int _value = 6;
  int? height;
  int? finalPrice = 0;
  int goldheight = 1;
  List<String> dropdownItems = ["14 K", "16 K", "18 K", "20 K", "22 K", "24 K"];
  String? selectedValue = "14 K";
  TextEditingController _quantitycontroller = TextEditingController();

  int price = 0;

  Future<void> callAPI(String selectedValue) async {
    // Make your API call here using the selectedValue
    // For example:
    // String url = 'https://api.example.com/data?selectedValue=$selectedValue';
    // final response = await http.get(Uri.parse(url));
    var random = Random();
    setState(() {
      price = 1 + random.nextInt(7000 - 1 + 1);
      print("New Price: $price");
    });

    // Process the API response
    // if (response.statusCode == 200) {
    //   // API call success, handle the response data
    //   // ...
    // } else {
    //   // API call failed, handle the error
    //   // ...
    // }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    print("clicked...");
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(context),
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
                              onTap: _openDrawer,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 13.0, top: 5),
                                child: Image.asset(
                                  "assets/image/menu2.png",
                                  color: white,
                                  height: 25,
                                ),
                              )
                              //  Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,
                              // )

                              ),
                          // Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,),

                          Text(
                            'Calculator',
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
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  // color: bgcolor,

                  image: DecorationImage(
                    image: AssetImage('assets/image/product_bg_image.png'),
                    fit: BoxFit.fill, // Adjust the fit as per your requirement
                  ),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(children: [
                    SizedBox(
                      height: 15,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint:
                            // Row(
                            //   children: [
                            //     // Icon(
                            //     //   Icons.generating_tokens,
                            //     //   size: 16,
                            //     //   color: Colors.white,
                            //     // ),
                            //     SizedBox(
                            //       width: ,
                            //     ),
                            //     Expanded(
                            //       child: Text(
                            //         'Select Gold',
                            //         style: TextStyle(
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.white,
                            //         ),
                            //         overflow: TextOverflow.ellipsis,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Expanded(
                          child: Text(
                            '    Select Gold',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        items: dropdownItems
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) async {
                          setState(() {
                            selectedValue = value;
                          });
                          if (selectedValue != null) {
                            await callAPI(selectedValue!);
                          }
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: 160,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: gradient2,
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: IconStyleData(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.white,
                          iconDisabledColor: Colors.grey.shade200,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: gradient2,
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 13,
                    ),

                    Container(
                        // height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                // margin: EdgeInsets.only(top: 20.0),
                                height:
                                    MediaQuery.of(context).size.width * 0.18,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  margin: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(children: [
                                        Text("Gold Current Price",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "SF-Pro-Display",
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GradientText(
                                          '${goldheight} gms',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "SF-Pro-Display",
                                          ),
                                          gradientType: GradientType.radial,
                                          radius: 2.5,
                                          colors: [gradient1, gradient2],
                                        ),

                                        //  SizedBox(width: 10,),
                                        //  GradientText(
                                        //                    (height??0).toString()+"gms",
                                        //                     style: TextStyle(
                                        //                       fontSize: 14.0,
                                        //                       fontWeight: FontWeight.w500,
                                        //                        fontFamily: "SF-Pro-Display",
                                        //                     ),
                                        //                     gradientType: GradientType.radial,
                                        //                     radius: 2.5,
                                        //                     colors: [gradient1, gradient2],
                                        //                   ),
                                      ])),
                                ),
                              ),
                              Positioned(
                                left: 5.0,
                                bottom: 0.0,
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: brandcolor,
                                    inactiveTrackColor: white,
                                    thumbColor: gradient1,
                                    // overlayColor:brandcolor,
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 8.0),
                                    overlayShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 0),
                                  ),
                                  child: Slider(
                                    // value: height.toDouble(),
                                    min: 1.0,
                                    max: 10.0,
                                    value: (goldheight ?? 1).toDouble(),
                                    divisions: 100,
                                    onChanged: (double newVal) {
                                      setState(() {
                                        goldheight = newVal.toInt();
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),

                    SizedBox(
                      height: 15,
                    ),
                    GradientText(
                      '₹ ${goldheight * price}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: "SF-Pro-Display",
                      ),
                      gradientType: GradientType.radial,
                      radius: 2.5,
                      colors: [gradient1, gradient2],
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    //     Container(

                    //       height: MediaQuery.of(context).size.height*0.08,

                    //       width: MediaQuery.of(context).size.width,

                    //       decoration: BoxDecoration(

                    //         borderRadius: BorderRadius.circular(15),

                    //         color: white

                    //       ),

                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 15),
                    //     child:

                    //      Row(

                    //       children: [
                    //       Text("Gold Making Charges",style: TextStyle(fontSize: 14,  fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500))
                    //      ,
                    //      SizedBox(width: 10,),
                    //      GradientText(
                    //                         '25%',
                    //                         style: TextStyle(
                    //                           fontSize: 14.0,
                    //                           fontWeight: FontWeight.w500,
                    //                            fontFamily: "SF-Pro-Display",
                    //                         ),
                    //                         gradientType: GradientType.radial,
                    //                         radius: 2.5,
                    //                         colors: [gradient1, gradient2],
                    //                       ),

                    //       ])
                    //     ),
                    //     ),

                    //  SizedBox(height: 15,),
                    //      GradientText(
                    //                         '₹ 14,852.5',
                    //                         style: TextStyle(
                    //                           fontSize:   16.0,
                    //                           fontWeight: FontWeight.w500,
                    //                            fontFamily: "SF-Pro-Display",
                    //                         ),
                    //                         gradientType: GradientType.radial,
                    //                         radius: 2.5,
                    //                         colors: [gradient1, gradient2],
                    //                       ),

                    //  SizedBox(height: 15,),

                    //     Container(

                    //       height: MediaQuery.of(context).size.height*0.08,

                    //       width: MediaQuery.of(context).size.width,

                    //       decoration: BoxDecoration(

                    //         borderRadius: BorderRadius.circular(15),

                    //         color: white

                    //       ),

                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 15),
                    //     child:

                    //      Row(

                    //       children: [
                    //       Text("Daymand  Making Charges",style: TextStyle(fontSize: 14,  fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500))
                    //      ,
                    //      SizedBox(width: 10,),
                    //      GradientText(
                    //                         '0%',
                    //                         style: TextStyle(
                    //                           fontSize: 14.0,
                    //                           fontWeight: FontWeight.w500,
                    //                            fontFamily: "SF-Pro-Display",
                    //                         ),
                    //                         gradientType: GradientType.radial,
                    //                         radius: 2.5,
                    //                         colors: [gradient1, gradient2],
                    //                       ),

                    //       ])
                    //     ),
                    //     ),

                    //  SizedBox(height: 15,),
                    //      GradientText(
                    //                         '₹ 0',
                    //                         style: TextStyle(
                    //                           fontSize:   16.0,
                    //                           fontWeight: FontWeight.w500,
                    //                            fontFamily: "SF-Pro-Display",
                    //                         ),
                    //                         gradientType: GradientType.radial,
                    //                         radius: 2.5,
                    //                         colors: [gradient1, gradient2],
                    //                       ),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            gradient1,
                            gradient2,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          finalPrice = goldheight *
                              price *
                              int.parse(
                                  _quantitycontroller.text.toString() == ""
                                      ? "0"
                                      : _quantitycontroller.text.toString());
                          setState(() {});
                        },
                        cursorColor: white,
                        style: TextStyle(
                            color: Colors.white), // Set the text color to white
                        controller: _quantitycontroller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusColor: gradient2,
                          hintText: "Quantity",
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          fillColor: gradient1,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 35,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Price",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "SF-Pro-Display",
                          ),
                        ),
                        // Text("${_quantitycontroller.text.toString()}"),
                        Text(
                          '₹ ${finalPrice}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "SF-Pro-Display",
                          ),
                        )
                      ],
                    )

                    //    SliderTheme(
                    //   data: SliderTheme.of(context).copyWith(
                    //      activeTrackColor: Colors.white,
                    //     thumbColor: Color(0xffeb1555),
                    //     overlayColor: Color(0x29eb1555),
                    //     thumbShape:
                    //         RoundSliderThumbShape(enabledThumbRadius: 10.0),
                    //     overlayShape:
                    //         RoundSliderThumbShape(enabledThumbRadius: 20.0),
                    //   ),
                    //   child: Slider(
                    //    // value: height.toDouble(),
                    //     min: 100.0,
                    //     max: 220.0,
                    //     divisions: 120,
                    //     onChanged: (double newVal) {
                    //       setState(() {
                    //         //height = newVal.toInt();
                    //       });
                    //     },
                    //   ),
                    // ),
                  ]),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
