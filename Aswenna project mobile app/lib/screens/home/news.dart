import 'package:aswenna/components/my_bottom_nav_bar.dart';
import 'package:aswenna/news/main_news.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NewsHome(),
      bottomNavigationBar: MyBottomNavBar(home_color: Colors.black,com_color : Colors.black,news_color : kPrimaryColor,user_color : Colors.black),
    );
  }
}