import 'package:aswenna/screens/home/news.dart';
import 'package:aswenna/screens/home/community.dart';
import 'package:aswenna/screens/home/home_screen.dart';
import 'package:aswenna/screens/home/user.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    Key key,
    this.home_color,
    this.com_color,
    this.news_color,
    this.user_color,
  }) : super(key: key);
  final home_color,com_color,news_color,user_color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: kDefaultPadding,
        top: kDefaultPadding,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon:Icon(Icons.home,color: home_color,size: 30),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> HomeScreen()
              ));
            },
          ),
          IconButton(
            icon: Icon(Icons.comment,color: com_color,size: 30),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> Community()
              ));
            },
          ),
          IconButton(
            icon: Icon(Icons.description_outlined,color: news_color,size: 30),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> News()
              ));
            },
          ),
          IconButton(
            icon: Icon(Icons.person,color: user_color,size: 30),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> User()
              ));
            },
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aswenna App',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
