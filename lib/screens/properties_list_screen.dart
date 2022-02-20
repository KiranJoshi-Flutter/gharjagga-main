import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharjagga/models/properties_list_model.dart';
// import 'package:gharjagga/screens/detail_screen.dart';
import 'package:gharjagga/views/property_detail_screen.dart';
import 'package:gharjagga/widgets/new_buildings.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:gharjagga/utlis/constant.dart';
// import 'package:gharjagga/widgets/blast_apartment.dart';
import 'package:http/http.dart' as http;
import 'package:recase/recase.dart';

class PropertiesListScreen extends StatefulWidget {
  final String title;
  // final String propertyTypeId;
  final String propertyURL;

  PropertiesListScreen(
    this.title,
    // this.propertyTypeId,
    this.propertyURL,
  );

  @override
  _PropertiesListScreenState createState() => _PropertiesListScreenState();
}

class _PropertiesListScreenState extends State<PropertiesListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  // int _currentMax = 10;
  late Future<PropertyTypeModel?> _properties;

  late List<dynamic> propertyList;

  var lastPage = 0;
  var currentPage = 1;
  var isLastPage = false;

  var totalResults = 0;

  final oCcy = new NumberFormat("##,###");

  @override
  void initState() {
    super.initState();
    _properties = _fetchProperties();
    propertyList = [];

    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     _getMoreData();
    //   }
    // });
  }

  Future<PropertyTypeModel?> _fetchProperties() async {
    final request = await http.get(
      Uri.parse(
        "${widget.propertyURL}",
      ),
    );

    var res = json.decode(request.body);

    // print(
    //     "request.headers['x-wp-totalpages'] ${request.headers['x-wp-totalpages']}");

    print(res);

    if (request.statusCode == 200) {
      PropertyTypeModel propertiesList =
          propertyTypeModelFromJson(request.body);

      if (propertiesList.data.length != 0) {
        int propertiesCount = propertiesList.data.length;

        print(propertiesCount);

        return propertiesList;
      } else {
        // print('No properties found');

        return propertiesList;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kThemeColor,
        title: Text(
          widget.title,
          style: appTextStyle(
            FontWeight.bold,
            20.0,
            Colors.white,
          ),
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      key: _scaffoldKey,
      body: FadedSlideAnimation(
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: FutureBuilder(
          future: _properties, // async work
          builder: (BuildContext context,
              AsyncSnapshot<PropertyTypeModel?> snapshot) {
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
                  if (snapshot.data!.data.length != 0) {
                    return FadedSlideAnimation(
                      child: Column(
                        children: [
                          Material(
                            elevation: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 16.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.title,
                                    style: appTextStyle(
                                      FontWeight.bold,
                                      18.0,
                                      kTextColor,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.total != 1
                                        ? '(${snapshot.data!.total} results)'
                                        : '(${snapshot.data!.total} result)',
                                    // '(${snapshot.data!.total} result)',
                                    // style: TextStyle(
                                    //   color: Colors.red,
                                    // ),
                                    style: appTextStyleWLS(
                                      FontWeight.bold,
                                      16.0,
                                      kThemeColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Expanded(
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
                                // if (index == propertyList.length) {
                                //   if (isLastPage) {
                                //     return Text(
                                //       '...',
                                //       style: appTextStyleWLS(
                                //         FontWeight.normal,
                                //         16.0,
                                //         Colors.black45,
                                //       ),
                                //       textAlign: TextAlign.center,
                                //     );
                                //   } else {
                                //     if (propertyList.length > 15) {
                                //       return Container(
                                //         // color: Colors.white,
                                //         child: Column(
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.center,
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           children: [
                                //             Align(
                                //               alignment: Alignment.center,
                                //               child: CircularProgressIndicator(
                                //                 backgroundColor: kPrimary,
                                //                 strokeWidth: 2,
                                //                 valueColor:
                                //                     AlwaysStoppedAnimation<
                                //                         Color>(
                                //                   kSecondary,
                                //                 ),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       );
                                //     } else {
                                //       return Container();
                                //     }
                                //   }
                                // }

                                var offerLists =
                                    snapshot.data!.data[index].offerType!;
                                String offerTypeLabel = '';

                                if (offerLists.length != 0) {
                                  if (offerLists.length == 1) {
                                    offerTypeLabel = offerLists[0].name;
                                  } else if (offerLists.length >= 1) {
                                    offerTypeLabel = offerLists[1].name;
                                  } else {
                                    offerTypeLabel = '';
                                  }
                                } else {
                                  offerTypeLabel = '';
                                }

                                return GestureDetector(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PropertyDetailScreen(
                                          snapshot.data!.data[index].id
                                              .toString(),
                                          snapshot.data!.data[index].offerType!
                                                      .length >
                                                  1
                                              ? snapshot.data!.data[index]
                                                  .offerType![1].name
                                              : snapshot.data!.data[index]
                                                  .offerType!.first.name,
                                          snapshot.data!.data[index],
                                        ),
                                      ),
                                    );
                                  }),
                                  child: NewBuildings(
                                    photoAddress: snapshot
                                                .data!.data[index].image !=
                                            ''
                                        ? snapshot.data!.data[index].image
                                        : 'https://gharjhagga.com/wp-content/uploads/2021/11/no-image.png',
                                    buildings: snapshot.data!.data[index].name
                                        .toString()
                                        .titleCase,
                                    price: snapshot
                                        .data!.data[index].price![0].price
                                        .replaceAll('RS', ''),
                                    address: snapshot.data!.data[index].address,
                                    offerType: offerTypeLabel,
                                    rating: null,
                                    bedroom: snapshot
                                                .data!
                                                .data[index]
                                                .attributes![6]
                                                .values!
                                                .length ==
                                            0
                                        ? '0'
                                        : '${snapshot.data!.data[index].attributes![6].values![0].value}',
                                    // bathroom: 'check',
                                    bathroom: snapshot
                                                .data!
                                                .data[index]
                                                .attributes![7]
                                                .values!
                                                .length ==
                                            0
                                        ? '0'
                                        : '${snapshot.data!.data[index].attributes![7].values![0].value}',
                                    // propertySize: 'size',
                                    propertySize: snapshot
                                                .data!
                                                .data[index]
                                                .attributes![8]
                                                .values!
                                                .length ==
                                            0
                                        ? '0'
                                        : '${snapshot.data!.data[index].attributes![8].values![0].value}',
                                    // neighborhood: 'neigh',
                                    neighborhood: snapshot
                                                .data!
                                                .data[index]
                                                .attributes![4]
                                                .values!
                                                .length ==
                                            0
                                        ? '0'
                                        : '${snapshot.data!.data[index].attributes![4].values![0].name}',
                                    // street: 'street',
                                    street: snapshot
                                                .data!
                                                .data[index]
                                                .attributes![5]
                                                .values!
                                                .length ==
                                            0
                                        ? ''
                                        : '${snapshot.data!.data[index].attributes![5].values![0].name}',
                                    // city: 'check',
                                    city: snapshot
                                                .data!
                                                .data[index]
                                                .attributes![2]
                                                .values!
                                                .length ==
                                            0
                                        ? ''
                                        : '${snapshot.data!.data[index].attributes![2].values![0].name}',
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
                              itemCount: snapshot.data!.data.length,
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

        // Container(),
      ),
    );
  }
}
