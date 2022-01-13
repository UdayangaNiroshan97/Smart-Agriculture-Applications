import 'package:aswenna/community/ui/profile/profile.dart';
import 'package:aswenna/components/my_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Profile(),
      bottomNavigationBar: MyBottomNavBar(home_color: Colors.black,com_color : Colors.black,news_color : Colors.black,user_color : kPrimaryColor),
    );
  }
}
