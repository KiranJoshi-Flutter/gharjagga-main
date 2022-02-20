import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharjagga/functions/dbHelper.dart';
import 'package:gharjagga/functions/functions.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:gharjagga/utlis/userpreferences.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:recase/recase.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyDetailScreen extends StatefulWidget {
  final String propertyId;
  final String offerType;

  PropertyDetailScreen(
    this.propertyId,
    this.offerType,
  );

  @override
  _PropertyDetailScreenState createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late Future propertyDetail;

  final oCcy = new NumberFormat("##,###");

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final List<String> imageList = [];
  bool isSaved = false;

  // late DBHelper dbHelper;

  @override
  void initState() {
    super.initState();
    // dbHelper = DBHelper();
    init();
    propertyDetail = _fetchPropertyDetail();
    // print(dbHelper);
  }

  init() async {
    var userId = await UserPreferences.getUserId();
    var count = 0;
    print(widget.propertyId);
    var properties = FirebaseFirestore.instance
        .collection('wishlist')
        .where(
          'propertyId',
          isEqualTo: widget.propertyId,
        )
        .where(
          'userId',
          isEqualTo: userId,
        );

    properties.get().then((value) {
      print("value.docs.length = ${value.docs}");
      count = value.docs.length;
      if (count != 0) {
        setState(() {
          isSaved = true;
        });
        print('Saved');
      } else {
        setState(() {
          isSaved = false;
        });
      }
    });

    print("isSaved = $isSaved");
  }

  Future _fetchPropertyDetail() async {
    print(
        "https://gharjhagga.com/wp-json/wp/v2/estate/${widget.propertyId}?_embed");
    final request = await http.get(
      Uri.parse(
        "https://gharjhagga.com/wp-json/wp/v2/estate/${widget.propertyId}?_embed",
      ),
    );

    var res = json.decode(request.body);

    if (res.containsKey("id")) {
      // print('id');

      // imageList.add(res['_embedded']['wp:featuredmedia'].first['source_url']);
      print(res['estate_gallery'].length);
      for (int a = 0; a < res['estate_gallery'].length; a++) {
        print('Featured Media = ${res['featured_media']}');
        print('Gallery = ${int.parse(res['estate_gallery'][0])}');
        if (res['featured_media'] != int.parse(res['estate_gallery'][0]))
          imageList.add(
            await fetchMediaURL(
              res['estate_gallery'][a],
            ),
          );
      }
      return res;
    } else {
      return null;
    }

    // if (res.length != 0) {
    //   return res;
    // } else {
    //   return null;
    // }
  }

  Future fetchMediaURL(String mediaId) async {
    print(mediaId);

    // var headers = {'Authorization': 'Basic eW9nOTgyNzg6TmVwYWxAMTIz'};
    var request = http.Request(
      'GET',
      Uri.parse(
        'https://gharjhagga.com/wp-json/wp/v2/media/$mediaId',
      ),
    );

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      // var res = json.decode(request.body);
      var responseJSON = await response.stream.bytesToString();
      var res = json.decode(responseJSON);

      if (res.containsKey("id")) {
        print(res['source_url']);
        return res['source_url'];
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      key: _scaffoldKey,
      // appBar: AppBar(
      //   backgroundColor: theme.backgroundColor,
      // ),
      body: FadedSlideAnimation(
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: FutureBuilder(
          future: propertyDetail, // async work
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: 36,
                          ),
                          Container(
                            // height: 350,
                            height: 275,
                            // color: Colors.black26,
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 250,
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                          enlargeCenterPage: true,
                                          enableInfiniteScroll: false,
                                          autoPlay: false,
                                          viewportFraction: 0.9,
                                        ),
                                        items: imageList
                                            .map(
                                              (e) => ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Image.network(
                                                      e,
                                                      // width: 1050,
                                                      height: 350.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      // child: ClipRRect(
                                      //   // borderRadius: BorderRadius.circular(8),
                                      //   child: Stack(
                                      //     fit: StackFit.expand,
                                      //     children: [
                                      //       Image.network(
                                      // snapshot
                                      //     .data['_embedded']
                                      //         ['wp:featuredmedia']
                                      //     .first['source_url'],
                                      //         width: 1050,
                                      //         height: 350.0,
                                      //         fit: BoxFit.cover,
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 0.0,
                                  left: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xffEC5A22),
                                      ),
                                      color: Color(0xffEC5A22),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8.0,
                                    ),
                                    // color: Colors.white,
                                    child: InkWell(
                                      onTap: (() {
                                        Navigator.of(context).pop();
                                      }),
                                      child: Icon(
                                        IconlyLight.arrow_left_2,
                                        size: 24.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // top: 16.0,

                                  bottom: 0,
                                  right: 16,
                                  child: GestureDetector(
                                    onTap: (() async {
                                      if (!isSaved) {
                                        final snackBar =
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CircularProgressIndicator(
                                                  color: kThemeColor,
                                                  backgroundColor: kPrimary,
                                                  strokeWidth: 1.5,
                                                ),
                                                SizedBox(
                                                  width: 16.0,
                                                ),
                                                Text(
                                                  'Saving.....',
                                                  style: appTextStyle(
                                                    FontWeight.bold,
                                                    16.0,
                                                    Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            duration: Duration(hours: 1),
                                          ),
                                        );

                                        var userId =
                                            await UserPreferences.getUserId();
                                        firestore.collection("wishlist").add({
                                          'propertyId': widget.propertyId,
                                          'propertyName':
                                              snapshot.data['title'],
                                          'propertyImage': snapshot
                                              .data['_embedded']
                                                  ['wp:featuredmedia']
                                              .first['source_url'],
                                          'propertyPrice': snapshot
                                              .data['estate_attr_price'],
                                          'offerType': widget.offerType,
                                          'bathroom': snapshot
                                              .data['estate_attr_bathrooms'],
                                          'bedroom': snapshot
                                              .data['estate_attr_bedrooms'],
                                          'propertySIze': snapshot.data[
                                              'estate_attr_property-size'],
                                          'propertySIze': snapshot.data[
                                              'estate_attr_property-size'],
                                          'propertySIze': snapshot.data[
                                              'estate_attr_property-size'],
                                          'propertySIze': snapshot.data[
                                              'estate_attr_property-size'],
                                          'userId': userId,
                                        }).then((value) {
                                          print('Success');
                                          snackBar.close();
                                          setState(() {
                                            isSaved = !isSaved;
                                          });
                                          toastMeaasge(
                                            'Saved successfully.',
                                            kGreenColor,
                                            context,
                                          );
                                        });
                                      } else {
                                        toastMeaasge(
                                          'Already saved property.',
                                          kRedColor,
                                          context,
                                        );
                                      }
                                    }),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      // color: kTextColorLight,
                                      decoration: BoxDecoration(
                                        color: !isSaved
                                            ? kButtonBg
                                            : kButtonBg.withOpacity(0.25),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                      child: Icon(
                                        IconlyBold.bookmark,
                                        size: 24.0,
                                        color: !isSaved
                                            ? Colors.white
                                            : kThemeColor,
                                      ),
                                    ),
                                  ),
                                  // child: Container(
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(
                                  //     color: Color(0xffEC5A22),
                                  //   ),
                                  //   color: Color(0xffEC5A22),
                                  //   borderRadius: BorderRadius.all(
                                  //     Radius.circular(16),
                                  //   ),
                                  // ),
                                  //   margin: EdgeInsets.symmetric(
                                  //     horizontal: 27,
                                  //   ),
                                  //   padding: EdgeInsets.symmetric(
                                  //     horizontal: 8,
                                  //     vertical: 8.0,
                                  //   ),
                                  //   // color: Colors.white,
                                  //   child: InkWell(
                                  //     onTap: (() {
                                  //       Navigator.of(context).pop();
                                  //     }),
                                  //   child: Icon(
                                  //     IconlyLight.arrow_left_2,
                                  //     size: 24.0,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  // ),
                                )
                              ],
                            ),
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              // width: double.infinity,
                              // color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${snapshot.data['title']['rendered'].toString().titleCase}',
                                    style: appTextStyle(
                                      FontWeight.bold,
                                      22.0,
                                      kTextColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),

                                  Text(
                                    snapshot.data['estate_attr_price']
                                            .toString()
                                            .isNotEmpty
                                        ? 'Rs. ${oCcy.format(int.parse(snapshot.data['estate_attr_price']))} /-'
                                        : '-',
                                    style: appTextStyle(
                                      FontWeight.bold,
                                      18.0,
                                      kThemeColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        IconlyBold.call,
                                        size: 16.0,
                                        color: kTextColor,
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          '+977-9861584767 / 9843725632',
                                          style: appTextStyle(
                                            FontWeight.bold,
                                            12.0,
                                            kTextColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Chip(
                                    label: Text(
                                      widget.offerType.toUpperCase(),
                                      style: appTextStyleWLS(
                                        FontWeight.bold,
                                        10.0,
                                        Colors.white,
                                      ),
                                    ),
                                    backgroundColor: kSecondary,
                                    elevation: 0.5,
                                  ),

                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    children: [
                                      snapshot.data['estate_attr_bedrooms'] !=
                                              ""
                                          ? Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          8.0,
                                                        ),
                                                      ),
                                                      color: Color(0xFFE7E7E9),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: ImageIcon(
                                                          AssetImage(
                                                            "assets/icons/blast_apartment/Group415.png",
                                                          ),
                                                          color: kTextColor,
                                                          // size: 8.0,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        snapshot.data[
                                                            'estate_attr_bedrooms'],
                                                        style: appTextStyle(
                                                          FontWeight.bold,
                                                          14.0,
                                                          kTextColor,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      snapshot.data['estate_attr_bathrooms'] !=
                                              ""
                                          ? Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          8.0,
                                                        ),
                                                      ),
                                                      color: Color(0xFFE7E7E9),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: ImageIcon(
                                                          AssetImage(
                                                              "assets/icons/blast_apartment/Group419.png"),
                                                          color: kTextColor,
                                                          // size: 8.0,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        snapshot.data[
                                                            'estate_attr_bathrooms'],
                                                        style: appTextStyle(
                                                          FontWeight.bold,
                                                          14.0,
                                                          kTextColor,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      snapshot.data[
                                                  'estate_attr_property-size'] !=
                                              ""
                                          ? Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          8.0,
                                                        ),
                                                      ),
                                                      color: Color(0xFFE7E7E9),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: ImageIcon(
                                                          AssetImage(
                                                              "assets/icons/blast_apartment/Group417.png"),
                                                          color: kTextColor,
                                                          // size: 8.0,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${snapshot.data['estate_attr_property-size']} ft²",
                                                        style: appTextStyle(
                                                          FontWeight.bold,
                                                          14.0,
                                                          kTextColor,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Divider(
                                    color: kDividerColor,
                                    height: 1,
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
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
                                              snapshot.data['author'] != 1
                                                  ? snapshot
                                                      .data['_embedded']
                                                          ['author']
                                                      .last['name']
                                                      .toString()
                                                      .titleCase
                                                  : 'Gharjagga',
                                              style: appTextStyle(
                                                FontWeight.normal,
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
                                              style: appTextStyleWLS(
                                                FontWeight.normal,
                                                11.0,
                                                Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: kDividerColor,
                                    height: 1,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  // --------------------------- Location --------------------------- //
                                  Text(
                                    'Location',
                                    style: appTextStyle(
                                      FontWeight.bold,
                                      18.0,
                                      kTextColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // padding: EdgeInsets.only(top: 2),
                                        child: Icon(
                                          IconlyBold.location,
                                          size: 20.0,
                                          color: kTextHintColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4.0,
                                      ),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            text: snapshot.data['neighborhood']
                                                        .length !=
                                                    0
                                                ? snapshot
                                                    .data['_embedded']
                                                        ['wp:term'][4]
                                                    .last['name']
                                                : '',
                                            style: appTextStyle(
                                              FontWeight.w500,
                                              16.0,
                                              kTextHintColor,
                                            ),
                                            children: [
                                              snapshot.data['neighborhood']
                                                          .length !=
                                                      0
                                                  ? TextSpan(
                                                      text: ",",
                                                      style: appTextStyle(
                                                        FontWeight.w500,
                                                        16.0,
                                                        kTextHintColor,
                                                      ),
                                                    )
                                                  : TextSpan(),
                                              TextSpan(
                                                text: snapshot.data['city']
                                                            .length !=
                                                        0
                                                    ? " ${snapshot.data['_embedded']['wp:term'][2].last['name']}"
                                                    : '',
                                                style: appTextStyle(
                                                  FontWeight.w500,
                                                  16.0,
                                                  kTextHintColor,
                                                ),
                                              ),
                                              snapshot.data['street'].length !=
                                                      0
                                                  ? TextSpan(
                                                      text:
                                                          " (${snapshot.data['_embedded']['wp:term'][5].last['name']})",
                                                      style: appTextStyle(
                                                        FontWeight.w500,
                                                        16.0,
                                                        kTextHintColor,
                                                      ),
                                                    )
                                                  : TextSpan(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // --------------------------- Location --------------------------- //
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Divider(
                                    color: kDividerColor,
                                    height: 1,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    'Description',
                                    style: appTextStyle(
                                      FontWeight.bold,
                                      18.0,
                                      kTextColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Html(
                                    data: snapshot.data['content']['rendered'],
                                    shrinkWrap: true,
                                    onLinkTap: (String? url,
                                        RenderContext context,
                                        Map<String, String> attributes,
                                        element) {
                                      launchURL(url!);
                                    },
                                    style: htmlTextStyle(),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Divider(
                                    color: kDividerColor,
                                    height: 1,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  snapshot.data['features'].length != 0
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Features',
                                              style: appTextStyle(
                                                FontWeight.bold,
                                                18.0,
                                                kTextColor,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics: BouncingScrollPhysics(),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                              ),
                                              itemCount: snapshot
                                                  .data['features'].length,
                                              // itemExtent: 80,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 8.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                        16.0,
                                                      ),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 12.0,
                                                    horizontal: 16.0,
                                                  ),
                                                  child: Text(
                                                    snapshot.data['_embedded']
                                                            ['wp:term'][6]
                                                        [index]['name'],
                                                    style: appTextStyleWLS(
                                                      FontWeight.bold,
                                                      12.0,
                                                      kTabBarTextColor,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),

                          // Row(
                          //   children: [
                          //     Container(
                          //       decoration: BoxDecoration(
                          //         border: Border.all(
                          //           color: Color(0xffEC5A22),
                          //         ),
                          //         color: Color(0xffEC5A22),
                          //         borderRadius: BorderRadius.all(
                          //           Radius.circular(16),
                          //         ),
                          //       ),
                          //       margin: EdgeInsets.symmetric(
                          //         horizontal: 27,
                          //       ),
                          //       padding: EdgeInsets.symmetric(
                          //         horizontal: 8,
                          //         vertical: 8.0,
                          //       ),
                          //       // color: Colors.white,
                          //       child: InkWell(
                          //         onTap: (() {
                          //           Navigator.of(context).pop();
                          //         }),
                          //         child: Icon(
                          //           Icons.chevron_left_rounded,
                          //           size: 28.0,
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 120.0,
                          // ),
                        ],
                      ),
                      beginOffset: Offset(0, 0.3),
                      endOffset: Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                    );
                  } else {
                    return Container(
                      color: Colors.black12,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Stack(
                        children: [
                          Container(
                            // color: Colors.black12,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  'Something went wrong.',
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
                          Positioned(
                            top: 64.0,
                            left: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffEC5A22),
                                ),
                                color: Color(0xffEC5A22),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 27,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8.0,
                              ),
                              // color: Colors.white,
                              child: InkWell(
                                onTap: (() {
                                  Navigator.of(context).pop();
                                }),
                                child: Icon(
                                  IconlyLight.arrow_left_2,
                                  size: 24.0,
                                  color: Colors.white,
                                ),
                              ),
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

        // child: Column(
        //   children: [
        //     SizedBox(
        //       height: 32.25,
        //     ),
        //     Container(
        //       height: 350,
        //       color: Colors.black26,
        //       child: Stack(
        //         children: [
        //           Column(
        //             children: [
        //               Container(
        //                 width: double.infinity,
        //                 height: 250,
        //                 child: Image.network(
        //                   'https://gharjhagga.com/wp-content/uploads/2021/10/WhatsApp-Image-2021-09-21-at-8.13.57-PM-1.jpeg',
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //             ],
        //           ),
        //           Positioned(
        //             top: 16.0,
        //             left: 0,
        //             child: Container(
        //               decoration: BoxDecoration(
        //                 border: Border.all(
        //                   color: Color(0xffEC5A22),
        //                 ),
        //                 color: Color(0xffEC5A22),
        //                 borderRadius: BorderRadius.all(
        //                   Radius.circular(16),
        //                 ),
        //               ),
        //               margin: EdgeInsets.symmetric(
        //                 horizontal: 27,
        //               ),
        //               padding: EdgeInsets.symmetric(
        //                 horizontal: 8,
        //                 vertical: 8.0,
        //               ),
        //               // color: Colors.white,
        //               child: InkWell(
        //                 onTap: (() {
        //                   Navigator.of(context).pop();
        //                 }),
        //                 child: Icon(
        //                   IconlyLight.arrow_left_2,
        //                   size: 24.0,
        //                   color: Colors.white,
        //                 ),
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //     // Row(
        //     //   children: [
        //     //     Container(
        //     //       decoration: BoxDecoration(
        //     //         border: Border.all(
        //     //           color: Color(0xffEC5A22),
        //     //         ),
        //     //         color: Color(0xffEC5A22),
        //     //         borderRadius: BorderRadius.all(
        //     //           Radius.circular(16),
        //     //         ),
        //     //       ),
        //     //       margin: EdgeInsets.symmetric(
        //     //         horizontal: 27,
        //     //       ),
        //     //       padding: EdgeInsets.symmetric(
        //     //         horizontal: 8,
        //     //         vertical: 8.0,
        //     //       ),
        //     //       // color: Colors.white,
        //     //       child: InkWell(
        //     //         onTap: (() {
        //     //           Navigator.of(context).pop();
        //     //         }),
        //     //         child: Icon(
        //     //           Icons.chevron_left_rounded,
        //     //           size: 28.0,
        //     //           color: Colors.white,
        //     //         ),
        //     //       ),
        //     //     ),
        //     //   ],
        //     // ),
        //     // SizedBox(
        //     //   height: 120.0,
        //     // ),
        //   ],
        // ),
      ),
    );
  }
}
