import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:iconly/iconly.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:getwidget/getwidget.dart';

class AboutUsScreen extends StatefulWidget {
  // final Color _primaryColor;
  // final Color _secondaryColor;

  // AboutUsScreen(this._primaryColor, this._secondaryColor);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
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
      appBar: AppBar(
        backgroundColor: kThemeColor,
        title: Text(
          'About Us',
          style: appTextStyle(
            FontWeight.bold,
            20.0,
            Colors.white,
          ),
        ),
      ),
      key: _scaffoldKey,
      body: FadedSlideAnimation(
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  // vertical: 16.0,
                  horizontal: 16.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: CircleAvatar(
                        radius: 60,
                        // backgroundColor: kThemeColor,
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage("assets/icons/logo.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      flex: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: ,
                        children: [
                          Text(
                            'Gharjagga Pvt. Ltd.',
                            style: appTextStyle(
                              FontWeight.bold,
                              24.0,
                              kThemeColor,
                            ),
                          ),
                          // Divider(),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                IconlyBold.call,
                                size: 16.0,
                                color: kThemeColor,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Expanded(
                                child: Text(
                                  '+977-9861584767 / 9843725632',
                                  style: appTextStyle(
                                    FontWeight.normal,
                                    12.0,
                                    kTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                IconlyBold.message,
                                size: 16.0,
                                color: kThemeColor,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Expanded(
                                child: Text(
                                  'gharjhagga@gmail.com',
                                  style: appTextStyle(
                                    FontWeight.normal,
                                    12.0,
                                    kTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                IconlyBold.location,
                                size: 16.0,
                                color: kThemeColor,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Expanded(
                                child: Text(
                                  'Tokha Height, Kathmandu',
                                  style: appTextStyle(
                                    FontWeight.normal,
                                    12.0,
                                    kTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kDividerColor,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Process',
                      style: appTextStyle(
                        FontWeight.bold,
                        20.0,
                        kThemeColor,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    GFAccordion(
                      title: 'Process for Buyers',
                      titleBorderRadius: BorderRadius.circular(8.0),
                      contentBorderRadius: BorderRadius.circular(8.0),
                      textStyle: appTextStyle(
                        FontWeight.w600,
                        16.0,
                        kTextColor,
                      ),
                      contentChild: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'Select the City/ Region/ Country where they want to rent/buy property',
                                    style: appTextStyle(
                                      FontWeight.normal,
                                      14.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'Choose the property suitable for you among the entire list of properties',
                                    style: appTextStyle(
                                      FontWeight.normal,
                                      14.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'If you haven’t registered on the website then register with your phone number and email id.',
                                    style: appTextStyle(
                                      FontWeight.normal,
                                      14.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'After you have registered yourself an automatic message is sent to the seller to contact you',
                                    style: appTextStyle(
                                      FontWeight.normal,
                                      14.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'If that does not happen then, the contact number of the seller is available for you',
                                    style: appTextStyle(
                                      FontWeight.normal,
                                      14.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'Contact the seller and fix an appointment',
                                    style: appTextStyle(
                                      FontWeight.normal,
                                      14.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // content:
                      //     'GetFlutter is an open source library that comes with pre-build 1000+ UI components.',
                    ),
                    GFAccordion(
                      title: 'Process for Sellers',
                      titleBorderRadius: BorderRadius.circular(8.0),
                      contentBorderRadius: BorderRadius.circular(8.0),
                      textStyle: appTextStyle(
                        FontWeight.w600,
                        16.0,
                        kTextColor,
                      ),
                      contentChild: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'Register on the website',
                                    style: appTextStyle(
                                      FontWeight.normal,
                                      14.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'List the property on the website by mentioning the locality and the address',
                                    style: appTextStyle(
                                      FontWeight.normal,
                                      14.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'Fill in all the details of your property i.e. number of rooms, property size, the number of floors etc.',
                                    style: appTextStyle(
                                      FontWeight.normal,
                                      14.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'Fill in the contact details and your property will be listed on the website',
                                    style: appTextStyle(
                                      FontWeight.normal,
                                      14.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // content:
                      //     'GetFlutter is an open source library that comes with pre-build 1000+ UI components.',
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
