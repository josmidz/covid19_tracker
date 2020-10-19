import 'package:covid19_tracker/screens/home/home_screen.dart';
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'roboto',
        // primarySwatch: ctColor2,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
 