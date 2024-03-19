
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Calculator.dart';
import 'package:jewellery/view/CustomOrder.dart';
import 'package:jewellery/view/Order.dart';
import 'package:jewellery/view/Profile.dart';
import 'package:jewellery/view/home/home1.dart';


class BottomNavBar extends StatefulWidget {
    BottomNavBar({super.key,this.index});
int? index;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
   int _currentIndex = 0;
  void initState(){

    _currentIndex=widget.index??0;
    super.initState();
  }

  @override
  final pages = [
     Home1(),
     Order(),
     CustomerList(),
     Calculator(),
     Profile(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[_currentIndex],

      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            // topLeft: Radius.circular(25),
            // topRight: Radius.circular(25),
          ),
          gradient: LinearGradient(begin: Alignment.centerLeft,
            end: Alignment.centerRight,colors: [
            gradient2,
            gradient1
          ])
        ),
        child:  BottomNavigationBar(
          elevation: 0,
          backgroundColor:Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: white,
          // unselectedItemColor: hinttext.withOpacity(.60),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          unselectedItemColor: white,
          onTap: (value) {
            setState(() => _currentIndex = value);
          },
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle:TextStyle(fontWeight: FontWeight.w500),
          items:  [
            BottomNavigationBarItem(
              icon:  SvgPicture.asset("assets/image/home.svg",color:_currentIndex==0?white:white.withOpacity(.60)),
              //Icon(Icons.home,color:_currentIndex==0?white:white.withOpacity(.60),),
              label: 'Home',
            ),
            BottomNavigationBarItem(
            //  icon: Image.asset("asset/images/doctor.png",color:_currentIndex==1?buttoncolor:hinttext.withOpacity(.60)),
              icon: SvgPicture.asset("assets/image/bag-2.svg",color:_currentIndex==1?white:white.withOpacity(.60)),

              label: 'Order',
            ),
               BottomNavigationBarItem(
            //  icon: Image.asset("asset/images/doctor.png",color:_currentIndex==1?buttoncolor:hinttext.withOpacity(.60)),
              icon: SvgPicture.asset("assets/image/bag-2.svg",color:_currentIndex==2?white:white.withOpacity(.60)),

              label: 'Custom Order',
            ),
            BottomNavigationBarItem(
              //icon: Image.asset("asset/images/nurse.png",color:_currentIndex==2?buttoncolor:hinttext.withOpacity(.60)),
              icon: SvgPicture.asset("assets/image/calculator.svg",color:_currentIndex==3?white:white.withOpacity(.60)),
              label: 'Calculator',
            ),
            BottomNavigationBarItem(
            //  icon: Image.asset("asset/images/ambulance1.png",color:_currentIndex==3?buttoncolor:hinttext.withOpacity(.60)),
              icon: SvgPicture.asset("assets/image/profile.svg",color:_currentIndex==4?white:white.withOpacity(.60)),
              label: 'Profile',
            ),
           

          ],
          currentIndex: _currentIndex,

        ),
      ),

    ) ;
  }


}