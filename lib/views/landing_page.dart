import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/gestures.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:gharjagga/views/main_screen.dart';
import 'package:gharjagga/views/sign_in_screen.dart';
// import 'package:gharjagga/views/sign_up_screen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
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
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/bg.png",
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 64.0,
                  right: 64.0,
                  top: AppBar().preferredSize.height + 96.0,
                  bottom: 32.0,
                ),
                // color: Colors.amber,
                child: Image.asset(
                  "assets/images/landing-bg.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 32.0,
                  ),
                  // color: Colors.white,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(16.0),
                      topRight: const Radius.circular(16.0),
                    ),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 28.0,
                            vertical: 16.0,
                          ),
                          child: Text(
                            "Find Perfect Place for Your Dream",
                            style: appTextStyle(
                              FontWeight.bold,
                              20.0,
                              kTextColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                              );
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kButtonBg,
                              ),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                // horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Browse Now",
                                    textAlign: TextAlign.center,
                                    style: appTextStyle(
                                      FontWeight.w500,
                                      16.0,
                                      Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 20.0,
                          ),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Don\'t have an account?',
                                style: appTextStyle(
                                  FontWeight.normal,
                                  16,
                                  kTextColorLight,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Sign In',
                                    style: appTextStyle(
                                      FontWeight.bold,
                                      16,
                                      kThemeColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print("Sign Up Screen");
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SignInScreen(),
                                          ),
                                        );
                                      },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
