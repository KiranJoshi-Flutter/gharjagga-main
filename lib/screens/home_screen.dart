import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gharjagga/models/properties_model.dart';
// import 'package:gharjagga/screens/detail_screen.dart';
import 'package:gharjagga/screens/filter_screen.dart';
import 'package:gharjagga/screens/new_search_screen.dart';
import 'package:gharjagga/screens/properties_list_screen.dart';
import 'package:gharjagga/screens/search_screen.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:gharjagga/utlis/globals.dart';
import 'package:gharjagga/utlis/userpreferences.dart';
import 'package:gharjagga/views/property_detail_screen.dart';
import 'package:gharjagga/views/property_type_screen.dart';
// import 'package:gharjagga/views/search_screen.dart';
import 'package:gharjagga/widgets/blast_apartment.dart';
import 'package:gharjagga/widgets/new_buildings.dart';
import 'package:http/http.dart' as http;
// import 'package:timeago/timeago.dart' as timeago;
import 'package:recase/recase.dart';
import 'package:intl/intl.dart';
import 'package:iconly/iconly.dart';
import 'package:gharjagga/views/add_new_property_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PropertiesModel>?> propertyList;
  late Future<List<PropertiesModel>?> featuredPropertyList;
  TextEditingController searchText = TextEditingController();

  final oCcy = new NumberFormat("##,###");

  var fullName = '';

  @override
  void initState() {
    super.initState();
    init();
    propertyList = _fetchProperties();
    featuredPropertyList = _fetchFeaturedProperties();
  }

  init() async {
    var cfullName = await UserPreferences.getName();

    setState(() {
      fullName = cfullName!;

      // GlobalVariables.primary = 'after';

      // print(GlobalVariables.primary);
    });
  }

  @override
  void dispose() {
    // gifController.dispose();

    super.dispose();
  }

  Future<List<PropertiesModel>?> _fetchFeaturedProperties() async {
    var request = http.Request('GET',
        Uri.parse('https://gharjhagga.com/wp-json/api/properties/featured'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();

      print('check');

      List<PropertiesModel> properties = propertiesModelFromJson(responseBody);

      setState(() {
        GlobalVariables.currentProperties = properties;
      });
      return properties;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  Future<List<PropertiesModel>?> _fetchProperties() async {
    var request = http.Request('GET',
        Uri.parse('https://gharjhagga.com/wp-json/api/place/properties'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();

      print('check');

      List<PropertiesModel> properties = propertiesModelFromJson(responseBody);

      setState(() {
        GlobalVariables.currentProperties = properties;
      });
      return properties;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: 60.0,
            ),
            Container(
              // height: 100.0,
              width: double.infinity,
              // color: Colors.green,
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // height: 100.0,
                    width: double.infinity,
                    // color: Colors.grey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Hello',
                                style: appTextStyle(
                                  FontWeight.bold,
                                  20.0,
                                  Colors.white,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: fullName,
                                style: appTextStyleWLS(
                                  FontWeight.normal,
                                  16.0,
                                  Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: '',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffEC5A22),
                            ),
                            color: kPrimary,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 0.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddNewPropertyScreen(),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Tooltip(
                                  message: 'Add New Property',
                                  textStyle: appTextStyle(
                                    FontWeight.w400,
                                    12.0,
                                    Colors.white70,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      IconlyLight.plus,
                                      size: 24.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //   right: 12,
                                //   top: 12,
                                //   child: Center(
                                //     child: Icon(
                                //       IconlyBold.plus,
                                //       size: 16.0,
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0.0,
                  ),
                  Container(
                    // height: 100.0,
                    width: double.infinity,
                    // color: Colors.purple,
                    child: Text(
                      'Let\'s find the best Real Estate with us!',
                      style: appTextStyle(
                        FontWeight.normal,
                        12.0,
                        Colors.white70,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: searchText,
                          style: appTextStyle(
                            FontWeight.normal,
                            14,
                            kTextColor,
                          ),
                          cursorColor: kThemeColor,
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                              vertical: 18.0,
                              horizontal: 4.0,
                            ),
                            prefixIcon: IconButton(
                              splashRadius: 20.0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchScreen(
                                      searchText: searchText.text,
                                    ),
                                  ),
                                );
                              },
                              icon: ImageIcon(
                                AssetImage("assets/icons/Search.png"),
                                color: Colors.grey,
                                size: 16.0,
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,

                            hintText: 'Search Your Property',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            // focusedBorder: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            hintStyle: appTextStyle(
                              FontWeight.normal,
                              14,
                              kTextHintColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewSearchScreen(
                                  propertiesList:
                                      GlobalVariables.currentProperties,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      InkWell(
                        onTap: (() {
                          FocusScope.of(context).requestFocus(new FocusNode());

                          // Navigator.pop(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => FilterScreen(),
                          //   ),
                          // );
                        }),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 0.0,
                          ),
                          child: Icon(
                            IconlyLight.search,
                            size: 24.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Expanded(
                      //   flex: 2,
                      //   child: Container(
                      //     height: 60.0,
                      //     width: 60,
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      // FocusScope.of(context)
                      //     .requestFocus(new FocusNode());

                      // // Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => FilterScreen(),
                      //   ),
                      // );
                      //       },
                      //       style: ButtonStyle(
                      //         backgroundColor:
                      //             MaterialStateProperty.all(Colors.black),
                      //         shape: MaterialStateProperty.all<
                      //             RoundedRectangleBorder>(
                      //           RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(18.0),
                      //           ),
                      //         ),
                      //       ),
                      //       child: ImageIcon(
                      //         AssetImage("assets/icons/Filter2.png"),
                      //         color: Colors.white,
                      //         size: 30,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PropertyTypeScreen(
                                    'House',
                                    '4',
                                    'https://gharjhagga.com/wp-json/api/property/house'),
                              ),
                            );
                          }),
                          child: Container(
                            height: 84.0,
                            // width: 100.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFD03032),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  16.0,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.house),
                                ImageIcon(
                                  AssetImage("assets/icons/mansion.png"),
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'House',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    14.0,
                                    Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PropertyTypeScreen(
                                    'Apartment',
                                    '5',
                                    'https://gharjhagga.com/wp-json/api/property/apartment'),
                              ),
                            );
                          }),
                          child: Container(
                            height: 84.0,
                            // width: 100.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFD03032),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.house),
                                ImageIcon(
                                  AssetImage("assets/icons/Shape.png"),
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Apart',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    14.0,
                                    Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PropertyTypeScreen(
                                    'Office',
                                    '6',
                                    'https://gharjhagga.com/wp-json/api/property/office'),
                              ),
                            );
                          }),
                          child: Container(
                            height: 84.0,
                            // width: 100.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFD03032),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.house),
                                ImageIcon(
                                  AssetImage("assets/icons/apartment.png"),
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Office',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    14.0,
                                    Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PropertyTypeScreen(
                                    'Land',
                                    '162',
                                    'https://gharjhagga.com/wp-json/api/property/land'),
                              ),
                            );
                          }),
                          child: Container(
                            height: 84.0,
                            // width: 100.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFD03032),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.house),
                                ImageIcon(
                                  AssetImage("assets/icons/land.png"),
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Land',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    14.0,
                                    Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                // height: 500.0,
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: 8.0,
                  left: 22.0,
                  right: 22.0,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      width: double.infinity,
                      // color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Latest Property',
                            style: appTextStyle(
                              FontWeight.bold,
                              20.0,
                              kTextColor,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PropertiesListScreen(
                                    'Latest Property',
                                    'https://gharjhagga.com/wp-json/api/properties/list/latest'),
                              ),
                            ),
                            child: Text(
                              'See All',
                              // style: TextStyle(
                              //   color: Colors.red,
                              // ),
                              style: appTextStyle(
                                FontWeight.bold,
                                14.0,
                                kThemeColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 300,
                      child: FutureBuilder(
                        future: propertyList, // async work
                        builder: (BuildContext context,
                            AsyncSnapshot<List<PropertiesModel>?> snapshot) {
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
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var offerLists =
                                            snapshot.data![index].offerType!;
                                        var neighborhoodLists = snapshot
                                            .data![index]
                                            .attributes![4]
                                            .values!;
                                        var streetLists = snapshot.data![index]
                                            .attributes![5].values!;
                                        var cityLists = snapshot.data![index]
                                            .attributes![2].values!;

                                        String offerTypeLabel = '';
                                        String neighborhoodLabel = '';
                                        String streetLabel = '';
                                        String cityLabel = '';

                                        // Offer Type
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

                                        // Neighborhood
                                        if (neighborhoodLists.length != 0) {
                                          if (neighborhoodLists.length == 1) {
                                            neighborhoodLabel =
                                                neighborhoodLists[0].name;
                                          } else if (offerLists.length >= 1) {
                                            neighborhoodLabel =
                                                neighborhoodLists[1].name;
                                          } else {
                                            neighborhoodLabel = '';
                                          }
                                        } else {
                                          neighborhoodLabel = '';
                                        }

                                        // Street
                                        if (streetLists.length != 0) {
                                          if (streetLists.length == 1) {
                                            streetLabel = streetLists[0].name;
                                          } else if (offerLists.length >= 1) {
                                            streetLabel = streetLists[1].name;
                                          } else {
                                            streetLabel = '';
                                          }
                                        } else {
                                          streetLabel = '';
                                        }

                                        // City
                                        if (cityLists.length != 0) {
                                          if (cityLists.length == 1) {
                                            cityLabel = cityLists[0].name;
                                          } else if (offerLists.length >= 1) {
                                            cityLabel = cityLists[1].name;
                                          } else {
                                            cityLabel = '';
                                          }
                                        } else {
                                          cityLabel = '';
                                        }
                                        return Container(
                                          margin: EdgeInsets.only(
                                            right: 16.0,
                                          ),
                                          child: GestureDetector(
                                            onTap: (() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PropertyDetailScreen(
                                                    snapshot.data![index].id
                                                        .toString(),
                                                    snapshot.data![index]
                                                        .offerType![0].name,
                                                    snapshot.data![index],
                                                  ),
                                                ),
                                              );
                                            }),
                                            child: BlastApartment(
                                              propertyId: snapshot
                                                  .data![index].id
                                                  .toString(),
                                              photoLink: snapshot
                                                          .data![index].image !=
                                                      ''
                                                  ? snapshot.data![index].image
                                                  : 'https://gharjhagga.com/wp-content/uploads/2021/11/no-image.png',
                                              apartmentName: snapshot
                                                  .data![index].name
                                                  .toString()
                                                  .titleCase,
                                              // price: '3',
                                              price: snapshot
                                                  .data![index].price![0].price
                                                  .replaceAll('RS', ''),

                                              location:
                                                  snapshot.data![index].address,
                                              offerType: offerTypeLabel,
                                              desc: 'desc',
                                              bedroom: snapshot
                                                          .data![index]
                                                          .attributes![6]
                                                          .values!
                                                          .length ==
                                                      0
                                                  ? '0'
                                                  : '${snapshot.data![index].attributes![6].values![0].value}',
                                              // bathroom: 'check',
                                              bathroom: snapshot
                                                          .data![index]
                                                          .attributes![7]
                                                          .values!
                                                          .length ==
                                                      0
                                                  ? '0'
                                                  : '${snapshot.data![index].attributes![7].values![0].value}',
                                              // propertySize: 'size',
                                              propertySize: snapshot
                                                          .data![index]
                                                          .attributes![8]
                                                          .values!
                                                          .length ==
                                                      0
                                                  ? '0'
                                                  : '${snapshot.data![index].attributes![8].values![0].value}',
                                              // neighborhood: 'neigh',
                                              neighborhood: neighborhoodLabel,
                                              // street: 'street',
                                              street: streetLabel,
                                              // city: 'check',
                                              city: cityLabel,
                                            ),
                                          ),
                                        );
                                      });
                                } else {
                                  return Container(
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      // height: 100.0,
                      width: double.infinity,
                      // color: Colors.brown,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Featured Property',
                              style: appTextStyle(
                                FontWeight.bold,
                                20.0,
                                kTextColor,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PropertiesListScreen(
                                    'Featured Property',
                                    'https://gharjhagga.com/wp-json/api/properties/list/featured'),
                              ),
                            ),
                            child: Text(
                              'See All',
                              style: appTextStyle(
                                FontWeight.bold,
                                14.0,
                                kThemeColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: 300,
                      child: FutureBuilder(
                        future: featuredPropertyList, // async work
                        builder: (BuildContext context,
                            AsyncSnapshot<List<PropertiesModel>?> snapshot) {
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
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var offerLists =
                                            snapshot.data![index].offerType!;
                                        var neighborhoodLists = snapshot
                                            .data![index]
                                            .attributes![4]
                                            .values!;
                                        var streetLists = snapshot.data![index]
                                            .attributes![5].values!;
                                        var cityLists = snapshot.data![index]
                                            .attributes![2].values!;

                                        String offerTypeLabel = '';
                                        String neighborhoodLabel = '';
                                        String streetLabel = '';
                                        String cityLabel = '';

                                        // Offer Type
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

                                        // Neighborhood
                                        if (neighborhoodLists.length != 0) {
                                          if (neighborhoodLists.length == 1) {
                                            neighborhoodLabel =
                                                neighborhoodLists[0].name;
                                          } else if (offerLists.length >= 1) {
                                            neighborhoodLabel =
                                                neighborhoodLists[1].name;
                                          } else {
                                            neighborhoodLabel = '';
                                          }
                                        } else {
                                          neighborhoodLabel = '';
                                        }

                                        // Street
                                        if (streetLists.length != 0) {
                                          if (streetLists.length == 1) {
                                            streetLabel = streetLists[0].name;
                                          } else if (offerLists.length >= 1) {
                                            streetLabel = streetLists[1].name;
                                          } else {
                                            streetLabel = '';
                                          }
                                        } else {
                                          streetLabel = '';
                                        }

                                        // City
                                        if (cityLists.length != 0) {
                                          if (cityLists.length == 1) {
                                            cityLabel = cityLists[0].name;
                                          } else if (offerLists.length >= 1) {
                                            cityLabel = cityLists[1].name;
                                          } else {
                                            cityLabel = '';
                                          }
                                        } else {
                                          cityLabel = '';
                                        }

                                        return Container(
                                          margin: EdgeInsets.only(
                                            right: 16.0,
                                          ),
                                          child: GestureDetector(
                                            onTap: (() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PropertyDetailScreen(
                                                    snapshot.data![index].id
                                                        .toString(),
                                                    snapshot.data![index]
                                                        .offerType![0].name,
                                                    snapshot.data![index],
                                                  ),
                                                ),
                                              );
                                            }),
                                            child: BlastApartment(
                                              propertyId: snapshot
                                                  .data![index].id
                                                  .toString(),
                                              photoLink: snapshot
                                                          .data![index].image !=
                                                      ''
                                                  ? snapshot.data![index].image
                                                  : 'https://gharjhagga.com/wp-content/uploads/2021/11/no-image.png',
                                              apartmentName: snapshot
                                                  .data![index].name
                                                  .toString()
                                                  .titleCase,
                                              // price: '3',
                                              price: snapshot
                                                  .data![index].price![0].price
                                                  .replaceAll('RS', ''),

                                              location:
                                                  snapshot.data![index].address,
                                              offerType: offerTypeLabel,
                                              desc: 'desc',
                                              bedroom: snapshot
                                                          .data![index]
                                                          .attributes![6]
                                                          .values!
                                                          .length ==
                                                      0
                                                  ? '0'
                                                  : '${snapshot.data![index].attributes![6].values![0].value}',
                                              // bathroom: 'check',
                                              bathroom: snapshot
                                                          .data![index]
                                                          .attributes![7]
                                                          .values!
                                                          .length ==
                                                      0
                                                  ? '0'
                                                  : '${snapshot.data![index].attributes![7].values![0].value}',
                                              // propertySize: 'size',
                                              propertySize: snapshot
                                                          .data![index]
                                                          .attributes![8]
                                                          .values!
                                                          .length ==
                                                      0
                                                  ? '0'
                                                  : '${snapshot.data![index].attributes![8].values![0].value}',
                                              // neighborhood: 'neigh',
                                              neighborhood: neighborhoodLabel,
                                              // street: 'street',
                                              street: streetLabel,
                                              // city: 'check',
                                              city: cityLabel,
                                            ),
                                          ),
                                        );
                                      });
                                } else {
                                  return Container(
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    // Column(
                    //   children: [
                    //     FutureBuilder(
                    //         future: propertyList, // async work
                    //         builder:
                    //             (BuildContext context, AsyncSnapshot snapshot) {
                    //           switch (snapshot.connectionState) {
                    //             case ConnectionState.waiting:
                    //               return Container(
                    //                 // color: Colors.white,
                    //                 child: Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.center,
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   children: [
                    //                     Align(
                    //                       alignment: Alignment.center,
                    //                       child: CircularProgressIndicator(
                    //                         backgroundColor: kPrimary,
                    //                         strokeWidth: 2,
                    //                         valueColor:
                    //                             AlwaysStoppedAnimation<Color>(
                    //                           kSecondary,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               );
                    //             default:
                    //               if (snapshot.hasError) {
                    //                 return Container();
                    //               } else {
                    //                 if (snapshot.data != null) {
                    //                   print(
                    //                       "snapshot.data.length = ${snapshot.data.length}");
                    //                   // return Container(
                    //                   //   color: Colors.black38,
                    //                   // );
                    //                   return ListView.builder(
                    //                       physics:
                    //                           NeverScrollableScrollPhysics(),
                    //                       shrinkWrap: true,
                    //                       itemCount: snapshot.data.length,
                    //                       padding: EdgeInsets.all(0),
                    //                       itemBuilder: (BuildContext context,
                    //                           int index) {
                    //                         return Container();
                    //                       });
                    //                 } else {
                    //                   return Container(
                    //                     width: double.infinity,
                    //                     padding: EdgeInsets.symmetric(
                    //                         horizontal: 20.0),
                    //                     child: Column(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.center,
                    //                       children: [
                    //                         Hero(
                    //                           tag: "no_data",
                    //                           child: Material(
                    //                             color: Colors.transparent,
                    //                             child: Image.asset(
                    //                               "assets/images/no_data.png",
                    //                               fit: BoxFit.fitHeight,
                    //                               height: 80,
                    //                             ),
                    //                           ),
                    //                         ),
                    //                         SizedBox(
                    //                           height: 8.0,
                    //                         ),
                    //                         Text(
                    //                           'No property found',
                    //                           style: appTextStyleWLS(
                    //                             FontWeight.w500,
                    //                             12.0,
                    //                             Colors.black54,
                    //                           ),
                    //                           textAlign: TextAlign.center,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   );
                    //                 }
                    //               }
                    //           }
                    //         }),

                    //     // Container(
                    //     //   width: double.infinity,
                    //     //   color: Colors.black12,
                    //     // child: ListView.builder(
                    //     //     physics: BouncingScrollPhysics(),
                    //     //     shrinkWrap: true,
                    //     //     itemCount: 2,
                    //     //     padding: EdgeInsets.all(0),
                    //     //     itemBuilder: (BuildContext context, int index) {
                    //     //       return Container(
                    //     //         color: Colors.black38,
                    //     //         height: 104.0,
                    //     //         child: Card(
                    //     //           shape: RoundedRectangleBorder(
                    //     //             borderRadius: BorderRadius.circular(15.0),
                    //     //           ),
                    //     //           child: Container(),
                    //     //         ),
                    //     //       );
                    //     //     }),
                    //     // ),
                    //   ],
                    // ),
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
