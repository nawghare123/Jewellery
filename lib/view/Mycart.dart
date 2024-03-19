import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/Cartdetails.dart';
import 'package:jewellery/view/Mycartconfrim.dart';
import 'package:jewellery/view/bottomnavbar.dart';
import 'package:jewellery/view/countjewellery.dart';
import 'package:jewellery/view/getCartModel.dart';
import 'package:jewellery/view/home/home1.dart';
import 'package:jewellery/view/updateaddress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  GetCardModel? getCardModel;
  bool isloading = false;
   TextEditingController _addresscontroller = TextEditingController();
  List itemTotal = [];
  int totalAmount = 0;
  int totalQuantity = 0;


  @override
  void initState() {
    getCartList();

getUserData();
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

  String? userId;
  String? state;
  String? city;
  String? pincode;
  String? address;




void calculateTotalQuantity() {
    totalQuantity = 0;
    getCardModel!.data!.forEach((e) {
      int thisVar = 0;
      List<Map<String, dynamic>>.from(json.decode(e.variant!
              .toString()
              .replaceAllMapped(
                  RegExp(r'(\w+):'), (match) => '"${match.group(1)}":')))
          .forEach((e) {
        int quantity = parseQuantity(e); setState(() {
          totalQuantity += quantity;
        });
      });
    });
  }

  
//  Future<void> getUserData() async {
//     setState(() {
//       isloading = true;
//     });
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     // userId = await prefs.getInt('id').toString();
//     // await prefs.getInt('is_phone_verified');

   
  

//     setState(() {
//       isloading = false;
//     });
//   }
  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = await prefs.getInt('id').toString();
    await prefs.getInt('is_phone_verified');
 
    state = await prefs.getString('state');
    city = await prefs.getString('city');
    address = await prefs.getString('address')??'';
    
    pincode = await prefs.getString('pincode') ?? "Guest";
    print("userid $userId, state $state, city $city, address $address, pincode $pincode");
    setState(() {});
  }

  Future<void> getCartList() async {
    try {
      getCardModel = await ApiHelper.getCartList();
      getCardModel!.data!.forEach((e) {
        int thisVar = 0;
        List<Map<String, dynamic>>.from(json.decode(e.variant!
                .toString()
                .replaceAllMapped(
                    RegExp(r'(\w+):'), (match) => '"${match.group(1)}":')))
            .forEach((e) {
          // print("====>>>> $e");
          int quantity = parseQuantity(e);
          // print("=====>>>> $quantity"); // Output: 3
          // thisVar = e["price"] * e["quantity"];

          // thisVar = e["price"] * e["quantity"];

          setState(() {
            totalQuantity += quantity;
          });
          // print("====>>>> quantity: ${totalQuantity}");
          // print(e["quantity"]);
        });

        // totalAmount += thisVar;
        itemTotal.add([e.productName, thisVar]);
      });
    } catch (e) {}
    setState(() {
      isloading = false;
    });
    // print("====>>>> Last quantity: ${totalQuantity}");
  }

  int parseQuantity(Map<String, dynamic> data) {
    if (data.containsKey('quantity')) {
      dynamic quantityValue = data['quantity'];
      if (quantityValue is int) {
        return quantityValue;
      } else if (quantityValue is String) {
        return int.tryParse(quantityValue) ?? 0;
      }
    }
    return 0; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: bgcolor,
        body: 
        isloading
          ? 
         Center(child: CircularProgressIndicator())
       : Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/product_bg_image.png'),
          fit: BoxFit.fill, // Adjust the fit as per your requirement
        ),
      ),
      //   height: MediaQuery.of(context).size.height,

      child: ListView(
        primary: true,
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [gradient2, gradient1])),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
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
                        Center(
                          child: Text(
                            'My Cart',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20.0,
                                fontFamily: "Alhadara-DEMO"),
                          ),
                        ),

                        //Image.asset("assets/image/notification.png",color: white,),

                      //   Row(
                      //     children: [
                      //       // SvgPicture.asset("assets/image/notification.svg",
                      //       //     color: white),

                      //       // SizedBox(width: 15),

                      //       //  Image.asset("assets/image/cart.png"),

                      //       // InkWell(
                      //       //     onTap: () {
                      //       //       Navigator.push(
                      //       //           context,
                      //       //           MaterialPageRoute(
                      //       //               builder: (context) => MyCart()));
                      //       //     },
                      //       //     child: SvgPicture.asset(
                      //       //         "assets/image/Buy.svg",
                      //       //         color: white)),

                      //       // SizedBox(width: 10),
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
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                // color: bgcolor,

                image: DecorationImage(
                  image: AssetImage('assets/image/product_bg_image.png'),
                  fit: BoxFit.cover, // Adjust the fit as per your requirement
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: getCardModel == null || isloading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: getCardModel!.data!
                            .map(
                              (e) => Column(
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CountJeweller(
                                                          productid: int.parse(
                                                              e.productId ??
                                                                  "0"),
                                                        )));
                                          },
                                          child: Container(
                                            //  height: MediaQuery.of(context).size.height*0.3,
                                            decoration: BoxDecoration(
                                                color: white,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
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
                                                      color: white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(30),
                                                        bottomLeft:
                                                            Radius.circular(30),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Image.network(
                                                        "${e.image!}",
                                                        height: 100,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: MediaQuery.of(context)
                                                  //           .size
                                                  //           .width *
                                                  //       0.0,
                                                  // ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        e.productName!.length <
                                                                20
                                                            ? e.productName!
                                                            : "${e.productName!.substring(0, 18)}...",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "SF-Pro-Display",
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),

                                                      // variant start -------

                                                      Column(
                                                        children: List<
                                                            Map<String,
                                                                dynamic>>.from(json.decode(e
                                                            .variant!
                                                            .toString()
                                                            .replaceAllMapped(
                                                                RegExp(
                                                                    r'(\w+):'),
                                                                (match) =>
                                                                    '"${match.group(1)}":'))).map(
                                                            (e) {
                                                          // print("=====>>>> $e");
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                "variant: " +
                                                                    e["variant"]
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        "SF-Pro-Display",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              // Text(
                                                              //   " price: " +
                                                              //       e["price"]
                                                              //           .toString(),
                                                              //   style: TextStyle(
                                                              //       fontSize:
                                                              //           14,
                                                              //       fontFamily:
                                                              //           "SF-Pro-Display",
                                                              //       fontWeight:
                                                              //           FontWeight
                                                              //               .w400),
                                                              // ),
                                                              Text(
                                                                ", quantity: " +
                                                                    e["quantity"]
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        "SF-Pro-Display",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          );
                                                        }).toList(),
                                                      ),
                                                      // variant end -------

                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 20,
                                        right: 13,
                                        child: GestureDetector(
                                          onTap: () async {
                                            getCardModel!.data!.remove(e);
                                            setState(() {
                                              isloading = true;
                                            });
                                            var request = http.Request(
                                                'POST',
                                                Uri.parse(
                                                    'https://veejayjewels.com/api/v1/products/discard?id=${e.id}'));

                                            http.StreamedResponse response =
                                                await request.send();

                                            if (response.statusCode == 200) {
                                              print(await response.stream
                                                  .bytesToString());
                                            } else {
                                              print(response.reasonPhrase);
                                            }
                                            setState(() {
                                              isloading = false;
                                            });
                                            calculateTotalQuantity();
                                          },
                                          child: Icon(Icons.delete),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  Image.asset("assets/image/divider.png"),
                                ],
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Image.asset("assets/image/divider.png"),
                            )
                            .toList(),
                      ),
              ),
            ),
          ),


    (getCardModel!.data != null && getCardModel!.data!.isEmpty)?
Column(  mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
  children: [
     SizedBox(height: MediaQuery.of(context).size.height * 0.2),
    
    Icon(Icons.production_quantity_limits, size: 150),
     SizedBox(height: MediaQuery.of(context).size.height * 0.2),
    Text("Cart is Empty", style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontFamily:
                                                                        "SF-Pro-Display",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),),
    SizedBox(height: 20),
        GestureDetector(
    
                    onTap: () async {
    
                   Navigator.pushReplacement(context,  MaterialPageRoute(
    
                                                        builder: (context) => Home1()));
    
                    },
    
                    child: Padding(
    
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
    
                      child: Container(
    
                        decoration: BoxDecoration(
    
                          color: gradient1,
    
                          borderRadius: BorderRadius.circular(20),
    
                        ),
    
                        child: Padding(
    
                          padding: const EdgeInsets.all(8.0),
    
                          child: Center(
    
                            child: Text(
    
                              style: TextStyle(
    
                                  color: white,
    
                                  fontWeight: FontWeight.w400,
    
                                  fontSize: 20.0,
    
                                  fontFamily: "Alhadara-DEMO"),
    
                              "   Continue Shopping   ",
    
                            ),
    
                          ),
    
                        ),
    
                      ),
    
                    ),
    
                  ),
  ],
)
              :
          
         
          Column(
            children: [
              Container(
                // color: bgcolor,
                child: Center(
                  child: Text(
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                        fontFamily: "Alhadara-DEMO"),
                    // "Total Amount: " +
                    //     totalAmount.toString() +
                    "Total Quantity: " + totalQuantity.toString(),
                  ),
                ),
              ),
              
              
              

// Padding(
//   padding: const EdgeInsets.all(15.0),
//   child:   Container(
  
//                    height: MediaQuery.of(context).size.height * 0.07,
  
//            width: MediaQuery.of(context).size.width,
  
//            decoration: BoxDecoration(
  
//              borderRadius: BorderRadius.circular(15),
  
//              border: Border.all(color: brandcolor),
  
//              color: white,
  
//            ),
  
  
  
//    child: Padding(
//      padding: const EdgeInsets.all(10.0),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: [
//          Icon(Icons.location_on),
//                     SizedBox(width: 10,),
//          Center(child: Text("Address:  ${address.toString()}",style: TextStyle(fontSize: 14,color:Colors.black),)),
//      Spacer(),
//      InkWell(
//    onTap: (){
     
//      Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateAddress() ));
//       // Get.to(UpdateAddress());
     
//      },
//        child: Icon(Icons.edit))
//        ],
//      ),
//    ),
  
//                     ),
// )

               
//               Container(
//              height: MediaQuery.of(context).size.height * 0.07,
//                             width: MediaQuery.of(context).size.width * 0.8,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(30),
//                                 gradient: LinearGradient(
//                                   begin: Alignment.centerLeft,
//                                   end: Alignment.centerRight,
//                                   colors: [
//                                     gradient2,
//                                     gradient1,
//                                   ],
//                                 )),child:Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  
//                                   children: [


//  ],)
//               ),
              
            SizedBox(height: 15,),


              GestureDetector(
                onTap: ()  {

                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyCartConfrim()
                                            ));
//                   setState(() {
//                     isloading = true;
//                   });
//                   List cart = [];
//                   getCardModel!.data!.forEach((element) {
//                     String thisVar = "";
//                     String thisQuan = "";
//                     List<Map<String, dynamic>>.from(json.decode(element.variant!
//                         .toString()
//                         .replaceAllMapped(RegExp(r'(\w+):'),
//                             (match) => '"${match.group(1)}":'))).forEach((e) {
//                       thisVar = e["variant"].toString();
//                       thisQuan = e["quantity"].toString();
//                     });
//                     cart.add({
//                       "product_id": element.productId,
//                       "quantity": thisQuan,
//                       "variation": thisVar
//                     });
//                   });
//                   print("$state $city, $pincode $address");
//                   try {
//                                     await ApiHelper.placeOrder(
//                                         userId ?? "0",
//                                         "$state $city, $pincode $address",
//                                         cart);
//                                     getCardModel!.data = [];
//                                     setState(() {});
//                                     calculateTotalQuantity();
//                                     await showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(

//                                           title:Column(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             children:[
// Image.asset("assets/image/cartimg1.png", width: MediaQuery.of(context).size.width * 0.3),
// SizedBox(height:10)
// ,                                                Text('Success'),
//                                           ]),
                                      
//                                           content: Text('Your Order Placed.'),
//                                           actions: <Widget>[
//                                             TextButton(
//                                               child: Text(
//                                                 'OK',
//                                                 style:
//                                                     TextStyle(color: gradient1),
//                                               ),
//                                               onPressed: () {
//                                                 Navigator.of(context)
//                                                     .pop(); // Close the dialog
//                                               },
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
                                  
//                                       // (route) => false,
//                                     );
//                                   } catch (e) {}
//                                   setState(() {
//                                     isloading = false;
//                                   });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: gradient1,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0,
                              fontFamily: "Alhadara-DEMO"),
                          "   Next   ",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
 
         
         
         
          // Container(
          //   color: bgcolor,
          //   child: Text(
          //     style: TextStyle(
          //         fontWeight: FontWeight.w400,
          //         fontSize: 20.0,
          //         fontFamily: "Alhadara-DEMO"),
          //     "Total Quantity: " + totalQuantity.toString(),
          //   ),
          // ),
        ],
      ),
    ));


  }
}
