import 'package:flutter/material.dart';
import 'package:aswenna/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key key,
    this.crop,
  }): super(key: key);
  final String crop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(crop: crop),
    );
  }
}
