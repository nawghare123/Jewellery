import 'package:flutter/material.dart';
import 'package:jewellery/style/colors.dart';

class NestedTabBarExample extends StatefulWidget {
  @override
  _NestedTabBarExampleState createState() => _NestedTabBarExampleState();
}

class _NestedTabBarExampleState extends State<NestedTabBarExample>
    with TickerProviderStateMixin {
  late TabController _outerTabController;
  late TabController _innerTabController;

  @override
  void initState() {
    super.initState();
    _outerTabController = TabController(length: 3, vsync: this);
    _innerTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _outerTabController.dispose();
    _innerTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TabBar(
              controller: _outerTabController,
              automaticIndicatorColorAdjustment: false,
              // indicator: false,
              tabs: [
                Tab(child:    CircleAvatar(backgroundColor:brandcolor ,radius: 50,
                            
                          child:       Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: black
                  ),
                  child: CircleAvatar(backgroundColor:brandcolor,
                            
                          child: Image.asset("assets/image/brand3.png"),
                          
                          
                          ),
                ))
              ,),
           Tab(child:    CircleAvatar(backgroundColor:brandcolor ,radius: 50,
                            
                          child:       Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: black
                  ),
                  child: CircleAvatar(backgroundColor:brandcolor,
                            
                          child: Image.asset("assets/image/brand3.png"),
                          
                          
                          ),
                ))
              ,),
                  Tab(child:    CircleAvatar(backgroundColor:brandcolor ,radius: 50,
                            
                          child:       Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: black
                  ),
                  child: CircleAvatar(backgroundColor:brandcolor,
                            
                          child: Image.asset("assets/image/brand3.png"),
                          
                          
                          ),
                ))
              ,),
               
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _outerTabController,
                children: [
                  Column(
                    children: [
                      TabBar(
                        controller: _innerTabController,
                        tabs: [
                          Tab(child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(colors: [
                                gradient2,
                                gradient1,
                              ])),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/image/kangan1.png",
                                    height: 28),
      
                                //  SizedBox(width: MediaQuery.of(context).size.width*0.01,),
      
                                Text(
                                  'Gold bangle',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: white,
                                      fontFamily: "SF-Pro-Display",
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                       ),
                          Tab(child:Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(colors: [
                                gradient2,
                                gradient1,
                              ])),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/image/kangan1.png",
                                    height: 28),
      
                                //  SizedBox(width: MediaQuery.of(context).size.width*0.01,),
      
                                Text(
                                  'Gold bangle',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: white,
                                      fontFamily: "SF-Pro-Display",
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        ),
                       
                         Tab(child:Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(colors: [
                                gradient2,
                                gradient1,
                              ])),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/image/kangan1.png",
                                    height: 28),
      
                                //  SizedBox(width: MediaQuery.of(context).size.width*0.01,),
      
                                Text(
                                  'Gold bangle',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: white,
                                      fontFamily: "SF-Pro-Display",
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        ),
                         Tab(child:Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(colors: [
                                gradient2,
                                gradient1,
                              ])),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/image/kangan1.png",
                                    height: 28),
      
                                //  SizedBox(width: MediaQuery.of(context).size.width*0.01,),
      
                                Text(
                                  'Gold bangle',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: white,
                                      fontFamily: "SF-Pro-Display",
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        ),
                       
                       
                       
                       
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _innerTabController,
                          children: [
                            Container(
                              child: Center(
                                child: Text('Content for Sub Tab 1'),
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Text('Content for Sub Tab 2'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Center(
                      child: Text('Content for Tab 2'),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Content for Tab 3'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(home: NestedTabBarExample()));
// }
