import 'package:aswenna/community/ui/dashboard/community_home.dart';
import 'package:aswenna/components/my_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class Community extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: community_home(),
      bottomNavigationBar: MyBottomNavBar(home_color: Colors.black,com_color : kPrimaryColor,news_color : Colors.black,user_color : Colors.black),
    );
  }
}


