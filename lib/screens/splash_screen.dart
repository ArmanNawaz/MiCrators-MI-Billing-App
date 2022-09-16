import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_crators/screens/home_page.dart';

const Duration duration = Duration(seconds: 3);

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(duration, () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>MyHomePage()), (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double reqSize = min(size.height, size.width);
    return Scaffold(
      body: Center(
        child: Container(
          height: reqSize - 100,
          width: reqSize - 100,
          child: Hero(
            tag: 'appIcon',
            child: Image.asset('images/app_log.png'),
          ),
        ),
      ),
    );
  }
}
