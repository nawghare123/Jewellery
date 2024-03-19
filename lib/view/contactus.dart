import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/ContactusModel.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    // ContactUsModel? contactusmodel;
    //   bool isloading = false;

//      @override
//   void initState() {
//   //  contactList();
  
//     setState(() {
//       isloading = true;
//     });
//  super.initState();
//   }


  // void contactList() async {
  //   contactusmodel = await ApiHelper.getcontact();
  // }
void _openDrawer() {
    print("clicked...");
    _scaffoldKey.currentState?.openDrawer();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   // backgroundColor: teal,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 20),
      //     child: IconButton(
      //         icon: Icon(
      //           Icons.arrow_back_sharp,
      //           color: Colors.white,
      //         ),
      //         onPressed: () {
      //           Navigator.pop(context);
      //         }),
      //   ),
      //   title: Text('Contact Us',  style: TextStyle(
      //                           color: Colors.black,
      //                           fontWeight: FontWeight.w400,
      //                           fontSize: 20.0,
      //                           fontFamily: "Alhadara-DEMO"),),
      // ),
      
      body:
    
       ListView(
         primary: true,
         children: [

           Container(
             height: 70,
             decoration: BoxDecoration(
                 gradient: LinearGradient(colors: [gradient2, gradient1])),
             child: Padding(
               padding: const EdgeInsets.all(10.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   Row(
                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, bottom: 5),
                                              child: Icon(
                                                Icons
                                                    .arrow_back_ios_new_outlined,
                                                color: white,
                                                size: 18,
                                              ),
                                            )),// Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,),
 // Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,),
      SizedBox(width: 50),
                         Center(
                           child: Text(
                             'Contact Us',
                             style: TextStyle(
                                 color: white,
                                 fontWeight: FontWeight.w400,
                                 fontSize: 20.0,
                                 fontFamily: "Alhadara-DEMO"),
                           ),
                         ),

                         //Image.asset("assets/image/notification.png",color: white,),

                     
                       ]),
                   SizedBox(
                     height: 10,
                   ),
                 ],
               ),
             ),
           ),
          
          SizedBox(height: 20,),

           Padding(
             padding: const EdgeInsets.all(15.0),
             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 InkWell(onTap: ()=>canLaunchUrl(Uri.parse("tel://+91 9699919991")),
                   child: Row(mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                  
           
                      //  SizedBox(width: 20,),
                       Row(mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                          //  Text("Telephone - ",style: TextStyle(
                          //          color: Colors.black,
                                //    fontWeight: FontWeight.w500,
                                //    fontSize: 16.0,
                                // ),),
                                    Icon(Icons.call),
                        SizedBox(width: 20,),
           
                           Text( "+91 9699919991 , +91 845490604",style: TextStyle(color: Colors.black,fontSize: 12),)
           
                         ],
                       ),
                         
                   ],
                   ),
                 ),
           


                     Padding(
                       padding: const EdgeInsets.only(left:40),
                       child: InkWell(onTap: ()=>launchUrl(Uri.parse("tel://+91 9227259227")),
                         child: Row(
                             children: [
                              //  Text("Business WhatsApp - ",style: TextStyle(
                              //          color: Colors.black,
                              //          fontWeight: FontWeight.w500,
                              //          fontSize: 16.0,
                              //       ),),
                              SizedBox(height:5 ,),
                                  
                               Text(  " +91 9227259227",style: TextStyle(color: Colors.black,fontSize: 12),)
                                  
                             ],
                           ),
                       ),
                     ),
                  
                 SizedBox(height: 25,),
           
                 InkWell(onTap: ()=>launchUrl(Uri.parse("mailto://Support@gmail.com")),
                   child: Row(mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                   Icon(Icons.mail),
           
                       SizedBox(width: 20,),
                           Text("Support@gmail.com",style: TextStyle(color: Colors.black,fontSize: 12),)
                      //  Column( crossAxisAlignment: CrossAxisAlignment.start,
                      //    children: [
                      //      Text("Send an Email- ",style:  TextStyle(  color: Colors.black,
                      //              fontWeight: FontWeight.w500,
                      //              fontSize: 16.0,),),
                      //      SizedBox(height:5 ,),
           
                       
           
                      //    ],
                      //  )
                     ],
                   ),
                 ),
           
                 SizedBox(height: 10,),
                 
                 Row(
                   children: [
                    Icon(Icons.timer,color: Colors.black,),
                    SizedBox(width: 20,),
                Text("10:00 AM - 6:00 PM",
                    style: TextStyle(
                       color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),),
                   ],
                 ),
            //  Padding(
            //    padding: const EdgeInsets.only(left: 45),
            //    child: 
            //  ),
             SizedBox(height: 10,),
                 Row(
                   children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 20,),
                Text("Veejay Jewels A/305, 3rd Floor, Vaishali Indstrial Estate-1,\Mhatrewadi Road, Dahisar (W). Mumbai Pin Code : 400068",
                  textAlign: TextAlign.center,  style: TextStyle(
                       color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),),
                   ],
                 ),
           
                //  SizedBox(height: 10,),
                //  Padding(
                //     padding: const EdgeInsets.only(left: 45),
                //    child: Text("Veejay Jewels A/305, 3rd Floor, Vaishali Indstrial Estate-1, Mhatrewadi Road, Dahisar (W). Mumbai Pin Code : 400068",
                //     style: TextStyle(
                //        color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),),
                //  ),
               ],
             ),
           ),

           //  TextFormField(
           //     keyboardType: TextInputType.multiline,
           //     textInputAction: TextInputAction.newline,
           //     minLines: 1,
           //     maxLines: 10,
           //     controller: _controller,
           //      decoration: InputDecoration(
           //       contentPadding: EdgeInsets.all(15),
           //       border: OutlineInputBorder(
           //         borderSide: BorderSide(color: greyc,width:0.3),
           //           borderRadius:
           //           BorderRadius.all(new Radius.circular(10.0))),
           //   )
           //   ),

           //  SizedBox(height: 30,),


           //  MaterialButton(
           //     color: buttoncolor,
           //     elevation: 0,

           //     minWidth: MediaQuery.of(context).size.width,
           //     padding: EdgeInsets.symmetric(vertical: 12),

           //     child: Text(
           //       "Continue",
           //       style: TextStyle(
           //           color: pwhite, fontWeight: FontWeight.w500, fontSize: 15),
           //     ),
           //     onPressed: ()
           //     async {
            
           //         }


               


           //     ),




         ],
       ),
    );
  }

}