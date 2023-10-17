import 'package:flutter/material.dart';
import 'package:news_application/view/category.dart';
import 'package:news_application/view/splash.dart';

void main(){
    runApp(MyApp());
}
// b82d74f0ea094645be9e23c8c7320116
// https://newsapi.org/v2/top-headlines?country=us&apiKey=b82d74f0ea094645be9e23c8c7320116
// https://newsapi.org/v2/top-headlines?country=us&apiKey=b82d74f0ea094645be9e23c8c7320116
// https://newsapi.org/v2/top-headlines/sources?apiKey=API_KEY



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: 
      // category_screen(),
      splash(),
    );
  }
}