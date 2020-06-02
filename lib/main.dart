import 'package:flutter/material.dart';
import 'package:tiktok_clone/bottom_nav_bar.dart';
import 'package:tiktok_clone/pages/following_page.dart';
import 'package:tiktok_clone/pages/home_page.dart';
import 'package:tiktok_clone/widgets/home/home_header.dart';

void main() => runApp(MyApp());

final pageController = PageController(initialPage: 1);

final pages = PageView(
  controller: pageController,
  children: <Widget>[
    Stack(
      children: <Widget>[
        FollowingScreen(),
      ],
    ),
    Stack(
      children: <Widget>[
        HomeScreen(),
        BottomNavigation(),
        homeHeader(),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: pages
      ),
    );
  }
}
