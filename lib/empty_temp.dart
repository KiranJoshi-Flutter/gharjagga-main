import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class ScreenName extends StatefulWidget {
  final Color _primaryColor;
  final Color _secondaryColor;

  ScreenName(this._primaryColor, this._secondaryColor);

  @override
  _ScreenNameState createState() => _ScreenNameState();
}

class _ScreenNameState extends State<ScreenName> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      key: _scaffoldKey,
      body: FadedSlideAnimation(
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/bg.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
