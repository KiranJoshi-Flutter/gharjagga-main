import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:gharjagga/utlis/userpreferences.dart';
import 'package:gharjagga/views/property_detail_screen.dart';
import 'package:gharjagga/widgets/new_buildings.dart';
import 'dart:core';

import 'package:gharjagga/utlis/constant.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:recase/recase.dart';

class ProfileRentHistoryTabView extends StatefulWidget {
  @override
  _ProfileRentHistoryTabViewState createState() =>
      _ProfileRentHistoryTabViewState();
}

class _ProfileRentHistoryTabViewState extends State<ProfileRentHistoryTabView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final f = new DateFormat('dd/MM/yyyy');

  late Future _properties;

  late List<dynamic> propertyList;
  final oCcy = new NumberFormat("##,###");

  // https://gharjhagga.com/wp-json/wp/v2/estate?author=18&orderby=date&_embed

  @override
  void initState() {
    super.initState();

    _properties = _fetchProperties();
    propertyList = [];
  }

  Future _fetchProperties() async {
    var userId = await UserPreferences.getUserId();
    print(
        "https://gharjhagga.com/wp-json/wp/v2/estate?author=$userId&orderby=date&_embed");
    final request = await http.get(
      Uri.parse(
        "https://gharjhagga.com/wp-json/wp/v2/estate?author=$userId&orderby=date&_embed",
      ),
    );

    var res = json.decode(request.body);

    print(
        "request.headers['x-wp-totalpages'] ${request.headers['x-wp-totalpages']}");

    if (res.length != 0) {
      setState(() {
        propertyList = res;
      });

      // print("Current Page = $currentPage");

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
                  if (propertyList.length != 0) {
                    return FadedSlideAnimation(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                // vertical: 16.0,
                              ),
                              // itemExtent: 80,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (() {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         PropertyDetailScreen(
                                    //       snapshot.data[index]['id'].toString(),
                                    //       snapshot
                                    //           .data[index]['_embedded']
                                    //               ['wp:term'][1]
                                    //           .last['name'],
                                    //     ),
                                    //   ),
                                    // );
                                  }),
                                  child: NewBuildings(
                                    photoAddress: snapshot.data[index]
                                                ['featured_media'] !=
                                            0
                                        ? snapshot.data[index]['_embedded']
                                                ['wp:featuredmedia'][0]
                                            ['source_url']
                                        : 'http://www.cocap.org.np/assets/uploads/news/aroYWJ7TzgVcb.jpg',
                                    buildings:
                                        "${snapshot.data[index]['title']['rendered'].toString().titleCase}",
                                    price: snapshot.data[index]
                                                ['estate_attr_price']
                                            .toString()
                                            .isNotEmpty
                                        ? oCcy.format(
                                            int.parse(
                                              snapshot.data[index]
                                                  ['estate_attr_price'],
                                            ),
                                          )
                                        : 'N.A.',
                                    address: null,
                                    offerType: snapshot
                                                .data[index]['_embedded']
                                                    ['wp:term'][1]
                                                .length !=
                                            0
                                        ? snapshot.data[index]['_embedded']
                                            ['wp:term'][1][0]['name']
                                        : '-',
                                    rating: null,
                                    bedroom: snapshot.data[index]
                                                ['estate_attr_bedrooms']
                                            .toString()
                                            .isNotEmpty
                                        ? snapshot.data[index]
                                                        ['estate_attr_bedrooms']
                                                    .toString() !=
                                                'null'
                                            ? snapshot.data[index]
                                                    ['estate_attr_bedrooms']
                                                .toString()
                                            : '0'
                                        : '0',
                                    bathroom: snapshot.data[index]
                                                ['estate_attr_bathrooms']
                                            .toString()
                                            .isNotEmpty
                                        ? snapshot.data[index][
                                                        'estate_attr_bathrooms']
                                                    .toString() !=
                                                'null'
                                            ? snapshot.data[index]
                                                    ['estate_attr_bathrooms']
                                                .toString()
                                            : '0'
                                        : '0',
                                    propertySize: snapshot.data[index]
                                                ['estate_attr_property-size']
                                            .toString()
                                            .isNotEmpty
                                        ? snapshot.data[index][
                                                        'estate_attr_property-size']
                                                    .toString() !=
                                                'null'
                                            ? snapshot.data[index][
                                                    'estate_attr_property-size']
                                                .toString()
                                            : '0'
                                        : '0',
                                    neighborhood: snapshot
                                                .data[index]['neighborhood']
                                                .length !=
                                            0
                                        ? snapshot.data[index]['_embedded']
                                            ['wp:term'][4][0]['name']
                                        : '',
                                    street:
                                        snapshot.data[index]['street'].length !=
                                                0
                                            ? snapshot.data[index]['_embedded']
                                                ['wp:term'][5][0]['name']
                                            : '',
                                    city:
                                        snapshot.data[index]['city'].length != 0
                                            ? snapshot.data[index]['_embedded']
                                                ['wp:term'][2][0]['name']
                                            : '',
                                  ),
                                );

                                // if (index != 0) {
                                //   return GestureDetector(
                                //     onTap: (() {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) => DetailScreen(),
                                //         ),
                                //       );
                                //     }),
                                //     child: NewBuildings(
                                //       photoAddress: snapshot.data[index]
                                //                   ['featured_media'] !=
                                //               0
                                //           ? snapshot.data[index]['_embedded']
                                //               ['wp:featuredmedia'][0]['source_url']
                                //           : 'http://www.cocap.org.np/assets/uploads/news/aroYWJ7TzgVcb.jpg',
                                //       buildings: snapshot.data[index]['title']
                                //               ['rendered']
                                //           .toString()
                                //           .titleCase,
                                //       price: oCcy.format(int.parse(
                                //           snapshot.data[index]['estate_attr_price'])),
                                //       address: null,
                                //       offerType: snapshot.data[index]['_embedded']
                                //           ['wp:term'][1][0]['name'],
                                //       rating: null,
                                //     ),
                                //   );
                                // } else {
                                //   return GestureDetector(
                                //     onTap: (() {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) => DetailScreen(),
                                //         ),
                                //       );
                                //     }),
                                //     child: Container(
                                //       width: double.infinity,
                                //       decoration: BoxDecoration(
                                //         color: Colors.white,
                                //       ),
                                //       margin: EdgeInsets.only(
                                //         bottom: 8.0,
                                //       ),
                                //       padding: EdgeInsets.only(
                                //         bottom: 8.0,
                                //       ),
                                //       child: Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: [
                                //           Container(
                                //             padding: EdgeInsets.symmetric(
                                //               horizontal: 16.0,
                                //             ),
                                //             child: Text(
                                //               snapshot.data[index]['title']
                                //                       ['rendered']
                                //                   .toString(),
                                //               style: appTextStyleWLS(
                                //                 FontWeight.normal,
                                //                 20.0,
                                //                 kSecondary,
                                //               ),
                                //               // textAlign: TextAlign.center,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   );
                                // }
                              },
                              itemCount: propertyList.length,
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
                            'No property found',
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

        // child: Container(
        //   // decoration: BoxDecoration(color: kPrimary),
        //   child: ListView.builder(
        //       itemCount: 4,
        //       shrinkWrap: true,
        //       physics: BouncingScrollPhysics(),
        //       padding: EdgeInsets.only(
        //         top: 4.0,
        //         left: 20.0,
        //         bottom: 8.0,
        //         right: 20.0,
        //       ),
        //       itemBuilder: (BuildContext ctxt, int index) {
        //         return Card(
        //           elevation: 0,
        //           color: Colors.white,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(16),
        //           ),
        //           child: Padding(
        //             padding: EdgeInsets.symmetric(
        //               vertical: 8.0,
        //               horizontal: 8.0,
        //             ),
        //             child: Row(
        //               children: [
        //                 Expanded(
        //                   flex: 4,
        //                   child: Container(
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(
        //                         16.0,
        //                       ),
        //                       color: kBorderColor,
        //                     ),
        //                     height: 130,
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   width: 8.0,
        //                 ),
        //                 Expanded(
        //                   flex: 6,
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     children: [
        //                       Text(
        //                         "Luxury Hotel",
        //                         style: appTextStyle(
        //                           FontWeight.w700,
        //                           16.0,
        //                           kTextColor,
        //                         ),
        //                       ),
        //                       SizedBox(
        //                         height: 4.0,
        //                       ),
        //                       Row(
        //                         children: <Widget>[
        //                           Icon(
        //                             IconlyBold.location,
        //                             size: 12,
        //                             color: kTextHintColor,
        //                           ),
        //                           SizedBox(
        //                             width: 4.0,
        //                           ),
        //                           Text(
        //                             "Bandung, Indonesia",
        //                             style: appTextStyle(
        //                               FontWeight.w500,
        //                               12.0,
        //                               kTextHintColor,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                       SizedBox(height: 16.0),
        //                       Container(
        //                         height: 0.75,
        //                         color: kDividerColor.withOpacity(0.2),
        //                       ),
        //                       SizedBox(height: 16.0),
        //                       Row(
        //                         children: [
        //                           Expanded(
        //                             child: Column(
        //                               children: [
        //                                 Row(
        //                                   children: [
        //                                     Expanded(
        //                                       flex: 4,
        //                                       child: Text(
        //                                         'Check In',
        //                                         style: appTextStyle(
        //                                           FontWeight.normal,
        //                                           14,
        //                                           kTextColor,
        //                                         ),
        //                                       ),
        //                                     ),
        //                                     Expanded(
        //                                       flex: 2,
        //                                       child: Icon(
        //                                         IconlyBold.arrow_down,
        //                                         size: 16,
        //                                         color: kGreenColor,
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 ),
        //                                 SizedBox(
        //                                   height: 8.0,
        //                                 ),
        //                                 Text(
        //                                   f.format(
        //                                     DateTime.now()
        //                                         .subtract(
        //                                           new Duration(days: 2),
        //                                         )
        //                                         .toLocal(),
        //                                   ),
        //                                   style: appTextStyle(
        //                                     FontWeight.bold,
        //                                     10,
        //                                     kTextHintColor,
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             width: 8.0,
        //                           ),
        //                           Expanded(
        //                             child: Column(
        //                               children: [
        //                                 Row(
        //                                   children: [
        //                                     Expanded(
        //                                       child: Text(
        //                                         'Check Out',
        //                                         style: appTextStyle(
        //                                           FontWeight.normal,
        //                                           14,
        //                                           kTextColor,
        //                                         ),
        //                                       ),
        //                                     ),
        //                                     Icon(
        //                                       IconlyBold.arrow_up,
        //                                       size: 16,
        //                                       color: kRedColor,
        //                                     )
        //                                   ],
        //                                 ),
        //                                 SizedBox(
        //                                   height: 8.0,
        //                                 ),
        //                                 Text(
        //                                   f.format(
        //                                     DateTime.now().toLocal(),
        //                                   ),
        //                                   style: appTextStyle(
        //                                     FontWeight.bold,
        //                                     10,
        //                                     kTextHintColor,
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                 )
        //                 // Expanded(
        //                 //   child: Text(
        //                 //     'Account',
        //                 //     style: appTextStyle(
        //                 //       FontWeight.normal,
        //                 //       14.0,
        //                 //       kTextColor,
        //                 //     ),
        //                 //   ),
        //                 // ),
        //                 // SizedBox(
        //                 //   width: 8.0,
        //                 // ),
        //                 // Icon(
        //                 //   Icons.chevron_left_rounded,
        //                 //   color: kThemeColor,
        //                 // ),
        //               ],
        //             ),
        //           ),
        //         );
        //       }),
        //   // shrinkWrap: true,
        //   // physics: BouncingScrollPhysics(),
        //   // padding: EdgeInsets.only(
        //   //   top: 4.0,
        //   //   left: 20.0,
        //   //   bottom: 8.0,
        //   //   right: 20.0,
        //   // ),
        //   // children: [
        //   //                 SizedBox(
        //   //     height: 8.0,
        //   //   ),
        //   // ],
        // ),
      ),
    );
  }
}
