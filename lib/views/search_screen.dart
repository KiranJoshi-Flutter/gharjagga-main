import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gharjagga/screens/detail_screen.dart';
import 'package:gharjagga/utlis/constant.dart';
// import 'package:gharjagga/views/search_no_result.dart';
import 'package:gharjagga/widgets/blast_apartment.dart';
// import 'package:gharjagga/widgets/new_buildings.dart';
import 'package:http/http.dart' as http;
import 'package:recase/recase.dart';

void main() {
  runApp(SearchScreen());
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int flag = 0;

  String searchItem = "";

  final searchItemController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-2.png"),
          fit: BoxFit.cover,
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(height: 60.0),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: 60.0, left: 26, bottom: 30, right: 20.0),
                  width: 50.0,
                  height: 50.0,
                  //color: Colors.green,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Color(0xffEC5A22),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image(
                      image: AssetImage(
                          "assets/icons/search_screen/Arrow - Left 2.png"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.0, right: 26.0),
                    child: Container(
                      height: 50.0,
                      child: TextFormField(
                        style: appTextStyle(
                          FontWeight.normal,
                          16,
                          kTextColor,
                        ),
                        onChanged: (value) {
                          print("---->> " + value);

                          if (value.length != 0) {
                            print("---->> The lenght of value= 0");
                            setState(() {
                              flag = 1;
                            });
                          }
                          if (value.length == 0) {
                            setState(() {
                              flag = 0;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 20.0,
                          ),
                          suffixIcon: Container(
                            margin: EdgeInsets.only(right: 20.0),
                            //color: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  searchItem = searchItemController.text;
                                });
                                /*Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) { return SearchNoResult(); }
                                ));*/
                              },
                              child: ImageIcon(
                                AssetImage(
                                    "assets/icons/search_screen/Search.png"),
                                //color: Colors.grey,
                                size: 8.0,
                              ),
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Yogyakarta',

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
                            16,
                            kTextHintColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        controller: searchItemController,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: 411.4,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),
                  color: Colors.white,
                ),
                child: Container(
                  //color: Colors.yellow,
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 77.0,
                            height: 26.0,
                            //color: Colors.grey,
                            child: Text(
                              "3 Result",
                              style: appTextStyle(
                                  FontWeight.bold, 20.0, kTextColor),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Container(
                            width: 98.0,
                            height: 38.0,
                            //color: Colors.black,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff1B1839),
                                  Color(0xff383A4A),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 18.0,
                                    height: 18.0,
                                    //color: Colors.red,

                                    child: Image(
                                      image: AssetImage(
                                          "assets/icons/search_screen/Filter 2.png"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  Text("Filter",
                                      style: appTextStyle(
                                          FontWeight.w500, 14.0, Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 20.0),

                          width: double.infinity,
                          // height: double.infinity,
                          //Color: Colors.grey,

                          child: ListView(
                            padding: EdgeInsets.only(top: 0.0),
                            physics: BouncingScrollPhysics(),
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 0.0,
                                ),
                                //--------------------------------->> inner place holder for the vertical listView.builder
                                child: FutureBuilder(
                                  future: propertyList, // async work
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                            //mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: kPrimary,
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
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
                                          print(
                                              "//------------------------------>> I am inside else block .");
                                          if (snapshot.data != null) {
                                            print(
                                                "---------------->> Snapshot is not NULL");
                                            print(
                                                "snapshot.data.length = ${snapshot.data.length}");
                                            // return Container(
                                            //   color: Colors.black38,
                                            // );

                                            return ListView.builder(
                                                padding:
                                                    EdgeInsets.only(top: 0.0),
                                                // key: Key('builder ${selected.toString()}'),
                                                physics:
                                                    BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    snapshot.data.length >= 5
                                                        ? 5
                                                        : snapshot.data.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  print("----->>");
                                                  print(snapshot.data[index]
                                                      ['title']['rendered']);

                                                  if (flag == 0) {
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                        top: 0.0,
                                                        right: 10.0,
                                                        bottom: 20.0,
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: (() {
                                                          //print("----->> Clicked on Pic");
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailScreen(),
                                                            ),
                                                          );
                                                        }),
                                                        child: BlastApartment(
                                                            photoLink: snapshot
                                                                    .data[index]
                                                                        ['_embedded']
                                                                        [
                                                                        'wp:featuredmedia']
                                                                    .first[
                                                                'source_url'],
                                                            apartmentName: snapshot
                                                                .data[index]
                                                                    ['title']
                                                                    ['rendered']
                                                                .toString()
                                                                .titleCase,
                                                            price: "246",
                                                            location:
                                                                'Purwokerto, Indonesia',
                                                            desc: snapshot
                                                                .data[index]
                                                                    ['content']
                                                                    ['rendered']
                                                                .toString()),
                                                      ),
                                                    );
                                                  } else if (snapshot
                                                                  .data[index]
                                                              ['title']
                                                          ['rendered'] ==
                                                      searchItem) {
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                        top: 0.0,
                                                        right: 10.0,
                                                        bottom: 20.0,
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: (() {
                                                          //print("----->> Clicked on Pic");
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailScreen(),
                                                            ),
                                                          );
                                                        }),
                                                        child: BlastApartment(
                                                            photoLink: snapshot
                                                                    .data[index]
                                                                        ['_embedded']
                                                                        [
                                                                        'wp:featuredmedia']
                                                                    .first[
                                                                'source_url'],
                                                            apartmentName: snapshot
                                                                .data[index]
                                                                    ['title']
                                                                    ['rendered']
                                                                .toString()
                                                                .titleCase,
                                                            price: '246',
                                                            location:
                                                                'Purwokerto, Indonesia',
                                                            desc: snapshot
                                                                .data[index]
                                                                    ['content']
                                                                    ['rendered']
                                                                .toString()),
                                                      ),
                                                    );
                                                  }

                                                  return Container();
                                                });
                                          } else {
                                            print(
                                                "------------------>> snapshot value of search_screen= " +
                                                    snapshot.data.toString());
                                            return Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Hero(
                                                    tag: "no_data",
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: Image.asset(
                                                        "assets/images/no_image.png",
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
                                    // return Container();
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  late Future propertyList;

  @override
  void initState() {
    super.initState();
    propertyList = _fetchProperties();
  }

  Future _fetchProperties() async {
    final request = await http.get(
      Uri.parse(
        "https://gharjhagga.com/wp-json/wp/v2/estate?_embed&orderby=date",
      ),
    );

    var res = json.decode(request.body);

    print(res);

    print(
        "request.headers['x-wp-totalpages'] ${request.headers['x-wp-totalpages']}");

    if (res.length != 0) {
      return res;
    } else {
      return null;
    }
  }
}
