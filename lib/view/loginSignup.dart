import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Login/Login.dart';
import 'package:jewellery/view/Signup/Signup.dart';
import 'package:jewellery/view/Signup/createprofileseller.dart';
import 'package:jewellery/view/bottomnavbar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class loginSignup extends StatefulWidget {
  const loginSignup({super.key});

  @override
  State<loginSignup> createState() => _loginSignupState();
}

class _loginSignupState extends State<loginSignup> {
  TextEditingController _rolecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                //  height: MediaQuery.of(context).size.height,

                child:
                    //SvgPicture.asset("assets/image/splash.svg",fit: BoxFit.cover)
                    Image.asset(
                  "assets/image/bgimg3.png",
                 fit: BoxFit.fill
                )),
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                Center(
                    child: Image.asset(
                  "assets/image/logo.png",
                )),

                // SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                // //SizedBox(height: MediaQuery.of(context).size.height*0.03),

                // Container(
                //   height: MediaQuery.of(context).size.height * 0.08,
                //   width: MediaQuery.of(context).size.width * 0.8,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(30),
                //       border: Border.all(color: darkgradient1),
                //       color: whitetran),
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => SignUp(role: "user")));
                //     },
                //     // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                //     style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.transparent,
                //         elevation: 10.0,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(25)),
                //         ),
                //         minimumSize: Size(150, 15),
                //         textStyle: TextStyle(color: Colors.white)),
                //     child: GradientText(
                //       'SignUp User',
                //       style: TextStyle(
                //           fontFamily: "SF-Pro-Display",
                //           fontSize: 16.0,
                //           fontWeight: FontWeight.w500),
                //       gradientType: GradientType.radial,
                //       radius: 2.5,
                //       colors: [darkgradient1, darkgradient2, darkgradient3],
                //     ),

                //     //Text('Login',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                //   ),
                // ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: darkgradient1),
                      color: whitetran),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CraeteprofileSeller(role: "seller")));
                    },
                    // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        minimumSize: Size(150, 15),
                        textStyle: TextStyle(color: Colors.white)),
                    child: GradientText(
                      'SignUp User',
                      style: TextStyle(
                          fontFamily: "SF-Pro-Display",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                      gradientType: GradientType.radial,
                      radius: 2.5,
                      colors: [darkgradient1, darkgradient2, darkgradient3],
                    ),

                    //Text('Login',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: darkgradient1),
                      color: whitetran),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        minimumSize: Size(150, 15),
                        textStyle: TextStyle(color: Colors.white)),
                    child: GradientText(
                      'Login',
                      style: TextStyle(
                          fontFamily: "SF-Pro-Display",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                      gradientType: GradientType.radial,
                      radius: 2.5,
                      colors: [darkgradient1, darkgradient2, darkgradient3],
                    ),

                    //Text('Login',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Skip",
                          style: TextStyle(
                              fontSize: 14,
                              color: white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: white,
                          size: 18,
                        )
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
