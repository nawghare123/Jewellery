import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/style/colors.dart';

class Jewellery extends StatefulWidget {
  const Jewellery({super.key});

  @override
  State<Jewellery> createState() => _JewelleryState();
}

class _JewelleryState extends State<Jewellery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: gradient1,
      body: Container(
     //   height: MediaQuery.of(context).size.height,  

        child:Column(children: [
                       
                       Container( height: MediaQuery.of(context).size.height*0.2,
                       decoration: BoxDecoration(gradient: LinearGradient(colors: [
                        gradient2,
                        gradient1
                       ]
                       )),
                       child: Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          
                          children: [
                          Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,),
                         Text( 'Veejay Jewels',
                          style: TextStyle(
                         color: white,
                         fontWeight: FontWeight.w400,
                                 fontSize: 20.0,
                         fontFamily: "Alhadara-DEMO"
                        
                             ),
                         
                            
                         ),
                                            //Image.asset("assets/image/notification.png",color: white,),
                       
                         Row(
                           children: [
                            //  SvgPicture.asset("assets/image/notification.svg",color: white),
                            //  SizedBox(width: 15),
                            //  Image.asset("assets/image/cart.png"),
                            // SvgPicture.asset("assets/image/cart.svg",color: white),
                            //    SizedBox(width: 10),
                       
                           ],
                         ),
                         ]),
                       ),
                       
                        )
,
Container(
height: MediaQuery.of(context).size.height*0.8,
  decoration: BoxDecoration(
    color: bgcolor,

    borderRadius: BorderRadius.only(topRight: Radius.circular(30))
  ),
)


],)    
      
    )
    
    
    
    
    
    
    
    
    
    
    
    
    
    );
  }
}