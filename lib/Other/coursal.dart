import 'package:flutter/material.dart';

class ButtonBounce extends StatefulWidget {
 @override
 createState() => ButtonBounceState();
}

class ButtonBounceState extends State<ButtonBounce> {
 double leftPosition = 20;

 @override
 Widget build(BuildContext context) {
   return Stack(
     children: [
       AnimatedPositioned(
           left: leftPosition,
           top: 100,
           duration: Duration(seconds: 2),
           child: Container(
             height: 60,
             width: 200,
             color: Colors.blue,
           ),),
       AnimatedPositioned(
           left: leftPosition,
           top: 200,
           curve: Curves.bounceOut,
           duration: Duration(seconds: 2),
           child: Container(
             height: 60,
             width: 200,
             color: Colors.blue,
           )),
       Positioned(
         left: 220,
         top: 300,
         child: ElevatedButton(
           child: Text('move it'),
           onPressed: () {
             setState(() => leftPosition = leftPosition <= 20 ? 400.0 : 20.0);
           },
         ),
       ),
     ],
   );
 }
}