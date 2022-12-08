import 'package:flixbus/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCELyECjihWxzs-JdSUd5la5q5RAiKw7nw",
          authDomain: "orjinbus.firebaseapp.com",
          projectId: "orjinbus",
          storageBucket: "orjinbus.appspot.com",
          messagingSenderId: "28832657498",
          appId: "1:28832657498:web:2a319d21731eddb9e6e863",
          measurementId: "G-WGPKT15BHW"));
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Orjin Bus',
        home: HomeScreen());
  }
}
