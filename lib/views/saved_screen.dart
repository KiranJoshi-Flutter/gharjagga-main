import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gharjagga/functions/functions.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:gharjagga/utlis/userpreferences.dart';
import 'package:gharjagga/views/blog_detail_screen.dart';
// import 'package:gharjagga/widgets/drop_down_below_widget.dart';
// import 'package:gharjagga/widgets/drop_down_below_widget.dart';
import 'package:gharjagga/widgets/new_buildings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:gharjagga/widgets/saved_list.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:recase/recase.dart';
import 'package:intl/intl.dart';
import 'package:getwidget/getwidget.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  String dropdownValue = 'Price';

  late Future savedProperties;
  final oCcy = new NumberFormat("##,###");

  @override
  void initState() {
    super.initState();
    // dbHelper = DBHelper();
    // init();
    savedProperties = _fetchSavedProperties();
    // print(dbHelper);
  }

  Future _fetchSavedProperties() async {
    print('aaaa');
    var userId = await UserPreferences.getUserId();
    var resvalue;

    var properties = await FirebaseFirestore.instance
        .collection('wishlist')
        .where(
          'userId',
          isEqualTo: userId,
        )
        .get();
    print("properties.docs = ${properties.docs.length}");

    if (properties.docs.length != 0) {
      List<dynamic> list = [];

      list = properties.docs.map((doc) => doc.data()).toList();

      print(list);
      return list;
    } else {
      return null;
    }
    // await FirebaseFirestore.instance
    //     .collection('wishlist')
    //     .where(
    //       'userId',
    //       isEqualTo: userId,
    //     )
    //     .get()
    //     .then((value) {
    //   print("value.docs.length = ${value.docs.first}");

    //   resvalue = value.docs;

    //   print(value.docs);

    //   // jsonDecode(value.docs);
    //   // if (value.docs.length != 0) {
    //   //   print('Saved');
    //   // } else {}
    // });

    // if (resvalue != null) {
    // List<dynamic> list = [];

    // list = resvalue.map((doc) => doc.data()).toList();

    // print(list);
    // return list;
    // } else {
    //   return null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/icons/filter_screen/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                // color: Colors.blue,
                padding: EdgeInsets.only(
                  top: 38.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Saved Properties',
                        style: appTextStyle(
                          FontWeight.w600,
                          24.0,
                          Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: 25.0,
                  right: 25.0,
                  top: 30.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                        // color: Colors.black,
                        // height: 38.0,
                        // width: 160.0,
                        // color: Colors.green,
                        // child: DropDownBelowWidget(),
                        ),
                    Expanded(
                      child: FutureBuilder(
                        future: savedProperties, // async work
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
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
                                    child: ListView.builder(
                                      // controller: _scrollController,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data.length,
                                      padding: EdgeInsets.symmetric(
                                          // horizontal: 8.0,
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
                                                  title: snapshot.data[index]
                                                          ['propertyName']
                                                          ['rendered']
                                                      .toString(),
                                                  postId: snapshot.data[index]
                                                          ['propertyId']
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Stack(
                                            children: [
                                              Card(
                                                elevation: 0,
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: SavedPropertyList(
                                                  buildings: snapshot
                                                      .data[index]
                                                          ['propertyName']
                                                      .toString()
                                                      .titleCase,
                                                  address: null,
                                                  rating: 4.2,
                                                  price: snapshot
                                                          .data[index]
                                                              ['propertyPrice']
                                                          .isNotEmpty
                                                      ? '${snapshot.data[index]['propertyPrice']}'
                                                      : '-',
                                                  photoAddress:
                                                      snapshot.data[index]
                                                          ['propertyImage'],
                                                  offerType: snapshot
                                                      .data[index]['offerType'],
                                                  bedroom: snapshot.data[index]
                                                              ['bedroom']
                                                          .toString()
                                                          .isNotEmpty
                                                      ? snapshot.data[index][
                                                                      'bedroom']
                                                                  .toString() !=
                                                              'null'
                                                          ? snapshot.data[index]
                                                                  ['bedroom']
                                                              .toString()
                                                          : '0'
                                                      : '0',
                                                  bathroom: snapshot.data[index]
                                                              ['bathroom']
                                                          .toString()
                                                          .isNotEmpty
                                                      ? snapshot.data[index][
                                                                      'bathroom']
                                                                  .toString() !=
                                                              'null'
                                                          ? snapshot.data[index]
                                                                  ['bathroom']
                                                              .toString()
                                                          : '0'
                                                      : '0',
                                                  propertySize: snapshot
                                                          .data[index]
                                                              ['propertySIze']
                                                          .toString()
                                                          .isNotEmpty
                                                      ? snapshot.data[index][
                                                                      'propertySIze']
                                                                  .toString() !=
                                                              'null'
                                                          ? snapshot.data[index]
                                                                  [
                                                                  'propertySIze']
                                                              .toString()
                                                          : '0'
                                                      : '0',
                                                ),
                                              ),
                                              Positioned(
                                                right: -8.0,
                                                top: -8.0,
                                                child: GFIconButton(
                                                  size: GFSize.MEDIUM,
                                                  // shape:
                                                  //     GFIconButtonShape.circle,
                                                  // type: GFButtonType.outline,
                                                  color: Colors.transparent,
                                                  onPressed: () async {
                                                    // print(snapshot.data);

                                                    final snackBar =
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                      SnackBar(
                                                        content: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CircularProgressIndicator(
                                                              color:
                                                                  kThemeColor,
                                                              backgroundColor:
                                                                  kPrimary,
                                                              strokeWidth: 1.5,
                                                            ),
                                                            SizedBox(
                                                              width: 16.0,
                                                            ),
                                                            Text(
                                                              'Deleting from wishlist.....',
                                                              style:
                                                                  appTextStyle(
                                                                FontWeight.bold,
                                                                16.0,
                                                                Colors.white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        duration:
                                                            Duration(hours: 1),
                                                      ),
                                                    );

                                                    var userId =
                                                        await UserPreferences
                                                            .getUserId();

                                                    FirebaseFirestore.instance
                                                        .collection("wishlist")
                                                        .where("propertyId",
                                                            isEqualTo: snapshot
                                                                    .data[index]
                                                                ['propertyId'])
                                                        .where("userId",
                                                            isEqualTo: userId)
                                                        .get()
                                                        .then((value) {
                                                      value.docs
                                                          .forEach((element) {
                                                        print(element.id);
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "wishlist")
                                                            .doc(element.id)
                                                            .delete()
                                                            .then((value) {
                                                          setState(() {
                                                            savedProperties =
                                                                _fetchSavedProperties();
                                                          });
                                                          snackBar.close();
                                                          toastMeaasge(
                                                            'Property has been removed from saved list',
                                                            kGreenColor,
                                                            context,
                                                          );
                                                          print("Success!");
                                                        });
                                                      });
                                                    });
                                                  },
                                                  icon: Icon(
                                                    IconlyBold.close_square,
                                                    color: kRedColor,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    beginOffset: Offset(0, 0.3),
                                    endOffset: Offset(0, 0),
                                    slideCurve: Curves.linearToEaseOut,
                                  );
                                } else {
                                  return Container(
                                    color: Colors.white,
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          // color: Colors.black12,
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                                'No saved property found.',
                                                style: appTextStyleWLS(
                                                  FontWeight.w500,
                                                  12.0,
                                                  Colors.black54,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
