import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gharjagga/models/properties_model.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:gharjagga/utlis/globals.dart';
import 'package:gharjagga/views/property_detail_screen.dart';
import 'package:gharjagga/widgets/blast_apartment.dart';
import 'package:gharjagga/widgets/searched_result.dart';
import 'package:iconly/iconly.dart';
import 'package:http/http.dart' as http;
import 'package:animation_wrappers/animation_wrappers.dart';

class SearchScreen extends StatefulWidget {
  final String searchText;

  SearchScreen({Key? key, required this.searchText}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int searchedResultLength = 0;
  String searchValue = '';

  List<PropertiesModel> searchedProperties = [];

  Future<List<PropertiesModel>> fetchSearchedResult(String land) async {
    final response = await http.get(Uri.parse(
        'https://gharjhagga.com/wp-json/wp/v2/search?_embed&per_page=100&search=$land&subtype=estate'));

    if (response.statusCode == 200) {
      var propertyJSON = jsonDecode(response.body);

      print(propertyJSON.length);

      List<PropertiesModel> tmpList = [];

      for (int a = 0; a < propertyJSON.length; a++) {
        // print(' ${propertyJSON.id}');
        for (int b = 0; b < GlobalVariables.currentProperties.length; b++) {
          if (propertyJSON[a]['id'] ==
              GlobalVariables.currentProperties[b].id) {
            tmpList.add(GlobalVariables.currentProperties[b]);
          }
        }
      }

      setState(() {
        searchedProperties = tmpList;
        searchedResultLength = searchedProperties.length;

        print('searchedResultLength = $searchedResultLength');
      });

      return searchedProperties;
    } else {
      setState(() {
        searchedResultLength = 0;
      });
      throw Exception('Failed to load searched result');
    }
  }

  late Future<List<PropertiesModel>> futureSearchedResult;
  TextEditingController searchLand = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('from init');
    searchValue = widget.searchText;
    futureSearchedResult = fetchSearchedResult(
        'https://gharjhagga.com/wp-json/wp/v2/search?_embed&per_page=100&search=${widget.searchText}&subtype=estate');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/icons/search_screen/bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                // height: 140.0,
                // color: Colors.grey,
                padding: EdgeInsets.only(
                  top: 60.0,
                  bottom: 30.0,
                ),
                alignment: Alignment.center,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  // color: Colors.yellow,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16.0,
                      ),
                      InkWell(
                        onTap: (() {
                          Navigator.of(context).pop();
                        }),
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

                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8.0,
                          ),
                          // color: Colors.white,
                          child: Icon(
                            Icons.chevron_left_rounded,
                            size: 28.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: searchLand..text = '$searchValue',
                          // initialValue: 'hello',
                          // controller: searchLand,
                          style: appTextStyle(
                            FontWeight.normal,
                            14,
                            kTextColor,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 20.0,
                              top: 18.0,
                            ),

                            suffixIcon: IconButton(
                              splashRadius: 20.0,
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                // fetchSearchedResult('${searchLand.text}');
                                setState(() {
                                  searchValue = searchLand.text;
                                  futureSearchedResult =
                                      fetchSearchedResult('${searchLand.text}');
                                });
                              },
                              icon: ImageIcon(
                                AssetImage("assets/icons/Search.png"),
                                // color: Colors.grey,
                                size: 20.0,
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
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            // fetchSearchedResult('${searchLand.text}');
                            setState(() {
                              searchValue = searchLand.text;
                              futureSearchedResult =
                                  fetchSearchedResult('${searchLand.text}');
                            });
                          },
                          // on,
                        ),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.only(
                  left: 26.0,
                  right: 26.0,
                  top: 30.0,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 38.0,
                      width: double.infinity,
                      // color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$searchedResultLength Result',
                            style: appTextStyle(
                              FontWeight.bold,
                              18.0,
                              kTextColor,
                            ),
                          ),
                          // Container(
                          //   height: 38,
                          //   width: 98,
                          //   decoration: BoxDecoration(
                          //     border: Border.all(
                          //       color: Colors.black,
                          //     ),
                          //     color: Colors.black,
                          //     borderRadius: BorderRadius.all(
                          //       Radius.circular(12),
                          //     ),
                          //   ),
                          //   child: Center(
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Icon(
                          //           IconlyBold.filter_2,
                          //           size: 24.0,
                          //           color: Colors.white,
                          //         ),
                          //         SizedBox(
                          //           width: 8.0,
                          //         ),
                          //         Text(
                          //           'Filter',
                          //           style: appTextStyle(
                          //             FontWeight.normal,
                          //             14.0,
                          //             kBottomNavigarionBarIconColor,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: futureSearchedResult, // async work
                        builder: (BuildContext context,
                            AsyncSnapshot<List<PropertiesModel>> snapshot) {
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
                                if (snapshot.data!.length != 0) {
                                  return FadedSlideAnimation(
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      // itemCount: snapshot.data.length,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        // print(
                                        //     'from ListView.builder: ${snapshot.data.length}');

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

                                        String address = '';

                                        if (neighborhoodLabel.isNotEmpty) {
                                          address = address +
                                              neighborhoodLabel +
                                              ', ';
                                        }
                                        if (cityLabel.isNotEmpty) {
                                          address = address + cityLabel;
                                        }
                                        if (streetLabel.isNotEmpty) {
                                          address = address + ' ($streetLabel)';
                                        }

                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PropertyDetailScreen(
                                                  snapshot.data![index].id
                                                      .toString(),
                                                  offerTypeLabel,
                                                  snapshot.data![index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: SearchedResult(
                                            photoLink: snapshot
                                                        .data![index].image !=
                                                    ''
                                                ? snapshot.data![index].image
                                                : 'https://gharjhagga.com/wp-content/uploads/2021/11/no-image.png',
                                            apartmentName:
                                                '${snapshot.data![index].name}',
                                            // price: '3,500,000',
                                            price:
                                                '${snapshot.data![index].price!.first.price.toString().replaceAll('RS', '')}',
                                            // location: '${snapshot.data[index]['id']}',
                                            location: address.endsWith(', ')
                                                ? address.substring(
                                                    0, address.length - 1)
                                                : address,
                                            offerType: offerTypeLabel,
                                            neighborhood: neighborhoodLabel,
                                            street: streetLabel,
                                            city: cityLabel,
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

                      // FutureBuilder(
                      //   future: futureSearchedResult,
                      //   builder:
                      //       (BuildContext context, AsyncSnapshot snapshot) {
                      //     if (snapshot.data != null) {
                      //       return
                      //                                 } else if (snapshot.hasError) {
                      //       return Center(
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Image.asset(
                      //                 'assets/icons/search_screen/Group 436.png'),
                      //             Text('No data'),
                      //           ],
                      //         ),
                      //       );
                      //     }
                      //     return Center(
                      //       child: CircularProgressIndicator(),
                      //     );
                      //   },
                      // ),
                    )
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
