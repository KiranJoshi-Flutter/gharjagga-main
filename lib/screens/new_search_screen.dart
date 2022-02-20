import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharjagga/functions/functions.dart';
import 'package:gharjagga/models/properties_model.dart';
import 'package:gharjagga/screens/search_screen.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:gharjagga/views/property_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:iconly/iconly.dart';

class NewSearchScreen extends StatefulWidget {
  final List<PropertiesModel> propertiesList;
  const NewSearchScreen({
    required this.propertiesList,
  });
  @override
  _NewSearchScreenState createState() => _NewSearchScreenState();
}

class _NewSearchScreenState extends State<NewSearchScreen> {
  _NewSearchScreenState();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var formatter = NumberFormat('##,##,##,###');

  TextEditingController searchController = TextEditingController();

  List<PropertiesModel> searchedList = [];
  List<String> propertiesListName = [];

  void initState() {
    super.initState();

    init();
  }

  init() {
    // print(widget.propertiesList[0].title);

    for (int a = 0; a < widget.propertiesList.length; a++) {
      propertiesListName.add(widget.propertiesList[a].name);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        //iconTheme: IconThemeData(color: Theme.of(context).primaryColor),

        titleSpacing: 0.0,
        backgroundColor: kThemeColor,
        elevation: 0.5,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   colors: [
              //     kGradientPrimary,
              //     kGradientSecondary,
              //     kGradientTertiary,
              //   ],
              // ),

              ),
        ),
        title: TextField(
          controller: searchController,
          cursorColor: Colors.white,
          autofocus: true,
          style: appTextStyle(
            FontWeight.w500,
            16.0,
            Colors.white,
          ),
          // autofillHints: propertiesListName,
          onChanged: (value) {
            print('$value = ${value.length}');

            List<PropertiesModel> tmpList = [];

            if (value.length >= 2) {
              for (int a = 0; a < widget.propertiesList.length; a++) {
                if (widget.propertiesList[a].name
                    .toLowerCase()
                    .contains(value.toLowerCase())) {
                  print(widget.propertiesList[a].name);
                  tmpList.add(widget.propertiesList[a]);
                }
              }
              setState(() {
                searchedList = tmpList;
              });
              print(searchedList);
            } else {
              setState(() {
                searchedList = [];
              });
            }
          },
          decoration: new InputDecoration(
            hintText: 'Search...',
            labelStyle: appTextStyle(
              FontWeight.w500,
              16.0,
              Colors.white,
            ),
            hintStyle: appTextStyle(
              FontWeight.w500,
              16.0,
              Colors.white,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16.0),
            ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: kThemeColor,
            //     width: 0,
            //   ),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: kPrimary,
            //     width: 0.0,
            //   ),
            // ),
          ),
        ),

        actions: [
          IconButton(
            icon: Icon(
              IconlyLight.search,
              size: 24.0,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    searchText: searchController.text,
                  ),
                ),
              );
              // SearchResultScreen
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SearchResultScreen(
              //       propertiesList: searchedList,
              //       query: searchController.text.trim(),
              //     ),
              //   ),
              // );
            },
          ),
        ],
      ),
      body: searchedList.length != 0
          ? Container(
              // color: kGradientPrimary,
              child: ListView.builder(
                // shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: searchedList.length,

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
                          builder: (context) => PropertyDetailScreen(
                            searchedList[index].id.toString(),
                            searchedList[index].offerType![0].name,
                            searchedList[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  searchedList[index].name,
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                                Text(
                                  'Rs. ${searchedList[index].price![0].price.toString().replaceAll('RS', '')} /-',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    14.0,
                                    Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FutureBuilder(
                            future:
                                imageURLCheck("${searchedList[index].image}"),
                            builder: (context, asyncSnapshot) {
                              if (asyncSnapshot.hasData) {
                                if (asyncSnapshot.data != null) {
                                  return Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          16,
                                        ),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          '${searchedList[index].image}',
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    child: Container(
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: AssetImage(
                                          "assets/images/no_image.png",
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                return Container(
                                  height: 60,
                                  width: 60,
                                  child: Center(
                                    child: CupertinoActivityIndicator(
                                      radius: 5,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(
              child: Text(
                'Search Property',
              ),
            ),
    );
  }
}
