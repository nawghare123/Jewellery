
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Mycart.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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


String dropdownvalue = 'Country';

  // List of items in our dropdown menu
  var items = [
    'Country',
    
  ];
    return Scaffold(
resizeToAvoidBottomInset: false,
      backgroundColor: gradient1,
  body: SingleChildScrollView(
    child:Container(
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
                         crossAxisAlignment: CrossAxisAlignment.center,
                          
                          children: [
                            InkWell(
                            
                            onTap: (){

                              //Navigator.pop(context);
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
                         
                         Text( ' Edit Profile',
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
                               InkWell(onTap: (){
                                 Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyCart(
                                )));
                                  },child: SvgPicture.asset("assets/image/Buy.svg",color: white)),
  
                               SizedBox(width: 10),
                       
                           ],
                         ),
                         ]),
                       ),
                       
                        )
,
                        Container(
//  height: MediaQuery.of(context).size.height,
width: MediaQuery.of(context).size.width,
  decoration: BoxDecoration(
    color: bgcolor,

    borderRadius: BorderRadius.only(topRight: Radius.circular(30))
  ),  
child: Padding(
  padding: const EdgeInsets.all(13.0),
  child:   Column(children: [
  
   SizedBox(height: MediaQuery.of(context).size.height*0.03),
  
  
            Container(
  
              height: MediaQuery.of(context).size.height*0.07,
  
                  // width: MediaQuery.of(context).size.width*0.8,
  
                    decoration: BoxDecoration(
  
                        borderRadius: BorderRadius.circular(15),
  
                        border: Border.all(color:brandcolor ),
  
                       color: white
  
                    ),
  
              child: TextFormField(
  
                                   controller: _namecontroller,
  
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
  
                                        hintText:"Full Name ",
  
                                        hintStyle:
  
                                        TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
  
                                  ),
  
            ),
  
  SizedBox(height: 15,),
      
            Container(
  
              height: MediaQuery.of(context).size.height*0.07,
  
                  // width: MediaQuery.of(context).size.width*0.8,
  
                    decoration: BoxDecoration(
  
                        borderRadius: BorderRadius.circular(15),
  
                        border: Border.all(color:brandcolor ),
  
                       color: white
  
                    ),
  
              child: TextFormField(
  
                                    controller: _datecontroller,
  
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
  
                                        hintText:"Date Of Birth ",
  
                                        hintStyle:
  
                                        TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
  
                                  ),
  
            ),
  
    SizedBox(height: 15,),
            Container(
  
              height: MediaQuery.of(context).size.height*0.07,
  
                  // width: MediaQuery.of(context).size.width*0.8,
  
                    decoration: BoxDecoration(
  
                        borderRadius: BorderRadius.circular(15),
  
                        border: Border.all(color:brandcolor ),
  
                       color: white
  
                    ),
  
              child: TextFormField(
  
                                  controller: _emailcontroller,
  
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
  
                                        hintText:"Email ID ",
  
                                        hintStyle:
  
                                        TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
  
                                  ),
  
            ),
  
  SizedBox(height: 15,),
  
  
            Container(
  
              height: MediaQuery.of(context).size.height*0.07,
  
                  // width: MediaQuery.of(context).size.width*0.8,
  
                    decoration: BoxDecoration(
  
                        borderRadius: BorderRadius.circular(15),
  
                        border: Border.all(color:brandcolor ),
  
                       color: white
  
                    ),
  
              child: TextFormField(
  
                                   controller: _designationcontroller,
  
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
  
                                        hintText:"Designation",
  
                                        hintStyle:
  
                                        TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
  
                                  ),
  
            ),
  
  SizedBox(height: 15,),
      
            Container(
  
              height: MediaQuery.of(context).size.height*0.07,
  
                   width: MediaQuery.of(context).size.width,
  
                    decoration: BoxDecoration(
  
                        borderRadius: BorderRadius.circular(15),
  
                        border: Border.all(color:brandcolor ),
  
                       color: white
  
                    ),
  
              child:     DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                      ),
                                      value: dropdownvalue,
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items,style: TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14),),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              )
                           
         ,     
                
  SizedBox(height: 15,),
      
            Container(
  
              height: MediaQuery.of(context).size.height*0.07,
  
                   width: MediaQuery.of(context).size.width,
  
                    decoration: BoxDecoration(
  
                        borderRadius: BorderRadius.circular(15),
  
                        border: Border.all(color:brandcolor ),
  
                       color: white
  
                    ),
  
              child:     DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                      ),
                                      value: dropdownvalue,
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items,style: TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14),),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),

                                
  SizedBox(height: 15,),
      
            Container(
  
              height: MediaQuery.of(context).size.height*0.07,
  
                   width: MediaQuery.of(context).size.width,
  
                    decoration: BoxDecoration(
  
                        borderRadius: BorderRadius.circular(15),
  
                        border: Border.all(color:brandcolor ),
  
                       color: white
  
                    ),
  
              child:     DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                      ),
                                      value: dropdownvalue,
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items,style:TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14),),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              )
            
  //             TextFormField(
  
  //                                   controller: _datecontroller,
  
  //                                decoration: InputDecoration(
  
                                       
  // prefixIcon: Icon(Icons.),
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
  
  //                                       hintText:"Country ",
  
  //                                       hintStyle:
  
  //                                       TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
  
  //                                 ),
  
  ,
    
  SizedBox(height: 15,),
    Container(
  
              height: MediaQuery.of(context).size.height*0.07,
  
                  // width: MediaQuery.of(context).size.width*0.8,
  
                    decoration: BoxDecoration(
  
                        borderRadius: BorderRadius.circular(15),
  
                        border: Border.all(color:brandcolor ),
  
                       color: white
  
                    ),
  
              child: TextFormField(
  
                                   controller: _pincodecontroller,
  
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
  
                                        hintText:"Pincode",
  
                                        hintStyle:
  
                                        TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14)),
  
                                  ),
  
            ),
  

                                 
  SizedBox(height: 15,),
      
            Container(
  
              height: MediaQuery.of(context).size.height*0.07,
  
                   width: MediaQuery.of(context).size.width,
  
                    decoration: BoxDecoration(
  
                        borderRadius: BorderRadius.circular(15),
  
                        border: Border.all(color:brandcolor ),
  
                       color: white
  
                    ),
  
              child:     DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                      ),
                                      value: dropdownvalue,
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items,style:TextStyle(color: hintcolor,fontFamily:  "SF-Pro-Display", fontSize: 14),),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
            
    SizedBox(height: 25,),


       Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(25),
                   gradient: LinearGradient(colors: 
                       [
                           gradient2,
                         gradient1,
                 
                            
                     ],)
                 ),
                  child: ElevatedButton(
                   
                        onPressed: () {

                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>CartDetails()));
                        },
                        // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                            elevation: 10.0,
                               shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                     minimumSize: Size(300, 15),
                         
                            textStyle:  TextStyle(color: Colors.white)),
                        child:  Text('Update Profile',style: TextStyle(fontSize: 14,fontFamily: "SF-Pro-Display",fontWeight: FontWeight.w500),),
                      ),
                             ),
                 
    SizedBox(height: 15,),
  
  ],),
)
    


)


],)    
      
    )
    
  
  ),
   
   


    );
  }


}