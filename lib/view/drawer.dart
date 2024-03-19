import 'package:flutter/material.dart';
import 'package:jewellery/style/colors.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/Mycart.dart';
import 'package:jewellery/view/Order.dart';
import 'package:jewellery/view/Profile.dart';
import 'package:jewellery/view/catalogue.dart';
import 'package:jewellery/view/contactus.dart';
import 'package:jewellery/view/home/Ourbranddetails.dart';
import 'package:jewellery/view/home/categories.dart';
import 'package:jewellery/view/home/home1.dart';
import 'package:jewellery/view/home/notificationModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:jewellery/view/splash.dart';
import 'package:jewellery/view/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget drawer(BuildContext context) => Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [gradient2, gradient1],
            // You can customize the gradient colors and stops here
            // For example: [Colors.red, Colors.yellow, Colors.blue]
            // For stops: [0.0, 0.5, 1.0]
          ),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: white,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home1()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: white,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_bag,
                color: white,
              ),
              title: Text(
                'Orders',
                style: TextStyle(
                  color: white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Order()),
                );
              },
            ),
            FutureBuilder<NotificationModel?>(
                future: ApiHelper.getNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      leading: Icon(
                        Icons.notifications,
                        color: white,
                      ),
                      title: Text(
                        'Notifications',
                        style: TextStyle(
                          color: white,
                        ),
                      ),
                    );
                    ;
                  } else if (snapshot.hasError) {
                    return ListTile(
                      title: Text(
                        'Error occurred',
                        style: TextStyle(
                          color: white,
                        ),
                      ),
                    );
                  } else {
                    return ListTile(
                      leading: Icon(
                        Icons.notifications,
                        color: white,
                      ),
                      title: Text(
                        'Notifications',
                        style: TextStyle(
                          color: white,
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: Colors.transparent,
                            actions: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: gradient1,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30))),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08,

                                      // height: 50,

                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Center(
                                          child: Text(
                                            "Notifications",
                                            style: TextStyle(
                                                fontFamily: "Alhadara-DEMO",
                                                color: white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        decoration: BoxDecoration(
                                            // color: white,

                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/image/product_bg_image.png'),
                                              fit: BoxFit
                                                  .cover, // Adjust the fit as per your requirement
                                            ),
                                            border: Border.all(
                                                color: gradient1, width: 0.3),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView(
                                            children: snapshot!.data!.data!.map(
                                              (e) {
                                                return e.status! == 0
                                                    ? SizedBox()
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            CachedNetworkImage(
                                                              imageUrl:
                                                                  "https://veejayjewels.com/storage/app/public/notification/${e.image!}",
                                                              progressIndicatorBuilder: (context,
                                                                      url,
                                                                      downloadProgress) =>
                                                                  CircularProgressIndicator(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade700,
                                                                      value: downloadProgress
                                                                          .progress),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(Icons
                                                                      .error),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        e
                                                                            .title!,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18))),
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        e.description!)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                              },
                                            ).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
            ListTile(
              leading: Icon(
                Icons.shopping_cart,
                color: white,
              ),
              title: Text(
                'Cart',
                style: TextStyle(
                  color: white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyCart()),
                );
              },
            ),


             ListTile(
              leading: Icon(
                Icons.category_outlined,
                color: white,
              ),
              title: Text(
                'Category',
                style: TextStyle(
                  color: white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Categories()),
                );
              },
            ),
     ListTile(
              leading: Icon(
                Icons.favorite,
                color: white,
              ),
              title: Text(
                'Favorite',
                style: TextStyle(
                  color: white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WishList()),
                );
              },
            ),
            
            

           
             ListTile(
              leading: Icon(
                Icons.book_online,
                color: white,
              ),
              title: Text(
                'Catalogue',
                style: TextStyle(
                  color: white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Catalogue(type: "women",)),
                );
              },
            ),
 
             ListTile(
              leading: Icon(
                Icons.person,
                color: white,
              ),
              title: Text(
                'Contact Us',
                style: TextStyle(
                  color: white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUs()),
                );
              },
            ),
            
            

            
            
            
            
            ListTile(
              leading: Icon(
                Icons.logout,
                color: white,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: white,
                ),
              ),
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                await prefs.remove('login');
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Splash()));
              },
            ),
          ],
        ),
      ),
    );
