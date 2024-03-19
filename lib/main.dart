import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:jewellery/view/splash.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // // Disable screenshots
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
