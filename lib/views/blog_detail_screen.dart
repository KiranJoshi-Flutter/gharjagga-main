import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gharjagga/functions/functions.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:recase/recase.dart';

class BlogDetailScreen extends StatefulWidget {
  BlogDetailScreen({
    Key? key,
    required this.title,
    Key? key2,
    required this.postId,
  }) : super(key: key);

  final String title;
  final String postId;

  @override
  _BlogDetailScreenState createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  ScrollController _scrollController = ScrollController();
  int _currentMax = 10;
  late Future _blogs;
  late Future relatedNews;

  // late List<dynamic> snapshot.data;

  var lastPage = 0;
  var currentPage = 1;
  var isLastPage = false;

  @override
  void initState() {
    super.initState();
    _blogs = _fetchBlogDetail();
    // relatedNews = _fetchRelatedNews();
  }

  Future _fetchRelatedNews(String url) async {
    print('$url&_embed');

    final request = await http.get(
      Uri.parse(
        "$url&_embed&per_page=4",
      ),
    );

    var res = json.decode(request.body);
    // print(res);

    if (res.length != 0) {
      return res;
    } else {
      return null;
    }
  }

  Future _fetchBlogDetail() async {
    print("https://gharjhagga.com/wp-json/wp/v2/posts/${widget.postId}?_embed");
    final request = await http.get(
      Uri.parse(
        "https://gharjhagga.com/wp-json/wp/v2/posts/${widget.postId}?_embed",
      ),
    );

    var res = json.decode(request.body);

    // print(
    //     "request.headers['x-wp-totalpages'] ${request.headers['x-wp-totalpages']}");

    // print(res);

    if (res.length != 0) {
      print(res['_embedded']['wp:term']
          .first[0]['_links']['wp:post_type']
          .first['href']);

      setState(() {
        relatedNews = _fetchRelatedNews(res['_embedded']['wp:term']
            .first[0]['_links']['wp:post_type']
            .first['href']);
      });
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
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          widget.title,
          style: appTextStyle(
            FontWeight.w500,
            18.0,
            Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: kThemeColor,
      ),
      body: FadedSlideAnimation(
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: FutureBuilder(
          future: _blogs, // async work
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
                  if (snapshot.data != null) {
                    return FadedSlideAnimation(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder(
                              future: imageURLCheck(snapshot
                                  .data['_embedded']['wp:featuredmedia']
                                  .first['source_url']),
                              builder: (context, asyncSnapshot) {
                                if (asyncSnapshot.hasData) {
                                  if (asyncSnapshot.data != null) {
                                    return Container(
                                      height: 250,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            snapshot
                                                .data['_embedded']
                                                    ['wp:featuredmedia']
                                                .first['source_url'],
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      height: 200,
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
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Text(
                                snapshot.data['title']['rendered'].toString(),
                                style: appTextStyle(
                                  FontWeight.bold,
                                  22.0,
                                  kTextColor,
                                ),
                                // textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Chip(
                                label: Text(
                                  snapshot.data['_embedded']['wp:term'].first
                                      .first['name']
                                      .toString(),
                                  style: appTextStyle(
                                    FontWeight.normal,
                                    10.0,
                                    Colors.white,
                                  ),
                                ),
                                backgroundColor: kSecondary,
                                elevation: 0.5,
                              ),
                            ),

                            Container(
                              height: 1.0,
                              color: kThemeColor,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 4.0,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(
                                      "assets/icons/logo.png",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Gharjagga',
                                          style: appTextStyle(
                                            FontWeight.w500,
                                            15.0,
                                            Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          timeago.format(
                                            DateTime.parse(
                                              snapshot.data['date'],
                                            ),
                                          ),
                                          style: appTextStyle(
                                            FontWeight.bold,
                                            12.0,
                                            Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // textAlign: TextAlign.center,
                            ),
                            Container(
                              height: 1.0,
                              color: kThemeColor,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 8.0,
                              ),
                              // child: Text(
                              //   snapshot.data['content']['rendered'],
                              //   style: appTextStyle(
                              //     FontWeight.normal,
                              //     13.0,
                              //     Colors.black54,
                              //   ),
                              // ),
                              child: Html(
                                data: snapshot.data['content']['rendered'],
                                shrinkWrap: true,
                                onLinkTap: (String? url, RenderContext context,
                                    Map<String, String> attributes, element) {
                                  launchURL(url!);
                                },
                                style: htmlTextStyle(),
                              ),
                            ),

                            Divider(
                              color: kDividerColor,
                            ),

                            Container(
                              width: double.infinity,
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: ListView.builder(
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot
                                      .data['_embedded']['wp:term'][1].length,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    // vertical: 16.0,
                                  ),
                                  // itemExtent: 80,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(right: 8.0),
                                      child: Chip(
                                        label: Text(
                                          snapshot.data['_embedded']['wp:term']
                                                  [1][index]['name']
                                              .toString()
                                              .titleCase,
                                          style: appTextStyle(
                                            FontWeight.normal,
                                            10.0,
                                            Colors.white,
                                          ),
                                        ),
                                        backgroundColor: kPrimary,
                                        elevation: 0.5,
                                      ),
                                    );
                                  }),
                            ),

                            Divider(
                              color: kDividerColor,
                            ),

                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //     horizontal: 16.0,
                            //   ),
                            //   child: Text(
                            //     'सम्बन्धित समाचार',
                            //     style: appTextStyle(
                            //       FontWeight.bold,
                            //       16.0,
                            //       kPrimary,
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   margin: EdgeInsets.only(
                            //     bottom: 8.0,
                            //   ),
                            //   height: 1.0,
                            //   color: kSecondaryDark,
                            // ),
                            // FutureBuilder(
                            //   future: relatedNews,
                            //   builder: (BuildContext context,
                            //       AsyncSnapshot rnSnapshot) {
                            //     if (rnSnapshot.hasData) {
                            //       if (rnSnapshot.data != null) {
                            //         return ListView.builder(
                            //             // key: Key('builder ${selected.toString()}'),
                            //             physics: BouncingScrollPhysics(),
                            //             shrinkWrap: true,
                            //             itemCount: rnSnapshot.data.length,
                            //             itemBuilder:
                            //                 (BuildContext context, int index) {
                            //               return GestureDetector(
                            //                 onTap: (() {
                            //                   Navigator.push(
                            //                     context,
                            //                     MaterialPageRoute(
                            //                       builder: (context) =>
                            //                           BlogDetailScreen(
                            //                         title: rnSnapshot
                            //                             .data[index]['title']
                            //                                 ['rendered']
                            //                             .toString(),
                            //                         postId: rnSnapshot
                            //                             .data[index]['id']
                            //                             .toString(),
                            //                       ),
                            //                     ),
                            //                   );
                            //                 }),
                            //                 child: Container(
                            //                   padding: EdgeInsets.symmetric(
                            //                     vertical: 16.0,
                            //                     horizontal: 16.0,
                            //                   ),
                            //                   margin: EdgeInsets.only(
                            //                     bottom: 8.0,
                            //                   ),
                            //                   decoration: BoxDecoration(
                            //                     color: Colors.white,
                            //                   ),
                            //                   child: Row(
                            //                     children: [
                            //                       Expanded(
                            //                         flex: 4,
                            //                         child: Text(
                            //                           rnSnapshot.data[index]
                            //                                   ['title']
                            //                                   ['rendered']
                            //                               .toString(),
                            //                           style: appTextStyle(
                            //                             FontWeight.bold,
                            //                             18.0,
                            //                             kSecondary,
                            //                           ),
                            //                         ),
                            //                       ),
                            //                       SizedBox(
                            //                         width: 4.0,
                            //                       ),
                            //                       Expanded(
                            //                         flex: 2,
                            //                         child: FutureBuilder(
                            //                           future: imageURLCheck(snapshot
                            //                               .data['_embedded'][
                            //                                   'wp:featuredmedia']
                            //                               .first['source_url']),
                            //                           builder: (context,
                            //                               asyncSnapshot) {
                            //                             if (asyncSnapshot
                            //                                 .hasData) {
                            //                               if (asyncSnapshot
                            //                                       .data !=
                            //                                   null) {
                            //                                 return Container(
                            //                                   height: 80,
                            //                                   child:
                            //                                       Image.network(
                            //                                     rnSnapshot
                            //                                         .data[index]
                            //                                             [
                            //                                             '_embedded']
                            //                                             [
                            //                                             'wp:featuredmedia']
                            //                                         .first['source_url'],
                            //                                     fit:
                            //                                         BoxFit.fill,
                            //                                   ),
                            //                                 );
                            //                               } else {
                            //                                 return Container(
                            //                                   // color: Colors.black,
                            //                                   width: 80,
                            //                                   child:
                            //                                       CircleAvatar(
                            //                                     radius: 60,
                            //                                     backgroundColor:
                            //                                         Colors
                            //                                             .transparent,
                            //                                     backgroundImage:
                            //                                         AssetImage(
                            //                                       "assets/images/no_image.png",
                            //                                     ),
                            //                                   ),
                            //                                 );
                            //                               }
                            //                             } else {
                            //                               return Container(
                            //                                 color: Colors.white,
                            //                                 height: 80,
                            //                                 child: Center(
                            //                                   child:
                            //                                       CupertinoActivityIndicator(),
                            //                                 ),
                            //                               );
                            //                             }
                            //                           },
                            //                         ),

                            //                         // Container(
                            //                         //   height: 80,
                            //                         //   decoration: BoxDecoration(
                            //                         //     color: Colors.amber,
                            //                         //     image: DecorationImage(
                            //                         //       image: NetworkImage(
                            //                         //         'https://www.khaltinews.com/wp-content/uploads/2020/12/Madhav-kumar-Nepal-KhaltiNews-1000x600.jpg',
                            //                         //       ),
                            //                         //       fit: BoxFit.fill,
                            //                         //     ),
                            //                         //   ),
                            //                         // ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               );
                            //             });
                            //       } else {
                            //         return Container();
                            //       }
                            //     } else {
                            //       return Container(
                            //         color: Colors.white,
                            //         // height: 200,
                            //         child: Center(
                            //           child: CupertinoActivityIndicator(),
                            //         ),
                            //       );
                            //     }
                            //   },
                            // ),
                          ],
                        ),
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
                            'No news found',
                            style: appTextStyle(
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
      ),
    );
  }
}
