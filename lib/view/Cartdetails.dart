import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Mycart.dart';
import 'package:jewellery/view/invoice.dart';

class CartDetails extends StatefulWidget {
  const CartDetails({super.key});

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
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
                              //Navigator.pop(context);
                            },
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
                                child: SvgPicture.asset("assets/image/Buy.svg",
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
                color: bgcolor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: white),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Product Name",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("Gold bangle",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Size",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("2.5 ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("4 Pcs ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "weight",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("10gms",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Image.asset("assets/image/divider.png"),
                  // SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: white),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Product Name",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("Gold bangle",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "SF-Pro-Display",
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Size",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("2.5 ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "SF-Pro-Display",
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("4 Pcs ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "SF-Pro-Display",
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "weight",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text("10gms",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "SF-Pro-Display",
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Image.asset("assets/image/divider.png"),
// ,
//        Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25),color: white
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(children: [

//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//               Text("Product Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
//               Text("Gold bangle",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500))
//             ],)
//               ,
//         Divider(),

//          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//               Text("Size",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
//               Text("2.5 ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500))
//             ],)
//               ,
//         Divider(),

//          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//               Text("Quantity",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
//               Text("4 Pcs ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500))
//             ],)
//               ,
//         Divider(),

//          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//               Text("weight",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
//               Text("10gms",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500))
//             ],)
//               ,

//           ],),
//         ),
//       ),
//     )
//    ,
                  SizedBox(
                    height: 8,
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     height: MediaQuery.of(context).size.height * 0.07,
                  //     width: MediaQuery.of(context).size.width * 04,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(30),
                  //         gradient: LinearGradient(
                  //           begin: Alignment.centerLeft,
                  //           end: Alignment.centerRight,
                  //           colors: [
                  //             gradient2,
                  //             gradient1,
                  //           ],
                  //         )),
                  //     child: Center(
                  //         child: Text(
                  //       'Back to home ',
                  //       style: TextStyle(
                  //           color: white,
                  //           fontSize: 16,
                  //           fontFamily: "SF-Pro-Display",
                  //           fontWeight: FontWeight.w500),
                  //     )),
                  //   ),
                  // ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InvoiceScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
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
                          'Check Invoice ',
                          style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontFamily: "SF-Pro-Display",
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  ),

                  //         Container(
                  //  decoration: BoxDecoration(
                  //    borderRadius: BorderRadius.circular(25),
                  //    gradient: LinearGradient(colors:
                  //        [
                  //            gradient2,
                  //          gradient1,

                  //      ],)
                  //  ),
                  //   child: ElevatedButton(

                  //         onPressed: () {

                  //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>CartDetails()));
                  //         },
                  //         // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: Colors.transparent,
                  //             elevation: 10.0,
                  //                shape:  RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(25)),
                  //     ),
                  //      minimumSize: Size(300, 45),

                  //             textStyle:  TextStyle(color: Colors.white)),
                  //         child:  Text('Back to home',style: TextStyle(fontSize: 14,fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500),),
                  //       ),
                  //              ),
                ],
              ),
            ),
          )
        ],
      ))),
    );
  }
}
