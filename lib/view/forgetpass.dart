import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:jewellery/otp.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Mycart.dart';

class ForgetPage extends StatefulWidget {
  const ForgetPage({super.key});

  @override
  State<ForgetPage> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  TextEditingController _numbercontroller = TextEditingController();
  
  TextEditingController _passcontroller = TextEditingController();
    @override
  Widget build(BuildContext context) {
    TextEditingController _namecontroller = TextEditingController();
    TextEditingController _datecontroller = TextEditingController();
    TextEditingController _emailcontroller = TextEditingController();
    TextEditingController _designationcontroller = TextEditingController();
        TextEditingController _countrycontroller = TextEditingController();
            TextEditingController _statecontroller = TextEditingController();
    TextEditingController _citycontroller = TextEditingController();
    TextEditingController _pincodecontroller = TextEditingController();
    TextEditingController _currencycontroller = TextEditingController();


    return Scaffold(
resizeToAvoidBottomInset: false,
      backgroundColor: gradient1,
  body: Container(
  //  height: MediaQuery.of(context).size.height,  

      child:Column(children: [
                       Container( height: MediaQuery.of(context).size.height*0.15,
  
                       decoration: BoxDecoration(gradient: LinearGradient(colors: [
  
                        gradient2,
  
                        gradient1
  
                       ]
  
                       )),
  
                       child: Padding(
  
                         padding: const EdgeInsets.all(10.0),
  
                         child: Column(mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Row(
                           
                              children: [
    InkWell(
                          
                          onTap: (){

                            Navigator.pop(context);
                          },
                          child:Padding(
                            padding: const EdgeInsets.only(left:13.0,bottom:5),
                            child:Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 18,
                          )
                            //Image.asset("assets/image/menu2.png",color: white,height: 25,),
                          )
                          //  Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,
                          // )
                          
                          )
                          ,
                  SizedBox(width:  MediaQuery.of(context).size.width*0.1,),
  
                             Center(
                               child: Text( 'Forgot Password',
                               
                                style: TextStyle(
                               
                               color: white,
                               
                               fontWeight: FontWeight.w400,
                               
                                       fontSize: 20.0,
                               
                               fontFamily: "Alhadara-DEMO"
                               
                                                       
                               
                                   ),
                               
                               
                               
                                  
                               
                               ),
                             ),
  
                                                //Image.asset("assets/image/notification.png",color: white,),
  
                       
  
                            //  Row(
  
                            //    children: [
  
                            //      SvgPicture.asset("assets/image/notification.svg",color: white),
  
                            //      SizedBox(width: 15),
  
                            //     //  Image.asset("assets/image/cart.png"),
  
                            //         InkWell(onTap: (){
                            //      Navigator.push(
                            // context,
                            // MaterialPageRoute(
                            //     builder: (context) => MyCart(
                            //     )));
                            //       },child: SvgPicture.asset("assets/image/Buy.svg",color: white)),
  
  
                            //        SizedBox(width: 10),
  
                       
  
                            //    ],
  
                            //  ),
  
                             ]),
                           SizedBox(height: 10,),
  
                          
                           ],
                         ),
  
                       ),
  
                       
  
                        )
  ,
  
                      Container(
height: MediaQuery.of(context).size.height*0.85,
width: MediaQuery.of(context).size.width,
  // decoration: BoxDecoration(
  //   color: bgcolor,

  //   borderRadius: BorderRadius.only(topRight: Radius.circular(30))
  // ),  


 decoration: BoxDecoration(
  color: bgcolor,
  image: DecorationImage(
        image: AssetImage(
            'assets/image/backgroundimg.jpg'),
        fit: BoxFit.fill,
      ),
  borderRadius: BorderRadius.only(topRight: Radius.circular(30))
  ),
  




child: Padding(
  // padding: const EdgeInsets.all(13.0),
  padding: const EdgeInsets.only(left:30.0,right: 30),
  child:   Column(mainAxisAlignment: MainAxisAlignment.start,
  children: [
  
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

            style: TextStyle(fontSize: 14,color: hintcolor, fontFamily: "SF-Pro-Display",
),
            
                                controller: _numbercontroller,
                                 keyboardType: TextInputType.number,
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
  
  
  SizedBox(height: MediaQuery.of(context).size.height*0.1,),

                                     
                      InkWell(onTap: (){
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Otp()));
                      },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.07,
                          width: MediaQuery.of(context).size.width*04,
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
                      
                                     child: Center(child:  Text('Reset',style: TextStyle(color:white,fontSize: 16,fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500),)),
                                    
                            
                            
                             ),
                      ),
               


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
               
  SizedBox(height: 15,),
  
  ],),
)
  


)


],)    
    
  ),
   
   


    );
  }



  }



