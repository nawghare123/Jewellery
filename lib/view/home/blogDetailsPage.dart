import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Mycart.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class BlogDetailsPage extends StatelessWidget {
  BlogDetailsPage({
    super.key,
    required this.banner,
    required this.title,
    required this.desc,
    required this.image,
    required this.author,
  });

  String? banner;
  String? title;
  String? desc;
  String? image;
  String? author;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: gradient1,
      body: SingleChildScrollView(
          child: Container(
              //   height: MediaQuery.of(context).size.height,

              child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [gradient2, gradient1])),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // InkWell(
                        //     onTap: () {
                        //       //Navigator.pop(context);
                        //     },
                        //     child: Padding(
                        //       padding:
                        //           const EdgeInsets.only(left: 13.0, top: 5),
                        //       child: Image.asset(
                        //         "assets/image/menu2.png",
                        //         color: white,
                        //         height: 25,
                        //       ),
                        //     )
                        //     //  Icon(Icons.arrow_back_ios_new_outlined,color: white,size: 20,
                        //     // )

                        //     ),
                        Center(
//SvgPicture.asset("assets/image/menu1.svg",height: 25,),
//
                          child: GradientText(
                            title!.length < 15
                                ? title!
                                : "${title!.substring(0, 14)}...",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20.0,
                                fontFamily: "Alhadara-DEMO"),
                            gradientType: GradientType.radial,
                            radius: 2.5,
                            colors: [darkgradient1, darkgradient2],
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     SvgPicture.asset("assets/image/notification.svg",
                        //         color: white),

                        //     SizedBox(width: 15),

                        //     //  Image.asset("assets/image/cart.png"),

                        //     InkWell(
                        //         onTap: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => MyCart()));
                        //         },
                        //         child: SvgPicture.asset("assets/image/Buy.svg",
                        //             color: white)),

                        //     SizedBox(width: 10),
                        //   ],
                        // ),
                      ]),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              imageUrl: "${banner}",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                    color: Colors.grey.shade700,
                    value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: CachedNetworkImage(
          //     width: MediaQuery.of(context).size.width * 0.2,
          //     imageUrl: "${image}",
          //     progressIndicatorBuilder: (context, url, downloadProgress) =>
          //         CircularProgressIndicator(
          //             color: Colors.grey.shade700,
          //             value: downloadProgress.progress),
          //     errorWidget: (context, url, error) => Icon(Icons.error),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title!,
                style: TextStyle(
                  fontFamily: "SFPRODISPLAYMEDIUM",
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 0,
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                desc!,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "SFPRODISPLAYMEDIUM",
                ),
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    "Author: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Alhadara-DEMO",
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "${author!}",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontFamily: "Alhadara-DEMO",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ))),
    );
  }
}
