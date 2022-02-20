import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharjagga/functions/functions.dart';
import 'package:gharjagga/views/blog_detail_screen.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

import 'package:gharjagga/utlis/constant.dart';
import 'package:recase/recase.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:iconly/iconly.dart';

class BlogScreen extends StatefulWidget {
  // final Color _primaryColor;
  // final Color _secondaryColor;

  // BlogScreen(this._primaryColor, this._secondaryColor);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  // int _currentMax = 10;
  late Future _properties;

  List<dynamic> propertyList = [];

  var lastPage = 0;
  var currentPage = 1;
  var isLastPage = false;

  var totalResults = 0;

  @override
  void initState() {
    _properties = _fetchProperties();
    super.initState();
  }

  Future _fetchProperties() async {
    print("https://gharjhagga.com/wp-json/wp/v2/posts?_embed&orderby=date");
    final request = await http.get(
      Uri.parse(
        "https://gharjhagga.com/wp-json/wp/v2/posts?_embed&orderby=date",
      ),
    );

    var res = json.decode(request.body);

    print(
        "request.headers['x-wp-totalpages'] ${request.headers['x-wp-totalpages']}");

    if (res.length != 0) {
      // setState(() {
      //   propertyList = res;
      //   //   currentPage = currentPage + 1;
      //   //   lastPage = int.parse(request.headers['x-wp-totalpages']!);

      //   //   totalResults = int.parse(request.headers['x-wp-total']!);
      // });

      print("Current Page = $currentPage");

      return res;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: kThemeColor,
        title: Text(
          'Blogs',
          style: appTextStyle(
            FontWeight.bold,
            20.0,
            Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: FutureBuilder(
          future: _properties, // async work
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  // color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          backgroundColor: kPrimary,
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            kSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Container();
                } else {
                  if (snapshot.data.length != 0) {
                    return FadedSlideAnimation(
                      child: Column(
                        children: [
                          // Expanded(
                          //   flex: 3,
                          //   child:
                          Material(
                            elevation: 0.5,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlogDetailScreen(
                                      title: snapshot.data[0]['title']
                                              ['rendered']
                                          .toString(),
                                      postId: snapshot.data[0]['id'].toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    FutureBuilder(
                                      future: imageURLCheck(snapshot
                                          .data[0]['_embedded']
                                              ['wp:featuredmedia']
                                          .first['source_url']),
                                      builder: (context, asyncSnapshot) {
                                        if (asyncSnapshot.hasData) {
                                          if (asyncSnapshot.data != null) {
                                            return Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    snapshot
                                                        .data[0]['_embedded']
                                                            ['wp:featuredmedia']
                                                        .first['source_url'],
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            );
                                          } else {
                                            // return Container(
                                            //   // color: Colors.black,
                                            //   // width: 200,
                                            //   child: CircleAvatar(
                                            //     radius: 60,
                                            //     backgroundColor:
                                            //         Colors.transparent,
                                            //     backgroundImage: AssetImage(
                                            //       "assets/images/no_image.png",
                                            //     ),
                                            //   ),
                                            // );
                                            return Container(
                                              height: 180,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 16.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  'assets/images/no_image.png',
                                                ),
                                              ),
                                            );
                                          }
                                        } else {
                                          return Container(
                                            color: Colors.white,
                                            height: 200,
                                            child: Center(
                                              child:
                                                  CupertinoActivityIndicator(),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Text(
                                        snapshot.data[0]['title']['rendered']
                                            .toString()
                                            .titleCase,
                                        style: appTextStyle(
                                          FontWeight.bold,
                                          18.0,
                                          kTextColor,
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   padding: EdgeInsets.symmetric(
                                    //     horizontal: 16.0,
                                    //   ),
                                    //   child: Html(
                                    //     data: propertyList[0]['excerpt']
                                    //         ['rendered'],
                                    //     onLinkTap: (String? url,
                                    //         RenderContext context,
                                    //         Map<String, String> attributes,
                                    //         element) {
                                    //       launchURL(url!);
                                    //     },
                                    //     // onLinkTap: (url) async {
                                    //     // print("Opening $url...");
                                    //     // launchURL(url!);
                                    //     // },
                                    //     style: htmlTextStyle(),
                                    //   ),
                                    // ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    WidgetSpan(
                                                      child: Icon(
                                                        IconlyLight.time_circle,
                                                        size: 14,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                    WidgetSpan(
                                                      child: SizedBox(
                                                        width: 4.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      // text: timeago.format(
                                                      // DateTime.parse(
                                                      // snapshot.data[index]
                                                      //     ['date'],
                                                      // ),
                                                      // ),
                                                      text: timeago.format(
                                                        DateTime.parse(
                                                                snapshot.data[0]
                                                                    ['date'])
                                                            .toLocal(),
                                                      ),
                                                      style: appTextStyle(
                                                        FontWeight.w500,
                                                        12.0,
                                                        Colors.black54,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   child: Row(
                                          //     crossAxisAlignment:
                                          //         CrossAxisAlignment.end,
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.end,
                                          //     children: [
                                          //       IconButton(
                                          //         onPressed: (() async {
                                          //           // await Share.share(
                                          //           //     "text");
                                          //         }),
                                          //         icon: Icon(
                                          //           Icons.bookmark_add_outlined,
                                          //           size: 22,
                                          //           color: Colors.black87,
                                          //         ),
                                          //       ),
                                          //       SizedBox(
                                          //         width: 8.0,
                                          //       ),
                                          //       IconButton(
                                          //         onPressed: (() async {
                                          //           // await Share.share(
                                          //           //     "text");
                                          //         }),
                                          //         icon: Icon(
                                          //           Icons.share_rounded,
                                          //           size: 22,
                                          //           color: Colors.black87,
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      height: 8.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              // color: Colors.black38,
                              child: ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  // vertical: 16.0,
                                ),
                                // itemExtent: 80,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BlogDetailScreen(
                                            title: snapshot.data[index + 1]
                                                    ['title']['rendered']
                                                .toString(),
                                            postId: snapshot.data[index + 1]
                                                    ['id']
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 0.75,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: FutureBuilder(
                                              future: imageURLCheck(
                                                snapshot
                                                    .data[index + 1]
                                                        ['_embedded']
                                                        ['wp:featuredmedia']
                                                    .first['source_url'],
                                              ),
                                              builder:
                                                  (context, asyncSnapshot) {
                                                if (asyncSnapshot.hasData) {
                                                  if (asyncSnapshot.data !=
                                                      null) {
                                                    return Container(
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                            16.0,
                                                          ),
                                                          bottomLeft:
                                                              Radius.circular(
                                                            16.0,
                                                          ),
                                                        ),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            snapshot
                                                                .data[index + 1]
                                                                    [
                                                                    '_embedded']
                                                                    [
                                                                    'wp:featuredmedia']
                                                                .first['source_url'],
                                                          ),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Container(
                                                      height: 100,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 16.0,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                            16.0,
                                                          ),
                                                          bottomLeft:
                                                              Radius.circular(
                                                            16.0,
                                                          ),
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                        child: Image.asset(
                                                          'assets/images/no_image.png',
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                } else {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                          16.0,
                                                        ),
                                                        bottomLeft:
                                                            Radius.circular(
                                                          16.0,
                                                        ),
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    height: 100,
                                                    child: Center(
                                                      child:
                                                          CupertinoActivityIndicator(),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 16.0,
                                                  ),
                                                  child: Text(
                                                    snapshot.data[index + 1]
                                                            ['title']
                                                            ['rendered']
                                                        .toString()
                                                        .titleCase,
                                                    style: appTextStyle(
                                                      FontWeight.bold,
                                                      14.0,
                                                      kTextColor,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4.0,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 16.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                WidgetSpan(
                                                                  child: Icon(
                                                                    IconlyLight
                                                                        .time_circle,
                                                                    size: 14,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                                WidgetSpan(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 4.0,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  // text: timeago.format(
                                                                  // DateTime.parse(
                                                                  // snapshot.data[index]
                                                                  //     ['date'],
                                                                  // ),
                                                                  // ),
                                                                  text: timeago
                                                                      .format(
                                                                    DateTime.parse(snapshot.data[index +
                                                                                1]
                                                                            [
                                                                            'date'])
                                                                        .toLocal(),
                                                                  ),
                                                                  style:
                                                                      appTextStyle(
                                                                    FontWeight
                                                                        .w500,
                                                                    12.0,
                                                                    Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
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
                                  );
                                },
                                itemCount: snapshot.data.length - 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      beginOffset: Offset(0, 0.3),
                      endOffset: Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                    );
                  } else {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: "no_data",
                            child: Material(
                              color: Colors.transparent,
                              child: Image.asset(
                                "assets/images/no_data.png",
                                fit: BoxFit.fitHeight,
                                height: 80,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'No post found',
                            style: appTextStyleWLS(
                              FontWeight.w500,
                              12.0,
                              Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                }
            }
          },
        ),

        // child: Column(
        //   children: [
        //     Expanded(
        //       flex: 3,
        //       child: Container(
        //         color: Colors.white,
        //         child: Column(),
        //       ),
        //     ),
        //     Expanded(
        //       flex: 7,
        //       child: Container(
        //         color: Colors.black38,
        //         child: ,
        //       ),
        //     ),
        //   ],
        // ),
        // child: Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(
        //         "assets/images/bg.png",
        //       ),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
