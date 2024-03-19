import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/view/Login/Login.dart';
import 'package:jewellery/view/bottomnavbar.dart';
import 'package:jewellery/view/loginSignup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? isLogin = prefs.getString('login');
      isLogin == null
          ? Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => loginSignup()))
          : Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BottomNavBar()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:
              //SvgPicture.asset("assets/image/splash.svg",fit: BoxFit.cover)
              Image.asset(
            "assets/image/splashimg1.png",
            fit: BoxFit.fill,
          )),
    ));
  }
}
