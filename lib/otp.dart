import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/bottomnavbar.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
//  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _numbercontroller = TextEditingController();
  
  TextEditingController _otpcontroller = TextEditingController();
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
            Image.asset("assets/image/backgroundimg.jpg",  fit: BoxFit.fill,)

           
          ),
   
   Column(
     children: [
       SizedBox(height:MediaQuery.of(context).size.height*0.09),
        Center(child: Image.asset("assets/image/logo.png", )),
  
       SizedBox(height: MediaQuery.of(context).size.height*0.1),
          
  OtpTextField(
        numberOfFields: 4,
        focusedBorderColor:gradient1,
        enabledBorderColor:brandcol ,
        
borderWidth: 1.5,
        //set to true to show as box or false to show as dash
        showFieldAsBox: true, 
        //runs when a code is typed in
        onCodeChanged: (String code) {
            //handle validation or checks here           
        },
        //runs when every textfield is filled
        onSubmit: (String verificationCode){
            showDialog(
                context: context,
                builder: (context){
                return AlertDialog(
                    title: Text("Verification Code"),
                    content: Text('Code entered is $verificationCode'),
                );
                }
            );
        }, // end onSubmit
    ),  
                           
                            SizedBox(height: MediaQuery.of(context).size.height*0.06),
                           
          
                        InkWell(onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
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
                        
                                         child: Center(child:  Text('Verify Otp',style: TextStyle(color:white,fontSize: 16,fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500),)),
                                       
                              
                              
                               ),
                        ),
                 
  SizedBox(height: MediaQuery.of(context).size.height*0.03),
    Center(
                              child: Text(
                                "Resend OTP",
                                style: TextStyle(
                                   fontSize: 14,color: hintcolor,fontWeight: FontWeight.w400),
                            )),

   

     ],
   ),



        
          ],
        ),
      )


    );
  }



}