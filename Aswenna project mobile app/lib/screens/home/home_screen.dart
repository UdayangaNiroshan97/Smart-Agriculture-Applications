import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aswenna/components/my_bottom_nav_bar.dart';
import 'package:aswenna/screens/home/components/body.dart';

import '../../constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(home_color: kPrimaryColor,com_color : Colors.black,news_color : Colors.black,user_color : Colors.black),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
    );
  }
}
