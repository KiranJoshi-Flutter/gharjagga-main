import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/gestures.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:gharjagga/views/profile_page_set_img.dart';

class ProfilePageRentHistory extends StatefulWidget {
  const ProfilePageRentHistory({Key? key}) : super(key: key);

  @override
  _ProfilePageRentHistoryState createState() => _ProfilePageRentHistoryState();
}

class _ProfilePageRentHistoryState extends State<ProfilePageRentHistory> {
  @override
  Widget build(BuildContext context) {
    // theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        // key: _scaffoldKey,
        // appBar: AppBar(),
        body: FadedSlideAnimation(
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    height: 112.0,
                    width: 112.0,
                    margin:
                        EdgeInsets.only(left: 152.0, top: 83.0, right: 151.0),
                    decoration: BoxDecoration(
                        color: Color(0xffD8D8D8), shape: BoxShape.circle),
                  ),
                  Positioned(
                    top: 60,
                    left: 70,
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      margin:
                          EdgeInsets.only(left: 152.0, top: 83.0, right: 151.0),
                      decoration: BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ProfilePageSetImage();
                            }));
                          },
                          child: Image.asset(
                              "assets/icons/profile_screen/Camera.png")),
                    ),
                  ),
                ],
              ),

              //

              Container(
                //color: Colors.white,
                margin: EdgeInsets.only(
                  top: 22.0,
                ),
                child: Text(
                  "Samuel Tan",
                  style: TextStyle(
                    fontFamily: "Samuel Tan",
                    fontSize: 28.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  margin: EdgeInsets.only(top: 30.0),
                  width: 414.0,
                  height: 462.5,
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
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 15.0),
                            child: Text(
                              "Settings",
                              style: TextStyle(
                                fontFamily: "DM Sans",
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                                color: Color(0xFF828294),
                              ),
                            ),
                          ),
                          Container(
                            width: 30.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30.0, left: 25.0),
                            child: Column(
                              children: <Widget>[
                                Text("Rent History",
                                    style: TextStyle(
                                      fontFamily: "DM Sans",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0,
                                    )),
                                Container(
                                  width: 30,
                                  height: 3,
                                  margin: EdgeInsets.only(left: 0, top: 10.0),
                                  color: Colors.deepOrangeAccent,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          left: 10.0,
                          bottom: 10.0,
                          right: 16.0,
                        ),
                        color: Colors.white,
                        width: 364.0,
                        height: 150.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 12.0),
                              width: 120.0,
                              height: 130.0,
                              //color: Colors.white,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 203,
                              height: 121.0,
                              //color: Colors.blue,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Luxury Hotel",
                                    style: TextStyle(
                                        fontSize: 16.0, fontFamily: "DM Sans"),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 8.0, right: 6.75),
                                        width: 8.5,
                                        height: 10.0,
                                        //color: Colors.grey,
                                        child: ImageIcon(
                                          AssetImage(
                                              "assets/icons/Location.png"),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(top: 4.0),
                                          child: Text("Bandung, Indonesia")),
                                    ],
                                  ),
                                  SizedBox(height: 16.0),
                                  Divider(
                                    height: 1.0,
                                  ),
                                  SizedBox(height: 11.0),
                                  Column(
                                    children: <Widget>[
                                      Row(children: <Widget>[
                                        Text(
                                          "Check in",
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 13.5, right: 31.5),
                                          //color: Colors.grey,
                                          child: Image.asset(
                                              "assets/icons/profile_screen/Arrow - Down.png"),
                                          width: 7, height: 10.5,
                                        ),
                                        Text(
                                          "Check out",
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 13.5),
                                          width: 7, height: 10.5,
                                          //color: Colors.grey,
                                          child: Image.asset(
                                              "assets/icons/profile_screen/Arrow - Down-1.png"),
                                        ),
                                      ]),
                                      SizedBox(height: 8.0),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "27/12/2020",
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                          SizedBox(width: 42.0),
                                          Text(
                                            "27/12/2021",
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          left: 10.0,
                          bottom: 10.0,
                          right: 16.0,
                        ),
                        color: Colors.white,
                        width: 364.0,
                        height: 150.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 12.0),
                              width: 120.0,
                              height: 130.0,
                              //color: Colors.white,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 203,
                              height: 121.0,
                              //color: Colors.blue,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Luxury Hotel",
                                    style: TextStyle(
                                        fontSize: 16.0, fontFamily: "DM Sans"),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 8.0, right: 6.75),
                                        width: 8.5,
                                        height: 10.0,
                                        //color: Colors.grey,
                                        child: ImageIcon(
                                          AssetImage(
                                              "assets/icons/Location.png"),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(top: 4.0),
                                          child: Text("Bandung, Indonesia")),
                                    ],
                                  ),
                                  SizedBox(height: 16.0),
                                  Divider(
                                    height: 1.0,
                                  ),
                                  SizedBox(height: 11.0),
                                  Column(
                                    children: <Widget>[
                                      Row(children: <Widget>[
                                        Text(
                                          "Check in",
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 13.5, right: 31.5),
                                          //color: Colors.grey,
                                          child: Image.asset(
                                              "assets/icons/profile_screen/Arrow - Down.png"),
                                          width: 7, height: 10.5,
                                        ),
                                        Text(
                                          "Check out",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: kTextColor),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 13.5),
                                          width: 7, height: 10.5,
                                          //color: Colors.grey,
                                          child: Image.asset(
                                              "assets/icons/profile_screen/Arrow - Down-1.png"),
                                        ),
                                      ]),
                                      SizedBox(height: 8.0),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "27/12/2020",
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: kTextColor),
                                          ),
                                          SizedBox(width: 42.0),
                                          Text(
                                            "27/12/2021",
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: kTextColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: 3,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/Category.png"),
                // color: Colors.white,
                size: 26,
              ),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/Bookmark.png"),
                color: Color(0xFFDDDDDD),
                size: 26,
              ),
              label: 'Bookmark',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/Chat.png"),
                color: Color(0xFFDDDDDD),
                size: 26,
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return Text("");
                    },
                  ));
                },
                icon: ImageIcon(
                  AssetImage(
                      "assets/icons/profile_screen/Profile Selected.png"),
                  color: Color(0xFFDDDDDD),
                  size: 26,
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
