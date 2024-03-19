
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/Other/snackbar.dart';
import 'package:jewellery/otp.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Login/LoginModel.dart';
import 'package:jewellery/view/Signup/Signup.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/bottomnavbar.dart';
import 'package:jewellery/view/forgetpass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Login extends StatefulWidget {
  const Login({super.key});


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _numbercontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
 bool passwordVisible = false;  

 
  @override
    void initState(){
      super.initState();
      passwordVisible=true;
    }   
    @override
  void dispose() {
    _numbercontroller.dispose();
    _passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      body:
      SingleChildScrollView(
        child: Stack(
          children: [
        Container(
            width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,
          child: 
          //SvgPicture.asset("assets/image/splash.svg",fit: BoxFit.cover)
          //  Image.asset("assets/image/bgimg3.png", fit: BoxFit.cover,)
            Image.asset("assets/image/backgroundimg.jpg", fit: BoxFit.fill,)

           
          ),
   
   Column(
     children: [
       SizedBox(height:MediaQuery.of(context).size.height*0.09),
        Center(child: Image.asset("assets/image/logo.png", )),
  
       SizedBox(height: MediaQuery.of(context).size.height*0.1),


          Container(
             height: MediaQuery.of(context).size.height*0.07,
                 width: MediaQuery.of(context).size.width*0.8,
                decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),

                        border: Border.all(color:brandcolor ),

                       color: white

                    ),



            child: TextFormField(

              style: TextStyle(fontSize: 16,color: black, fontFamily: "SF-Pro-Display",
),

                                  controller: _numbercontroller,
                                   keyboardType: TextInputType.number,
                              //         validator: (value) {
                              //   if (value!.length != 10 || value.isEmpty) {
                              //     return "Mobile Number must be of 10 digit";
                              //   }
                              //   return null;
                              // },
                                  //    autovalidateMode:
                                  // AutovalidateMode.onUserInteraction,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLength: 10,
                                   
                               decoration: InputDecoration(

                                      fillColor: white,
                                      focusColor:white,
                                     counterText: '',
                                contentPadding: EdgeInsets.all(10),

                                       errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red)),
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
                                      hintText:"Mobile Number",

                                      hintStyle:
                                      TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
                                ),

          ),
    
       SizedBox(height: MediaQuery.of(context).size.height*0.03),

    
          Container(
             height: MediaQuery.of(context).size.height*0.07,
                 width: MediaQuery.of(context).size.width*0.8,
                 
            
                    decoration: BoxDecoration(
  
                        borderRadius: BorderRadius.circular(15),
  
                        border: Border.all(color:brandcolor ),
  
                       color: white
  
                    ),
  
           
            
            child: TextFormField( obscureText: passwordVisible, 
                                  controller: _passcontroller,
                                                style: TextStyle(fontSize: 16,color: black, fontFamily: "SF-Pro-Display",),

                               decoration: InputDecoration(
                                     
                                        suffixIcon: IconButton(
                     icon: Icon(passwordVisible
                         ? Icons.visibility
                         : Icons.visibility_off),
                     onPressed: () {
                       setState(
                         () {
                           passwordVisible = !passwordVisible;
                         },
                       );
                     },
                   ),
                                      fillColor: white,
                                      focusColor:white,
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
                                      hintText:"Password",
                                      
                                      hintStyle:
                                      TextStyle(color: hintcolor, fontSize: 14)),
                                ),
          ),
    
SizedBox(height: MediaQuery.of(context).size.height*0.05),

                             
                        InkWell(onTap: () async{

                        
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Otp()));
                           if (_numbercontroller!.text.isEmpty) {
                                    showCustomSnackBar('enter phone number', context);
                                  }
                                  else if (_numbercontroller.text.length != 10 ) {
                                    showCustomSnackBar('enter 10 digit mobile number', context);
                                  }else if (_passcontroller!.text.isEmpty) {
                                    showCustomSnackBar('enter password', context);
                                  }else if (_passcontroller!.text.length < 6) {
                                    showCustomSnackBar('password should be 6 digit', context);
                                  }
                     
                     else{
                       ApiHelper.userlogin(_numbercontroller.text,_passcontroller.text,context);}
    //                         Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                               builder: (context) => FutureBuilder<
    //                                   LoginModel?>(
    //                                   future:
    //                                   ApiHelper.userlogin(_emailcontroller.text,_passcontroller.text),
    //                                   builder: (BuildContext context,
    //                                       snapshot) {
    //                                     if (snapshot.hasData) {
    //                                       final userdata =
    //                                           snapshot.data;
    //
    //                                       if (userdata!.status ==
    //                                           200) {
    //                                        print(userdata.message??'');
    //
    //                                         return Otp();
    //                                       } else {
    //                                         // ScaffoldMessenger.of(context)
    //                                         //     .showSnackBar(SnackBar(
    //                                         //   content: Text(userdata!.message
    //                                         //       .toString()),
    //                                         // ));
    //                                         // msg = userdata!.message
    //                                         //     .toString();
    //                                         return Login();
    //                                       }
    //                                     } else if (snapshot.hasError) {
    //                                       return Text(
    //                                           "${snapshot.error}");
    //                                     }
    //                                     return Container(
    //                                         height:
    //                                         MediaQuery.of(context)
    //                                             .size
    //                                             .height,
    //
    //                                         child: Column(
    //                                             mainAxisAlignment:
    //                                             MainAxisAlignment
    //                                                 .start,
    //                                             children: [
    //                                               LinearProgressIndicator(
    //
    //                                                 valueColor:
    //                                                 AlwaysStoppedAnimation(
    //                                                     Colors
    //                                                         .white),
    //                                                 minHeight: 5,
    //                                               )
    //                                                 ]));
    // })),
    //);
    

    // await Future.delayed(Duration(seconds: 1));
    // if (msg != '') {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(
    //     content: Text(msg),
    //   ));
    // }
    },

                          child: Container(
                            height: MediaQuery.of(context).size.height*0.07,
                            width: MediaQuery.of(context).size.width*0.8,
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(30),
                                           
                                           gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: 
                                               [
                             gradient2,
                           gradient1,
                                         
                              
                                             ],)
                                         ),
                        
                                         child: Center(child:  Text('Login',style: TextStyle(color:white,fontSize: 16,fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500),)),
                                       
                              
                              
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
                 
  //                     onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));},
  //                     // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.transparent,
  //                         elevation: 10.0,
  //                            shape:  RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(25)),
  //                 ),
  //                   minimumSize: Size(300, 15),
                       
  //                         textStyle:  TextStyle(color: Colors.white)),
  //                     child:  
  //                       GradientText(
  //     'Login',
  //     style: TextStyle(
  // fontFamily: "SF-Pro-Display",
  //         fontSize: 16.0,
  // fontWeight: FontWeight.w500
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
    
    
     SizedBox(height: MediaQuery.of(context).size.height*0.02),
     
    InkWell(onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPage()));
    },child: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Forgot Password",style: TextStyle(fontSize: 14,color: hintcolor,fontWeight: FontWeight.w400),),SizedBox(width: 5,),
       Icon(Icons.arrow_forward_outlined,color: hintcolor,size: 18,)
      ],
    )),
   

     ],
   ),



        
          ],
        ),
      )


    );
  }




}




// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:jewellery/otp.dart';
// import 'package:jewellery/style/colors.dart';
// import 'package:jewellery/view/Signup/Signup.dart';
// import 'package:jewellery/view/bottomnavbar.dart';
// import 'package:jewellery/view/forgetpass.dart';
// import 'package:simple_gradient_text/simple_gradient_text.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   //  TextEditingController _emailcontroller = TextEditingController();
//   TextEditingController _numbercontroller = TextEditingController();
  
//   TextEditingController _passcontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
      
//       body:
//       SingleChildScrollView(
//         child: Stack(
//           children: [
//         Container(
//             width: MediaQuery.of(context).size.width,
//        height: MediaQuery.of(context).size.height,
//           child: 
//           //SvgPicture.asset("assets/image/splash.svg",fit: BoxFit.cover)
//           //  Image.asset("assets/image/bgimg3.png", fit: BoxFit.cover,)
//             Image.asset("assets/image/backgroundimg.jpg", fit: BoxFit.cover,)

           
//           ),
   
//    Column(
//      children: [
//        SizedBox(height:MediaQuery.of(context).size.height*0.09),
//         Center(child: Image.asset("assets/image/logo.png", )),
  
//        SizedBox(height: MediaQuery.of(context).size.height*0.1),
          


//           Container(
//              height: MediaQuery.of(context).size.height*0.07,
//                  width: MediaQuery.of(context).size.width*0.8,
//                   // decoration: BoxDecoration(
//                   //     borderRadius: BorderRadius.circular(25),
//                   //     border: Border.all(color:whitetran ),
//                   //    color: whitetran
//                   // ),
         
         
//                     decoration: BoxDecoration(
  
//                         borderRadius: BorderRadius.circular(15),
  
//                         border: Border.all(color:brandcolor ),
  
//                        color: white
  
//                     ),
  
           
         
//             child: TextFormField(

//               style: TextStyle(fontSize: 14,color: hintcolor, fontFamily: "SF-Pro-Display",
// ),
              
//                                   controller: _numbercontroller,
//                                    keyboardType: TextInputType.number,
//                             inputFormatters: <TextInputFormatter>[
//                               FilteringTextInputFormatter.digitsOnly
//                             ],
//                             maxLength: 10,
//                                     //  inputFormatters: [
//                                     //                                         FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                                     //                                       ],
//                                     //                                       keyboardType:
//                                     //                                           TextInputType.phone,
//                                decoration: InputDecoration(
                             
//                                       fillColor: white,
//                                       focusColor:white,
//                                      counterText: '',
//                                 contentPadding: EdgeInsets.all(10),
                                    
//                                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red)),
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
//                                       hintText:"Mobile Number",

//                                       hintStyle:
//                                       TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
//                                 ),
//           ),
    
//        SizedBox(height: MediaQuery.of(context).size.height*0.03),

    
//           Container(
//              height: MediaQuery.of(context).size.height*0.07,
//                  width: MediaQuery.of(context).size.width*0.8,
//                   // decoration: BoxDecoration(
//                   //     borderRadius: BorderRadius.circular(25),
//                   //     border: Border.all(color:whitetran ),
//                   //    color: whitetran
//                   // ),
            
            
            
//                     decoration: BoxDecoration(
  
//                         borderRadius: BorderRadius.circular(15),
  
//                         border: Border.all(color:brandcolor ),
  
//                        color: white
  
//                     ),
  
           
            
//             child: TextFormField(
//                                   controller: _passcontroller,
//                                                 style: TextStyle(fontSize: 14,color: hintcolor, fontFamily: "SF-Pro-Display",),

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
//                                       hintText:"Password",
                                      
//                                       hintStyle:
//                                       TextStyle(color: hintcolor, fontSize: 14)),
//                                 ),
//           ),
    
// SizedBox(height: MediaQuery.of(context).size.height*0.05),

                             
                    

//    InkWell(onTap: () async{

     
                          
//                           if {
//                             ApiHelper.userlogin(_emailcontroller.text,_passcontroller.text,context);
//     //                         Navigator.push(
//     //                           context,
//     //                           MaterialPageRoute(
//     //                               builder: (context) => FutureBuilder<
//     //                                   LoginModel?>(
//     //                                   future:
//     //                                   ApiHelper.userlogin(_emailcontroller.text,_passcontroller.text),
//     //                                   builder: (BuildContext context,
//     //                                       snapshot) {
//     //                                     if (snapshot.hasData) {
//     //                                       final userdata =
//     //                                           snapshot.data;
//     //
//     //                                       if (userdata!.status ==
//     //                                           200) {
//     //                                        print(userdata.message??'');
//     //
//     //                                         return Otp();
//     //                                       } else {
//     //                                         // ScaffoldMessenger.of(context)
//     //                                         //     .showSnackBar(SnackBar(
//     //                                         //   content: Text(userdata!.message
//     //                                         //       .toString()),
//     //                                         // ));
//     //                                         // msg = userdata!.message
//     //                                         //     .toString();
//     //                                         return Login();
//     //                                       }
//     //                                     } else if (snapshot.hasError) {
//     //                                       return Text(
//     //                                           "${snapshot.error}");
//     //                                     }
//     //                                     return Container(
//     //                                         height:
//     //                                         MediaQuery.of(context)
//     //                                             .size
//     //                                             .height,
//     //
//     //                                         child: Column(
//     //                                             mainAxisAlignment:
//     //                                             MainAxisAlignment
//     //                                                 .start,
//     //                                             children: [
//     //                                               LinearProgressIndicator(
//     //
//     //                                                 valueColor:
//     //                                                 AlwaysStoppedAnimation(
//     //                                                     Colors
//     //                                                         .white),
//     //                                                 minHeight: 5,
//     //                                               )
//     //                                                 ]));
//     // })),
//     //);
//     }

//     // await Future.delayed(Duration(seconds: 1));
//     // if (msg != '') {
//     //   ScaffoldMessenger.of(context)
//     //       .showSnackBar(SnackBar(
//     //     content: Text(msg),
//     //   ));
//     // }
    

// // Navigator.push(context, MaterialPageRoute(builder: (context)=>Otp()));
//                         },
//                           child: Container(
//                             height: MediaQuery.of(context).size.height*0.07,
//                             width: MediaQuery.of(context).size.width*0.8,
//                                          decoration: BoxDecoration(
//                                            borderRadius: BorderRadius.circular(30),
                                           
//                                            gradient: LinearGradient(
//                                             begin: Alignment.centerLeft,
//                                     end: Alignment.centerRight,
//                                     colors: 
//                                                [
//                              gradient2,
//                            gradient1,
                                         
                              
//                                              ],)
//                                          ),
                        
//                                          child: Center(child:  Text('Login',style: TextStyle(color:white,fontSize: 16,fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500),)),
                                       
                              
                              
//                                ),
//                         ),
                 
//   //         Container(
//   //            height: MediaQuery.of(context).size.height*0.08,
//   //                width: MediaQuery.of(context).size.width*0.8,
//   //                 decoration: BoxDecoration(
//   //                     borderRadius: BorderRadius.circular(30),
//   //                     border: Border.all(color:darkgradient1 ),
//   //                    color: whitetran
//   //                 ),
//   //           child: 
//   //           ElevatedButton(
                 
//   //                     onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));},
//   //                     // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
//   //                     style: ElevatedButton.styleFrom(
//   //                       backgroundColor: Colors.transparent,
//   //                         elevation: 10.0,
//   //                            shape:  RoundedRectangleBorder(
//   //                 borderRadius: BorderRadius.all(Radius.circular(25)),
//   //                 ),
//   //                   minimumSize: Size(300, 15),
                       
//   //                         textStyle:  TextStyle(color: Colors.white)),
//   //                     child:  
//   //                       GradientText(
//   //     'Login',
//   //     style: TextStyle(
//   // fontFamily: "SF-Pro-Display",
//   //         fontSize: 16.0,
//   // fontWeight: FontWeight.w500
//   //     ),
  
//   //      gradientType: GradientType.radial,
  
//   //     radius: 2.5,
  
//   //     colors: [
//   //           darkgradient1,
  
//   //         darkgradient2,
//   // darkgradient3

//   //     ],
  
//   // ),

        
//   //                     //Text('Login',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//   //                   ),
             
            
//   //           ),
    
    
//      SizedBox(height: MediaQuery.of(context).size.height*0.02),
     
//     InkWell(onTap: (){
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPage()));
//     },child: Row(mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("Forgot Password",style: TextStyle(fontSize: 14,color: hintcolor,fontWeight: FontWeight.w400),),SizedBox(width: 5,),
//        Icon(Icons.arrow_forward_outlined,color: hintcolor,size: 18,)
//       ],
//     )),
   

//      ],
//    ),



        
//           ],
//         ),
//       )


//     );
//   }




// }