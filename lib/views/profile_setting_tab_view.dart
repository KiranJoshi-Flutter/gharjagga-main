import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:gharjagga/utlis/constant.dart';
import 'package:gharjagga/utlis/userpreferences.dart';
import 'package:gharjagga/views/about_us_screen.dart';
import 'package:gharjagga/views/add_new_property_screen.dart';
import 'package:gharjagga/views/profile_account_screen.dart';
import 'package:gharjagga/views/sign_in_screen.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

class ProfileSettingTabView extends StatefulWidget {
  // final Color _primaryColor;
  // final Color _secondaryColor;

  // ProfileSettingTabView(this._primaryColor, this._secondaryColor);

  @override
  _ProfileSettingTabViewState createState() => _ProfileSettingTabViewState();
}

class _ProfileSettingTabViewState extends State<ProfileSettingTabView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      key: _scaffoldKey,
      body: FadedSlideAnimation(
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: Container(
          // decoration: BoxDecoration(color: kSecondary),
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: 4.0,
              left: 20.0,
              bottom: 8.0,
              right: 20.0,
            ),
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountScreen(),
                    ),
                  );
                },
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          IconlyBold.profile,
                          color: kTextHintColor,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Text(
                            'Account',
                            style: appTextStyle(
                              FontWeight.normal,
                              14.0,
                              kTextColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Icon(
                          IconlyLight.arrow_right_2,
                          size: 20,
                          color: kThemeColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNewPropertyScreen(),
                    ),
                  );
                },
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          IconlyBold.plus,
                          color: kTextHintColor,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Text(
                            'Add Property',
                            style: appTextStyle(
                              FontWeight.normal,
                              14.0,
                              kTextColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Icon(
                          IconlyLight.arrow_right_2,
                          size: 20,
                          color: kThemeColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              // Card(
              //   elevation: 0,
              //   color: Colors.white,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(
              //       vertical: 16.0,
              //       horizontal: 16.0,
              //     ),
              //     child: Row(
              //       children: [
              //         Icon(
              //           IconlyBold.wallet,
              //           color: kTextHintColor,
              //         ),
              //         SizedBox(
              //           width: 8.0,
              //         ),
              //         Expanded(
              //           child: Text(
              //             'Payment',
              //             style: appTextStyle(
              //               FontWeight.normal,
              //               14.0,
              //               kTextColor,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: 8.0,
              //         ),
              //         Icon(
              //           Icons.chevron_left_rounded,
              //           color: kThemeColor,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 8.0,
              // ),
              // Card(
              //   elevation: 0,
              //   color: Colors.white,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(
              //       vertical: 16.0,
              //       horizontal: 16.0,
              //     ),
              //     child: Row(
              //       children: [
              //         Icon(
              //           IconlyBold.notification,
              //           color: kTextHintColor,
              //         ),
              //         SizedBox(
              //           width: 8.0,
              //         ),
              //         Expanded(
              //           child: Text(
              //             'Notification',
              //             style: appTextStyle(
              //               FontWeight.normal,
              //               14.0,
              //               kTextColor,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: 8.0,
              //         ),
              //         Icon(
              //           Icons.chevron_left_rounded,
              //           color: kThemeColor,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 8.0,
              // ),
              // Card(
              //   elevation: 0,
              //   color: Colors.white,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(
              //       vertical: 16.0,
              //       horizontal: 16.0,
              //     ),
              //     child: Row(
              //       children: [
              //         Icon(
              //           IconlyBold.lock,
              //           color: kTextHintColor,
              //         ),
              //         SizedBox(
              //           width: 8.0,
              //         ),
              //         Expanded(
              //           child: Text(
              //             'Privacy Setting',
              //             style: appTextStyle(
              //               FontWeight.normal,
              //               14.0,
              //               kTextColor,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: 8.0,
              //         ),
              //         Icon(
              //           Icons.chevron_left_rounded,
              //           color: kThemeColor,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 8.0,
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUsScreen(),
                    ),
                  );
                },
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          IconlyBold.info_square,
                          color: kTextHintColor,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Text(
                            'About Us',
                            style: appTextStyle(
                              FontWeight.normal,
                              14.0,
                              kTextColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Icon(
                          IconlyLight.arrow_right_2,
                          size: 20,
                          color: kThemeColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              GestureDetector(
                onTap: () {
                  _showDialog(context);
                },
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          IconlyBold.logout,
                          color: kTextHintColor,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Text(
                            'Logout',
                            style: appTextStyle(
                              FontWeight.normal,
                              14.0,
                              kTextColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Icon(
                          IconlyLight.arrow_right_2,
                          size: 20,
                          color: kThemeColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  // color: Colors.black,
                  child: Image.asset('assets/icons/logo.png'),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                flex: 12,
                child: Text(
                  'Gharjagga',
                  style: appTextStyle(
                    FontWeight.bold,
                    18.0,
                    Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          content: new Text(
            'Are you sure you want to logout?',
            style: appTextStyle(
              FontWeight.normal,
              16.0,
              Colors.black87,
            ),
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text(
                'No',
                style: appTextStyle(
                  FontWeight.w500,
                  14.0,
                  Colors.black54,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new TextButton(
              child: new Text(
                'Yes',
                style: appTextStyleWLS(
                  FontWeight.w500,
                  14.0,
                  Colors.black54,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                UserPreferences.logout();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                  ModalRoute.withName('/'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
