import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/gestures.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:gharjagga/utlis/userpreferences.dart';
import 'package:gharjagga/views/profile_page_rent_history_tab_view.dart';
import 'package:gharjagga/views/profile_setting_tab_view.dart';
import 'package:iconly/iconly.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showPassword = false;
  var name = '';
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    var userFullName = await UserPreferences.getName();

    setState(() {
      name = userFullName!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: theme.backgroundColor,

        key: _scaffoldKey,
        // appBar: AppBar(),
        body: DefaultTabController(
          length: 2,
          child: FadedSlideAnimation(
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
            child: Column(
              children: [
                // Container(
                //   height: 112.0,
                //   width: 112.0,
                //   margin: EdgeInsets.only(left: 152.0, top: 83.0, right: 151.0),
                //   decoration: BoxDecoration(
                //       color: Colors.orange, shape: BoxShape.circle),
                // ),
                SizedBox(
                  height: AppBar().preferredSize.height + 32,
                ),
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/no_image_available.png"),
                        //     NetworkImage(
                        //   'https://www.donkey.bike/wp-content/uploads/2020/12/user-member-avatar-face-profile-icon-vector-22965342-e1608640557889.jpg',
                        // ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: -30,
                        child: RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          fillColor: kTextColor,
                          child: Icon(
                            IconlyBold.camera,
                            size: 22,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(4.0),
                          shape: CircleBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  //color: Colors.white,
                  margin: EdgeInsets.only(
                    top: 8.0,
                    bottom: 20,
                  ),
                  child: Text(
                    "$name",
                    style: appTextStyle(
                      FontWeight.bold,
                      24,
                      Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(255, 255, 255, 0.97),
                        Color.fromRGBO(255, 255, 255, 0.97),
                        Color.fromRGBO(255, 255, 255, 0.98),
                      ],
                      // begin: Alignment.topCenter,
                      // end: Alignment.bottomCenter,
                    ),
                  ),
                  child: TabBar(
                    onTap: ((index) {
                      print(index);
                    }),
                    isScrollable: true,
                    indicatorWeight: 2,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.symmetric(
                        // horizontal: 16.0,
                        ),
                    unselectedLabelStyle: appTextStyle(
                      FontWeight.normal,
                      18.0,
                      kTabBarTextColor,
                    ),
                    labelStyle: appTextStyle(
                      FontWeight.bold,
                      18.0,
                      kTabBarTextColor,
                    ),
                    unselectedLabelColor: kTextColorLight,
                    labelColor: kTextColor,
                    indicatorColor: kPrimary,
                    tabs: [
                      Tab(
                        icon: null,
                        text: 'Settings',
                      ),
                      Tab(
                        icon: null,
                        text: 'My Properties',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                      children: [
                        ProfileSettingTabView(),
                        ProfileRentHistoryTabView(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
