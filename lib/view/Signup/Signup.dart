import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Login/Login.dart';
import 'package:jewellery/Other/snackbar.dart';
import 'package:jewellery/view/Signup/Signupmodel.dart';
import 'package:jewellery/view/Signup/createprofilesecond.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SignUp extends StatefulWidget {
   SignUp({super.key,this.role});
  String? role;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>  {
  // final formGlobalKey = GlobalKey < FormState > ();
   TextEditingController _emailcontroller = TextEditingController();
   TextEditingController _firstcontroller = TextEditingController();
     TextEditingController _lastcontroller = TextEditingController();
 TextEditingController _numbercontroller = TextEditingController();
   TextEditingController _passcontroller = TextEditingController();
   TextEditingController _confpasscontroller = TextEditingController();
      TextEditingController _rolecontroller = TextEditingController();
 bool passwordVisible=false;  
  bool passwordVisiblecon =false; 


  @override
    void initState(){
      super.initState();
      passwordVisible=true;
      passwordVisiblecon =true;
    } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
resizeToAvoidBottomInset: false,
      body:
      Stack(
      children: [
        Container(
        width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
        
      
      child: 
      //SvgPicture.asset("assets/image/splash.svg",fit: BoxFit.cover)
       Image.asset("assets/image/backgroundimg.jpg", fit: BoxFit.fill,)

       
      ),
   
   Padding(
         padding: const EdgeInsets.only(left:30.0,right: 30),
     child: ListView(
        shrinkWrap: true,
       children: [
          SizedBox(height:MediaQuery.of(context).size.height*0.09),
          Center(child: Image.asset("assets/image/logo.png", )),
     
         SizedBox(height: MediaQuery.of(context).size.height*0.1),
   
        Container(
           height: MediaQuery.of(context).size.height*0.07,
               width: MediaQuery.of(context).size.width*0.8,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(25),
                //     border: Border.all(color:whitetran ),
                //    color: whitetran
                // ),
         
         
                  decoration: BoxDecoration(
     
                      borderRadius: BorderRadius.circular(15),
     
                      border: Border.all(color:brandcolor ),
     
                     color: white
     
                  ),
     
         
          child: TextFormField(

               validator: (name) {
              if (name!.isEmpty) {
                return 'Please enter your name';
              }},
                                controller: _firstcontroller,
                                              style: TextStyle(fontSize: 16,color: black, fontFamily: "SF-Pro-Display"),
   
                             decoration: InputDecoration(
                                   
                                    // contentPadding: EdgeInsets.only(left: 15),
                                    fillColor: white,
                                    focusColor:white,
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
                                    hintText:"First Name",
                                    hintStyle:
                                    TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
                              ),
        ),
      
         SizedBox(height: MediaQuery.of(context).size.height*0.03),
   
      
         Container(
           height: MediaQuery.of(context).size.height*0.07,
               width: MediaQuery.of(context).size.width*0.8,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(25),
                //     border: Border.all(color:whitetran ),
                //    color: whitetran
                // ),
         
         
                  decoration: BoxDecoration(
     
                      borderRadius: BorderRadius.circular(15),
     
                      border: Border.all(color:brandcolor ),
     
                     color: white
     
                  ),
     
         
          child: TextFormField(
                                controller: _lastcontroller,
                                              style: TextStyle(fontSize: 16,color: black, fontFamily: "SF-Pro-Display"),
   
                             decoration: InputDecoration(
                                   
                                    // contentPadding: EdgeInsets.only(left: 15),
                                    fillColor: white,
                                    focusColor:white,
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
                                    hintText:"Last Name",
                                    hintStyle:
                                    TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
                              ),
        ),
      
         SizedBox(height: MediaQuery.of(context).size.height*0.03),

         
        Container(
           height: MediaQuery.of(context).size.height*0.07,
               width: MediaQuery.of(context).size.width*0.8,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(25),
                //     border: Border.all(color:whitetran ),
                //    color: whitetran
                // ),
        
        
                  decoration: BoxDecoration(
     
                      borderRadius: BorderRadius.circular(15),
     
                      border: Border.all(color:brandcolor ),
     
                     color: white
     
                  ),
     
         
          child: TextFormField(
            style: TextStyle(fontSize: 16,color: black, fontFamily: "SF-Pro-Display",),
                                controller: _numbercontroller,
                                   keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 10,
                             decoration: InputDecoration(
    counterText: '',
                              contentPadding: EdgeInsets.all(10),
                                    // contentPadding: EdgeInsets.only(left: 15),
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
                                    hintText:"Mobile No",
                                    hintStyle:
                                    TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
                              ),
        ),
    
        SizedBox(height: MediaQuery.of(context).size.height*0.03),
          
        Container(
           height: MediaQuery.of(context).size.height*0.07,
               width: MediaQuery.of(context).size.width*0.8,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(25),
                //     border: Border.all(color:whitetran ),
                //    color: whitetran
                // ),
        
        
                  decoration: BoxDecoration(
     
                      borderRadius: BorderRadius.circular(15),
     
                      border: Border.all(color:brandcolor ),
     
                     color: white
     
                  ),
     
         
        
          child: TextFormField(
                                controller: _emailcontroller,
                                              style: TextStyle(fontSize: 16,color: black, fontFamily: "SF-Pro-Display"),
     keyboardType: TextInputType.emailAddress,
                             decoration: InputDecoration(
                                   
                                    // contentPadding: EdgeInsets.only(left: 15),
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
                                    hintText:"Email",
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
     
         
           
          child: TextFormField(
   obscureText: passwordVisible,  
            // contentPadding: EdgeInsets.only(left: 15),
                                controller: _passcontroller,
                                 keyboardType: TextInputType.visiblePassword, 
            style: TextStyle(fontSize: 16,color: black, fontFamily: "SF-Pro-Display"),
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
                                    hintText:" Set Password",
                                    hintStyle:
                                    TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
                              ),
        ),
      
   
    SizedBox(height: MediaQuery.of(context).size.height*0.03),
   
           Container(
           height: MediaQuery.of(context).size.height*0.07,
               width: MediaQuery.of(context).size.width*0.8,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(25),
                //     border: Border.all(color:whitetran ),
                //    color: whitetran
                // ),
        
        
                  decoration: BoxDecoration(
     
                      borderRadius: BorderRadius.circular(15),
     
                      border: Border.all(color:brandcolor ),
     
                     color: white
     
                  ),
     
         
        
          child: TextFormField(
            obscureText: passwordVisiblecon,  
              keyboardType: TextInputType.visiblePassword, 
                                controller: _confpasscontroller,
                                              style: TextStyle(fontSize: 16,color: black, fontFamily: "SF-Pro-Display"),
   
                             decoration: InputDecoration(
                                    suffixIcon: IconButton(
                     icon: Icon(passwordVisiblecon
                         ? Icons.visibility
                         : Icons.visibility_off),
                     onPressed: () {
                       setState(
                         () {
                           passwordVisiblecon = !passwordVisiblecon;
                         },
                       );
                     },
                   ),
                                    // contentPadding: EdgeInsets.only(left: 15),
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
                                    hintText:"Confirm Password",
                                    hintStyle:
                                    TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
                              ),
        ),
      
     SizedBox(height: MediaQuery.of(context).size.height*0.05),
   
                           
                      InkWell(onTap: ()  async {
String msg = '';
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
             if (_firstcontroller!.text.isEmpty) {
                                    showCustomSnackBar('enter first name', context,);
                                  }
                                  else if (_lastcontroller!.text.isEmpty) {
                                    showCustomSnackBar('enter last name', context);
                                  }else if (_numbercontroller!.text.isEmpty) {
                                    showCustomSnackBar('enter phone number', context);
                                  } 
                                  else if (_numbercontroller.text.length != 10 ) {
                                    showCustomSnackBar('enter 10 digit mobile number', context);
                                  }
                                  else if (_passcontroller!.text.isEmpty) {
                                    showCustomSnackBar('enter password', context);
                                  }else if (_passcontroller!.text.length < 6) {
                                    showCustomSnackBar('password should be 6 digit', context);
                                  }else if (_confpasscontroller.text.isEmpty) {
                                    showCustomSnackBar('enter confirm password', context);
                                  }else if(_passcontroller.text != _confpasscontroller.text) {
                                    showCustomSnackBar('password does not match',  context);
                                  }
 else     {
                            ApiHelper.usersignup(_firstcontroller.text,_lastcontroller.text,_emailcontroller.text,
                            _numbercontroller.text,"user",_passcontroller.text,'null',
                            "null","null","null","null","null","null","null","null","null",
                            context);}}
                          
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                            
                         //   }
                            
    //                     else{    ApiHelper.usersignup(_firstcontroller.text,_lastcontroller.text,_emailcontroller.text,
    //                         _numbercontroller.text,"seller",_passcontroller.text,
    // "null","null","null","null","null","null","null","null","null",
    //                         context);
    //                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Createprofilesecond()));     
    //                        }

                            
                            
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
                      
                      
  // }
,child: Container(
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
                         
                                     child: Center(child:  Text('Create Account',style: TextStyle(color:white,fontSize: 16,fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500),)),
                                   
                            
                            
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
      
      
       SizedBox(height: MediaQuery.of(context).size.height*0.02),
   
      
   
   
   
       InkWell(onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
      },child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Login",style: TextStyle(fontSize: 14,fontFamily:  "SF-Pro-Display",color: hintcolor),),SizedBox(width: 5,),
          Icon(Icons.arrow_forward_outlined,color: hintcolor,size: 18,)
        ],
      )),
        SizedBox(height: MediaQuery.of(context).size.height*0.03),
       ],
     ),
   ),



        
      ],
        )


    );
  }



}