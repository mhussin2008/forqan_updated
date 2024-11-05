import 'dart:async';

import 'package:flutter/material.dart';

import '../generated/assets.dart';
import 'mainIndex.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        Duration(seconds: 5),
    () => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainIndex(),
      )));

  }

  @override
  Widget build(BuildContext context) {
    return  Image.asset(Assets.assetsImg);
  }
}
