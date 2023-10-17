import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_application/view/home.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 2), () { 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home_screen(),));
    });
    }
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height*1;
    // final width=MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset('images/splash_image.png')),
          SizedBox(height: height*.04,),
          const SpinKitCircle( color: Colors.red,size: 40,),
        ],
      ),
    );
  }
}