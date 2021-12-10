import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app/registerscreen.dart';
import 'package:social_app/reusable_data.dart';
import 'package:splashscreen/splashscreen.dart';

import 'CRC_algorithm_model.dart';
import 'login_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ConverterScreen());
}
class ConverterScreen extends StatelessWidget{
  const ConverterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme : ThemeData(
        backgroundColor: Colors.grey
      ),
      debugShowCheckedModeBanner: false,
      home: Splash_Screen(),
    );
  }
}
class Splash_Screen extends StatelessWidget{
  const Splash_Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(
          seconds: 3,
          navigateAfterSeconds: LoginScreen(),
          image: Image.asset('assets/logo.png') ,
          backgroundColor: Colors.blue,
          photoSize: 150.0,
      ),
    );
  }
}



