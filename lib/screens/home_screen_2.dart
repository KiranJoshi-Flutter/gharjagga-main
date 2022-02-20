// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// // import 'package:gharjagga/screens/detail_screen.dart';
// import 'package:gharjagga/screens/filter_screen.dart';
// import 'package:gharjagga/screens/search_screen.dart';
// import 'package:gharjagga/utlis/constant.dart';
// import 'package:gharjagga/utlis/userpreferences.dart';
// import 'package:gharjagga/views/property_detail_screen.dart';
// import 'package:gharjagga/views/property_type_screen.dart';
// // import 'package:gharjagga/views/search_screen.dart';
// import 'package:gharjagga/widgets/blast_apartment.dart';
// import 'package:gharjagga/widgets/new_buildings.dart';
// import 'package:http/http.dart' as http;
// // import 'package:timeago/timeago.dart' as timeago;
// import 'package:recase/recase.dart';
// import 'package:intl/intl.dart';
// import 'package:iconly/iconly.dart';
// import 'package:gharjagga/views/add_new_property_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late Future propertyList;
//   late Future featuredPropertyList;
//   TextEditingController searchText = TextEditingController();

//   final oCcy = new NumberFormat("##,###");

//   var fullName = '';

//   @override
//   void initState() {
//     super.initState();
//     init();
//     propertyList = _fetchProperties();
//     featuredPropertyList = _fetchFeaturedProperties();
//   }

//   init() async {
//     var cfullName = await UserPreferences.getName();

//     setState(() {
//       fullName = cfullName!;
//     });
//   }

//   @override
//   void dispose() {
//     // gifController.dispose();

//     super.dispose();
//   }

//   Future _fetchProperties() async {
//     final request = await http.get(
//       Uri.parse(
//         "https://gharjhagga.com/wp-json/wp/v2/estate?_embed&orderby=date",
//       ),
//     );

//     // print(request.body);

//     var res = json.decode(request.body);

//     // print(res);

//     // print(
//     //     "request.headers['x-wp-totalpages'] ${request.headers['x-wp-totalpages']}");

//     if (res.length != 0) {
//       return res;
//     } else {
//       return null;
//     }
//   }

//   Future _fetchFeaturedProperties() async {
//     final request = await http.get(
//       Uri.parse(
//         "https://gharjhagga.com/wp-json/wp/v2/estate?_embed&orderby=date",
//       ),
//     );

//     // print(request.body);

//     var res = json.decode(request.body);

//     // print(res);

//     // print(
//     //     "request.headers['x-wp-totalpages'] ${request.headers['x-wp-totalpages']}");

//     if (res.length != 0) {
//       return res;
//     } else {
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/images/bg.png'),
//           fit: BoxFit.fill,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Column(
//           children: [
//             SizedBox(
//               height: 60.0,
//             ),
//             Container(
//               // height: 100.0,
//               width: double.infinity,
//               // color: Colors.green,
//               padding: EdgeInsets.only(
//                 left: 24.0,
//                 right: 24.0,
//                 bottom: 16.0,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     // height: 100.0,
//                     width: double.infinity,
//                     // color: Colors.grey,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             RichText(
//                               text: TextSpan(
//                                 text: 'Hello',
//                                 style: appTextStyle(
//                                   FontWeight.bold,
//                                   20.0,
//                                   Colors.white,
//                                 ),
//                               ),
//                             ),
//                             RichText(
//                               text: TextSpan(
//                                 text: fullName,
//                                 style: appTextStyleWLS(
//                                   FontWeight.normal,
//                                   16.0,
//                                   Colors.white,
//                                 ),
//                                 children: [
//                                   TextSpan(
//                                     text: '',
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           height: 55,
//                           width: 55,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Color(0xffEC5A22),
//                             ),
//                             color: kPrimary,
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(16),
//                             ),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 0,
//                             vertical: 0.0,
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => AddNewPropertyScreen(),
//                                 ),
//                               );
//                             },
//                             child: Stack(
//                               children: [
//                                 Tooltip(
//                                   message: 'Add New Property',
//                                   textStyle: appTextStyle(
//                                     FontWeight.w400,
//                                     12.0,
//                                     Colors.white70,
//                                   ),
//                                   child: Center(
//                                     child: Icon(
//                                       IconlyLight.plus,
//                                       size: 24.0,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 // Positioned(
//                                 //   right: 12,
//                                 //   top: 12,
//                                 //   child: Center(
//                                 //     child: Icon(
//                                 //       IconlyBold.plus,
//                                 //       size: 16.0,
//                                 //       color: Colors.white,
//                                 //     ),
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 0.0,
//                   ),
//                   Container(
//                     // height: 100.0,
//                     width: double.infinity,
//                     // color: Colors.purple,
//                     child: Text(
//                       'Let\'s find the best Real Estate with us!',
//                       style: appTextStyle(
//                         FontWeight.normal,
//                         12.0,
//                         Colors.white70,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 8,
//                         child: TextFormField(
//                           controller: searchText,
//                           style: appTextStyle(
//                             FontWeight.normal,
//                             14,
//                             kTextColor,
//                           ),
//                           decoration: InputDecoration(
//                             contentPadding: new EdgeInsets.symmetric(
//                               vertical: 18.0,
//                               horizontal: 4.0,
//                             ),
//                             prefixIcon: IconButton(
//                               splashRadius: 20.0,
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => SearchScreen(
//                                       searchText: searchText.text,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               icon: ImageIcon(
//                                 AssetImage("assets/icons/Search.png"),
//                                 color: Colors.grey,
//                                 size: 16.0,
//                               ),
//                             ),
//                             fillColor: Colors.white,
//                             filled: true,
//                             hintText: 'Search Your Property',
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               borderRadius: BorderRadius.circular(16.0),
//                             ),
//                             // focusedBorder: InputBorder.none,
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               borderRadius: BorderRadius.circular(16.0),
//                             ),
//                             hintStyle: appTextStyle(
//                               FontWeight.normal,
//                               14,
//                               kTextHintColor,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               borderRadius: BorderRadius.circular(16.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 16.0,
//                       ),
//                       InkWell(
//                         onTap: (() {
//                           FocusScope.of(context).requestFocus(new FocusNode());

//                           // Navigator.pop(context);
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder: (context) => FilterScreen(),
//                           //   ),
//                           // );
//                         }),
//                         child: Container(
//                           height: 60,
//                           width: 60,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.black,
//                             ),
//                             color: Colors.black,
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(16),
//                             ),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 0,
//                             vertical: 0.0,
//                           ),
//                           child: Icon(
//                             IconlyBold.filter_2,
//                             size: 24.0,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       // Expanded(
//                       //   flex: 2,
//                       //   child: Container(
//                       //     height: 60.0,
//                       //     width: 60,
//                       //     child: ElevatedButton(
//                       //       onPressed: () {
//                       // FocusScope.of(context)
//                       //     .requestFocus(new FocusNode());

//                       // // Navigator.pop(context);
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => FilterScreen(),
//                       //   ),
//                       // );
//                       //       },
//                       //       style: ButtonStyle(
//                       //         backgroundColor:
//                       //             MaterialStateProperty.all(Colors.black),
//                       //         shape: MaterialStateProperty.all<
//                       //             RoundedRectangleBorder>(
//                       //           RoundedRectangleBorder(
//                       //             borderRadius: BorderRadius.circular(18.0),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //       child: ImageIcon(
//                       //         AssetImage("assets/icons/Filter2.png"),
//                       //         color: Colors.white,
//                       //         size: 30,
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: (() {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PropertyTypeScreen(
//                                   'House',
//                                   '4',
//                                 ),
//                               ),
//                             );
//                           }),
//                           child: Container(
//                             height: 84.0,
//                             // width: 100.0,
//                             decoration: BoxDecoration(
//                               color: Color(0xFFD03032),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(
//                                   16.0,
//                                 ),
//                               ),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // Icon(Icons.house),
//                                 ImageIcon(
//                                   AssetImage("assets/icons/mansion.png"),
//                                   color: Colors.white,
//                                   size: 24,
//                                 ),
//                                 SizedBox(
//                                   height: 10.0,
//                                 ),
//                                 Text(
//                                   'House',
//                                   style: appTextStyle(
//                                     FontWeight.w500,
//                                     14.0,
//                                     Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 8.0,
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: (() {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PropertyTypeScreen(
//                                   'Apartment',
//                                   '5',
//                                 ),
//                               ),
//                             );
//                           }),
//                           child: Container(
//                             height: 84.0,
//                             // width: 100.0,
//                             decoration: BoxDecoration(
//                               color: Color(0xFFD03032),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(16.0)),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // Icon(Icons.house),
//                                 ImageIcon(
//                                   AssetImage("assets/icons/Shape.png"),
//                                   color: Colors.white,
//                                   size: 24,
//                                 ),
//                                 SizedBox(
//                                   height: 10.0,
//                                 ),
//                                 Text(
//                                   'Apart',
//                                   style: appTextStyle(
//                                     FontWeight.w500,
//                                     14.0,
//                                     Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 8.0,
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: (() {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PropertyTypeScreen(
//                                   'Office',
//                                   '6',
//                                 ),
//                               ),
//                             );
//                           }),
//                           child: Container(
//                             height: 84.0,
//                             // width: 100.0,
//                             decoration: BoxDecoration(
//                               color: Color(0xFFD03032),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(16.0)),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // Icon(Icons.house),
//                                 ImageIcon(
//                                   AssetImage("assets/icons/apartment.png"),
//                                   color: Colors.white,
//                                   size: 24,
//                                 ),
//                                 SizedBox(
//                                   height: 10.0,
//                                 ),
//                                 Text(
//                                   'Office',
//                                   style: appTextStyle(
//                                     FontWeight.w500,
//                                     14.0,
//                                     Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 8.0,
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: (() {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PropertyTypeScreen(
//                                   'Land',
//                                   '162',
//                                 ),
//                               ),
//                             );
//                           }),
//                           child: Container(
//                             height: 84.0,
//                             // width: 100.0,
//                             decoration: BoxDecoration(
//                               color: Color(0xFFD03032),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(16.0)),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // Icon(Icons.house),
//                                 ImageIcon(
//                                   AssetImage("assets/icons/land.png"),
//                                   color: Colors.white,
//                                   size: 24,
//                                 ),
//                                 SizedBox(
//                                   height: 10.0,
//                                 ),
//                                 Text(
//                                   'Land',
//                                   style: appTextStyle(
//                                     FontWeight.w500,
//                                     14.0,
//                                     Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 // height: 500.0,
//                 width: double.infinity,
//                 padding: EdgeInsets.only(
//                   top: 8.0,
//                   left: 22.0,
//                   right: 22.0,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).scaffoldBackgroundColor,
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(30.0),
//                     topLeft: Radius.circular(30.0),
//                   ),
//                 ),
//                 child: ListView(
//                   physics: BouncingScrollPhysics(),
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       // color: Colors.green,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Latest Property',
//                             style: appTextStyle(
//                               FontWeight.bold,
//                               20.0,
//                               kTextColor,
//                             ),
//                           ),
//                           Text(
//                             'See All',
//                             // style: TextStyle(
//                             //   color: Colors.red,
//                             // ),
//                             style: appTextStyle(
//                               FontWeight.normal,
//                               14.0,
//                               kThemeColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                     Container(
//                       height: 300,
//                       child: FutureBuilder(
//                         future: propertyList, // async work
//                         builder:
//                             (BuildContext context, AsyncSnapshot snapshot) {
//                           switch (snapshot.connectionState) {
//                             case ConnectionState.waiting:
//                               return Container(
//                                 // color: Colors.white,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Align(
//                                       alignment: Alignment.center,
//                                       child: CircularProgressIndicator(
//                                         backgroundColor: kPrimary,
//                                         strokeWidth: 2,
//                                         valueColor:
//                                             AlwaysStoppedAnimation<Color>(
//                                           kSecondary,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             default:
//                               if (snapshot.hasError) {
//                                 return Container();
//                               } else {
//                                 if (snapshot.data != null) {
//                                   print(
//                                       "snapshot.data.length = ${snapshot.data.length}");
//                                   // return Container(
//                                   //   color: Colors.black38,
//                                   // );
//                                   return ListView.builder(
//                                       // key: Key('builder ${selected.toString()}'),
//                                       physics: BouncingScrollPhysics(),
//                                       shrinkWrap: true,
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: snapshot.data.length >= 5
//                                           ? 5
//                                           : snapshot.data.length,
//                                       itemBuilder:
//                                           (BuildContext context, int index) {
//                                         // CITY
//                                         // print(snapshot.data[index]['_embedded']
//                                         //     ['wp:term'][2][0]['name']);

//                                         // // neighborhood
//                                         // if (snapshot.data[index]['neighborhood']
//                                         //         .length !=
//                                         //     0) {
//                                         //   print(snapshot.data[index]
//                                         //           ['_embedded']['wp:term'][4][0]
//                                         //       ['name']);
//                                         // }
//                                         // // sTREET
//                                         // if (snapshot
//                                         //         .data[index]['street'].length !=
//                                         //     0) {
//                                         //   print(snapshot.data[index]
//                                         //           ['_embedded']['wp:term'][5][0]
//                                         //       ['name']);
//                                         // }
//                                         // neighborhood
//                                         // print(snapshot.data[index]['_embedded']
//                                         //     ['wp:term'][4]);
//                                         // print(snapshot.data[index]['_embedded']
//                                         //     ['wp:term'][3]);
//                                         // print(snapshot.data[index]
//                                         //     ['estate_attr_bedrooms']['_embedded']);
//                                         // if (snapshot.data[index]
//                                         //         ['estate_attr_bedrooms']
//                                         //     .toString()
//                                         //     .isNotEmpty) {
//                                         //   print(
//                                         //       "snapshot.data.estate_attr_bedrooms $index = ${snapshot.data[index]['estate_attr_bedrooms']}");
//                                         // }
//                                         // if (snapshot.data[index]
//                                         //         ['estate_attr_bathrooms']
//                                         //     .toString()
//                                         //     .isNotEmpty) {
//                                         //   print(
//                                         //       "snapshot.data.estate_attr_bathrooms $index = ${snapshot.data[index]['estate_attr_bathrooms']}");
//                                         // }
//                                         // if (snapshot.data[index]
//                                         //         ['estate_attr_property']
//                                         //     .toString()
//                                         //     .isNotEmpty) {
//                                         //   print(
//                                         //       "snapshot.data.estate_attr_property $index = ${snapshot.data[index]['estate_attr_property']}");
//                                         // }
//                                         return Container(
//                                           margin: EdgeInsets.only(
//                                             right: 16.0,
//                                           ),
//                                           child: GestureDetector(
//                                             onTap: (() {
//                                               // Navigator.push(
//                                               //   context,
//                                               //   MaterialPageRoute(
//                                               //     builder: (context) =>
//                                               //         PropertyDetailScreen(
//                                               //       snapshot.data[index]['id']
//                                               //           .toString(),
//                                               //       snapshot
//                                               //           .data[index]
//                                               //               ['_embedded']
//                                               //               ['wp:term'][1]
//                                               //           .last['name'],
//                                               //     ),
//                                               //   ),
//                                               // );
//                                             }),
//                                             child: BlastApartment(
//                                               propertyId: snapshot.data[index]
//                                                       ['id']
//                                                   .toString(),
//                                               photoLink: snapshot.data[index]
//                                                           ['featured_media'] !=
//                                                       0
//                                                   ? snapshot.data[index]
//                                                               ['_embedded']
//                                                           ['wp:featuredmedia']
//                                                       [0]['source_url']
//                                                   : 'https://gharjhagga.com/wp-content/uploads/2021/11/no-image.png',
//                                               apartmentName: snapshot
//                                                   .data[index]['title']
//                                                       ['rendered']
//                                                   .toString()
//                                                   .titleCase,
//                                               price: snapshot
//                                                       .data[index]
//                                                           ['estate_attr_price']
//                                                       .isNotEmpty
//                                                   ? oCcy.format(int.tryParse(
//                                                       snapshot.data[index][
//                                                           'estate_attr_price']))
//                                                   : '-',
//                                               location: 'Purwokerto, Indonesia',
//                                               offerType: snapshot
//                                                   .data[index]['_embedded']
//                                                       ['wp:term'][1]
//                                                   .last['name'],
//                                               desc: snapshot.data[index]
//                                                       ['content']['rendered']
//                                                   .toString(),
//                                               bedroom: snapshot.data[index][
//                                                           'estate_attr_bedrooms']
//                                                       .toString()
//                                                       .isNotEmpty
//                                                   ? snapshot.data[index][
//                                                                   'estate_attr_bedrooms']
//                                                               .toString() !=
//                                                           'null'
//                                                       ? snapshot.data[index][
//                                                               'estate_attr_bedrooms']
//                                                           .toString()
//                                                       : '0'
//                                                   : '0',
//                                               bathroom: snapshot.data[index][
//                                                           'estate_attr_bathrooms']
//                                                       .toString()
//                                                       .isNotEmpty
//                                                   ? snapshot.data[index][
//                                                                   'estate_attr_bathrooms']
//                                                               .toString() !=
//                                                           'null'
//                                                       ? snapshot.data[index][
//                                                               'estate_attr_bathrooms']
//                                                           .toString()
//                                                       : '0'
//                                                   : '0',
//                                               propertySize: snapshot.data[index]
//                                                           [
//                                                           'estate_attr_property-size']
//                                                       .toString()
//                                                       .isNotEmpty
//                                                   ? snapshot.data[index][
//                                                                   'estate_attr_property-size']
//                                                               .toString() !=
//                                                           'null'
//                                                       ? snapshot.data[index][
//                                                               'estate_attr_property-size']
//                                                           .toString()
//                                                       : '0'
//                                                   : '0',
//                                               neighborhood: snapshot
//                                                           .data[index]
//                                                               ['neighborhood']
//                                                           .length !=
//                                                       0
//                                                   ? snapshot
//                                                       .data[index]['_embedded']
//                                                           ['wp:term'][4]
//                                                       .last['name']
//                                                   : '',
//                                               street: snapshot
//                                                           .data[index]['street']
//                                                           .length !=
//                                                       0
//                                                   ? snapshot
//                                                       .data[index]['_embedded']
//                                                           ['wp:term'][5]
//                                                       .last['name']
//                                                   : '',
//                                               city: snapshot.data[index]['city']
//                                                           .length !=
//                                                       0
//                                                   ? snapshot
//                                                       .data[index]['_embedded']
//                                                           ['wp:term'][2]
//                                                       .last['name']
//                                                   : '',
//                                             ),
//                                           ),
//                                         );
//                                       });
//                                 } else {
//                                   return Container(
//                                     width: double.infinity,
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 20.0),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Hero(
//                                           tag: "no_data",
//                                           child: Material(
//                                             color: Colors.transparent,
//                                             child: Image.asset(
//                                               "assets/images/no_data.png",
//                                               fit: BoxFit.fitHeight,
//                                               height: 80,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 8.0,
//                                         ),
//                                         Text(
//                                           'No news found',
//                                           style: appTextStyleWLS(
//                                             FontWeight.w500,
//                                             12.0,
//                                             Colors.black54,
//                                           ),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }
//                               }
//                           }
//                         },
//                       ),

//                       // ListView(
//                       //   scrollDirection: Axis.horizontal,
//                       //   physics: BouncingScrollPhysics(),
//                       //   shrinkWrap: true,
//                       //   children: [
//                       //     GestureDetector(
//                       //       onTap: (() {
//                       //         Navigator.push(
//                       //           context,
//                       //           MaterialPageRoute(
//                       //             builder: (context) => DetailScreen(),
//                       //           ),
//                       //         );
//                       //       }),
//                       //       child: BlastApartment(
//                       //         photoLink:
//                       //             'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/2e/25/da/old-town-by-welcome-apartment.jpg?w=900&h=-1&s=1',
//                       //         apartmentName: 'Blast Apartment',
//                       //         price: 246,
//                       //         location: 'Purwokerto, Indonesia',
//                       //       ),
//                       //     ),
//                       //     SizedBox(
//                       //       width: 10.0,
//                       //     ),
//                       //     BlastApartment(
//                       //       photoLink:
//                       //           'https://cdn.home-designing.com/wp-content/uploads/2014/08/colorful-apartment.jpg',
//                       //       apartmentName: 'Classic Apartment',
//                       //       price: 132,
//                       //       location: 'Banduwa, Indonesia',
//                       //     ),
//                       //   ],
//                       // ),
//                     ),
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    // Container(
                    //   // height: 100.0,
                    //   width: double.infinity,
                    //   // color: Colors.brown,
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Text(
                    //           'Featured Property',
                    //           style: appTextStyle(
                    //             FontWeight.bold,
                    //             20.0,
                    //             kTextColor,
                    //           ),
                    //         ),
                    //       ),
                    //       InkWell(
                    //         onTap: (() {
                    //           print('Fetured Property #1');
                    //         }),
                    //         child: Text(
                    //           'See All',
                    //           style: appTextStyle(
                    //             FontWeight.w500,
                    //             12.0,
                    //             kThemeColor,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 8.0,
                    // ),
            //         Column(
            //           children: [
            //             FutureBuilder(
            //                 future: propertyList, // async work
            //                 builder:
            //                     (BuildContext context, AsyncSnapshot snapshot) {
            //                   switch (snapshot.connectionState) {
            //                     case ConnectionState.waiting:
            //                       return Container(
            //                         // color: Colors.white,
            //                         child: Column(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.center,
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: [
            //                             Align(
            //                               alignment: Alignment.center,
            //                               child: CircularProgressIndicator(
            //                                 backgroundColor: kPrimary,
            //                                 strokeWidth: 2,
            //                                 valueColor:
            //                                     AlwaysStoppedAnimation<Color>(
            //                                   kSecondary,
            //                                 ),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       );
            //                     default:
            //                       if (snapshot.hasError) {
            //                         return Container();
            //                       } else {
            //                         if (snapshot.data != null) {
            //                           print(
            //                               "snapshot.data.length = ${snapshot.data.length}");
            //                           // return Container(
            //                           //   color: Colors.black38,
            //                           // );
            //                           return ListView.builder(
            //                               physics:
            //                                   NeverScrollableScrollPhysics(),
            //                               shrinkWrap: true,
            //                               itemCount: snapshot.data.length,
            //                               padding: EdgeInsets.all(0),
            //                               itemBuilder: (BuildContext context,
            //                                   int index) {
            //                                 print(
            //                                     "********************** ${snapshot.data[index]['_embedded']['wp:term'][1][0]['name']}");
            //                                 if (snapshot.data[index]
            //                                         ['estate_featured'] ==
            //                                     '1') {
            //                                   return GestureDetector(
            //                                     onTap: (() {
            //                                       // Navigator.push(
            //                                       //   context,
            //                                       //   MaterialPageRoute(
            //                                       //     builder: (context) =>
            //                                       //         PropertyDetailScreen(
            //                                       //       snapshot.data[index]
            //                                       //               ['id']
            //                                       //           .toString(),
            //                                       //       snapshot
            //                                       //           .data[index]
            //                                       //               ['_embedded']
            //                                       //               ['wp:term'][1]
            //                                       //           .last['name'],
            //                                       //     ),
            //                                       //   ),
            //                                       // );
            //                                     }),
            //                                     child: NewBuildings(
            //                                       buildings: snapshot
            //                                           .data[index]['title']
            //                                               ['rendered']
            //                                           .toString()
            //                                           .titleCase,
            //                                       address: null,
            //                                       rating: 4.2,
            //                                       price: snapshot
            //                                               .data[index][
            //                                                   'estate_attr_price']
            //                                               .isNotEmpty
            //                                           ? oCcy.format(int.parse(
            //                                               snapshot.data[index][
            //                                                   'estate_attr_price']))
            //                                           : '-',
            //                                       photoAddress: snapshot
            //                                                       .data[index][
            //                                                   'featured_media'] !=
            //                                               0
            //                                           ? snapshot.data[index]
            //                                                       ['_embedded'][
            //                                                   'wp:featuredmedia']
            //                                               [0]['source_url']
            //                                           : 'https://gharjhagga.com/wp-content/uploads/2021/11/no-image.png',
            //                                       offerType: snapshot
            //                                           .data[index]['_embedded']
            //                                               ['wp:term'][1]
            //                                           .last['name'],
            //                                       bedroom: snapshot.data[index][
            //                                                   'estate_attr_bedrooms']
            //                                               .toString()
            //                                               .isNotEmpty
            //                                           ? snapshot.data[index][
            //                                                           'estate_attr_bedrooms']
            //                                                       .toString() !=
            //                                                   'null'
            //                                               ? snapshot.data[index]
            //                                                       [
            //                                                       'estate_attr_bedrooms']
            //                                                   .toString()
            //                                               : '0'
            //                                           : '0',
            //                                       bathroom: snapshot.data[index]
            //                                                   [
            //                                                   'estate_attr_bathrooms']
            //                                               .toString()
            //                                               .isNotEmpty
            //                                           ? snapshot.data[index][
            //                                                           'estate_attr_bathrooms']
            //                                                       .toString() !=
            //                                                   'null'
            //                                               ? snapshot.data[index]
            //                                                       [
            //                                                       'estate_attr_bathrooms']
            //                                                   .toString()
            //                                               : '0'
            //                                           : '0',
            //                                       propertySize: snapshot
            //                                               .data[index][
            //                                                   'estate_attr_property-size']
            //                                               .toString()
            //                                               .isNotEmpty
            //                                           ? snapshot.data[index][
            //                                                           'estate_attr_property-size']
            //                                                       .toString() !=
            //                                                   'null'
            //                                               ? snapshot.data[index]
            //                                                       [
            //                                                       'estate_attr_property-size']
            //                                                   .toString()
            //                                               : '0'
            //                                           : '0',
            //                                       neighborhood: snapshot
            //                                                   .data[index][
            //                                                       'neighborhood']
            //                                                   .length !=
            //                                               0
            //                                           ? snapshot
            //                                               .data[index]
            //                                                   ['_embedded']
            //                                                   ['wp:term'][4]
            //                                               .last['name']
            //                                           : '',
            //                                       street: snapshot
            //                                                   .data[index]
            //                                                       ['street']
            //                                                   .length !=
            //                                               0
            //                                           ? snapshot
            //                                               .data[index]
            //                                                   ['_embedded']
            //                                                   ['wp:term'][5]
            //                                               .last['name']
            //                                           : '',
            //                                       city: snapshot
            //                                                   .data[index]
            //                                                       ['city']
            //                                                   .length !=
            //                                               0
            //                                           ? snapshot
            //                                               .data[index]
            //                                                   ['_embedded']
            //                                                   ['wp:term'][2]
            //                                               .last['name']
            //                                           : '',
            //                                     ),
            //                                   );
            //                                   // return Container(
            //                                   //   color: Colors.black38,
            //                                   //   height: 100.0,
            //                                   //   child: Stack(
            //                                   //     children: [
            //                                   //       Card(
            //                                   //         shape:
            //                                   //             RoundedRectangleBorder(
            //                                   //           borderRadius:
            //                                   //               BorderRadius
            //                                   //                   .circular(
            //                                   //             16.0,
            //                                   //           ),
            //                                   //         ),
            //                                   //         child: Container(
            //                                   //           padding:
            //                                   //               EdgeInsets.all(8.0),
            //                                   //           child: Row(
            //                                   //             children: [
            //                                   //               Expanded(
            //                                   //                 flex: 2,
            //                                   //                 child: Container(
            //                                   //                   color: Colors
            //                                   //                       .black26,
            //                                   //                   child:
            //                                   //                       FutureBuilder(
            //                                   //                     future: imageURLCheck(
            //                                   //                         'https://gharjhagga.com/wp-content/uploads/2021/11/no-image.png'),
            //                                   //                     builder: (context,
            //                                   //                         asyncSnapshot) {
            //                                   //                       if (asyncSnapshot
            //                                   //                           .hasData) {
            //                                   //                         if (asyncSnapshot
            //                                   //                                 .data !=
            //                                   //                             null) {
            //                                   //                           return Container(
            //                                   //                             // color: Colors.green,
            //                                   //                             decoration:
            //                                   //                                 BoxDecoration(
            //                                   //                               borderRadius:
            //                                   //                                   BorderRadius.all(
            //                                   //                                 Radius.circular(8.0),
            //                                   //                               ),
            //                                   //                               color:
            //                                   //                                   Colors.grey,
            //                                   //                               image:
            //                                   //                                   DecorationImage(
            //                                   //                                 image: NetworkImage(
            //                                   //                                   "https://gharjhagga.com/wp-content/uploads/2021/11/no-image.png",
            //                                   //                                 ),
            //                                   //                                 fit: BoxFit.cover,
            //                                   //                               ),
            //                                   //                             ),
            //                                   //                           );
            //                                   //                         } else {
            //                                   //                           return Container(
            //                                   //                             // color: Colors.black,
            //                                   //                             // width: 200,
            //                                   //                             child:
            //                                   //                                 CircleAvatar(
            //                                   //                               radius:
            //                                   //                                   60,
            //                                   //                               backgroundColor:
            //                                   //                                   Colors.transparent,
            //                                   //                               backgroundImage:
            //                                   //                                   AssetImage(
            //                                   //                                 "assets/images/no_image.png",
            //                                   //                               ),
            //                                   //                             ),
            //                                   //                           );
            //                                   //                         }
            //                                   //                       } else {
            //                                   //                         return Container(
            //                                   //                           color: Colors
            //                                   //                               .white,
            //                                   //                           height:
            //                                   //                               150,
            //                                   //                           child:
            //                                   //                               Center(
            //                                   //                             child:
            //                                   //                                 CupertinoActivityIndicator(),
            //                                   //                           ),
            //                                   //                         );
            //                                   //                       }
            //                                   //                     },
            //                                   //                   ),
            //                                   //                 ),
            //                                   //               ),
            //                                   //               Expanded(
            //                                   //                 flex: 3,
            //                                   //                 child: Container(
            //                                   //                   color: Colors
            //                                   //                       .black12,
            //                                   //                   child: Column(
            //                                   //                     crossAxisAlignment:
            //                                   //                         CrossAxisAlignment
            //                                   //                             .start,
            //                                   //                     mainAxisAlignment:
            //                                   //                         MainAxisAlignment
            //                                   //                             .spaceEvenly,
            //                                   //                     children: [
            //                                   //                       Text(
            //                                   //                         'widget.buildings',
            //                                   //                         style:
            //                                   //                             appTextStyle(
            //                                   //                           FontWeight
            //                                   //                               .bold,
            //                                   //                           14.0,
            //                                   //                           kTextColor,
            //                                   //                         ),
            //                                   //                         maxLines:
            //                                   //                             2,
            //                                   //                         overflow:
            //                                   //                             TextOverflow
            //                                   //                                 .ellipsis,
            //                                   //                       ),
            //                                   //                       // Row(
            //                                   //                       //   children: [
            //                                   //                       //     ImageIcon(
            //                                   //                       //       AssetImage("assets/icons/Star.png"),
            //                                   //                       //       color: Color(0xFFFBBC04),
            //                                   //                       //       size: 10.0,
            //                                   //                       //     ),
            //                                   //                       //     SizedBox(
            //                                   //                       //       width: 4.0,
            //                                   //                       //     ),
            //                                   //                       //     Text(
            //                                   //                       //       '${widget.rating}',
            //                                   //                       //       style: appTextStyle(
            //                                   //                       //         FontWeight.bold,
            //                                   //                       //         12.0,
            //                                   //                       //         kTextColorLight,
            //                                   //                       //       ),
            //                                   //                       //     ),
            //                                   //                       //   ],
            //                                   //                       // ),
            //                                   //                       // widget.address != null
            //                                   //                       //     ? Row(
            //                                   //                       //         mainAxisAlignment: MainAxisAlignment.start,
            //                                   //                       //         children: [
            //                                   //                       //           ImageIcon(
            //                                   //                       //             AssetImage("assets/icons/Location.png"),
            //                                   //                       //             color: kTextHintColor,
            //                                   //                       //             size: 12.0,
            //                                   //                       //           ),
            //                                   //                       //           SizedBox(
            //                                   //                       //             width: 5.0,
            //                                   //                       //           ),
            //                                   //                       //           Text(
            //                                   //                       //             '${widget.address}',
            //                                   //                       //             style: appTextStyle(
            //                                   //                       //               FontWeight.w600,
            //                                   //                       //               12.0,
            //                                   //                       //               kTextHintColor,
            //                                   //                       //             ),
            //                                   //                       //           ),
            //                                   //                       //         ],
            //                                   //                       //       )
            //                                   //                       //     : Container(),
            //                                   //                       RichText(
            //                                   //                         text:
            //                                   //                             TextSpan(
            //                                   //                           text:
            //                                   //                               'Rs. 122 /-',
            //                                   //                           style:
            //                                   //                               appTextStyle(
            //                                   //                             FontWeight
            //                                   //                                 .bold,
            //                                   //                             14.0,
            //                                   //                             kThemeColor,
            //                                   //                           ),
            //                                   //                         ),
            //                                   //                       ),
            //                                   //                     ],
            //                                   //                   ),
            //                                   //                 ),
            //                                   //               ),
            //                                   //             ],
            //                                   //           ),
            //                                   //         ),
            //                                   //       ),
            //                                   //       Positioned(
            //                                   //         left: 4,
            //                                   //         top: 4,
            //                                   //         child: Container(
            //                                   //           // color: kThemeColor,
            //                                   //           decoration:
            //                                   //               BoxDecoration(
            //                                   //             borderRadius:
            //                                   //                 BorderRadius.only(
            //                                   //                     topLeft: Radius
            //                                   //                         .circular(
            //                                   //                             16.0)),
            //                                   //             color: kThemeColor,
            //                                   //           ),
            //                                   //           padding: EdgeInsets
            //                                   //               .symmetric(
            //                                   //             vertical: 4.0,
            //                                   //             horizontal: 16.0,
            //                                   //           ),
            //                                   //           child: Text(
            //                                   //             "${snapshot.data[index]['_embedded']['wp:term'][1][0]['name']}",
            //                                   //             style: appTextStyle(
            //                                   //               FontWeight.bold,
            //                                   //               12.0,
            //                                   //               Colors.white,
            //                                   //             ),
            //                                   //           ),
            //                                   //         ),
            //                                   //       ),
            //                                   //     ],
            //                                   //   ),
            //                                   // );
            //                                 } else {
            //                                   return Container();
            //                                 }
            //                               });
            //                         } else {
            //                           return Container(
            //                             width: double.infinity,
            //                             padding: EdgeInsets.symmetric(
            //                                 horizontal: 20.0),
            //                             child: Column(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment.center,
            //                               children: [
            //                                 Hero(
            //                                   tag: "no_data",
            //                                   child: Material(
            //                                     color: Colors.transparent,
            //                                     child: Image.asset(
            //                                       "assets/images/no_data.png",
            //                                       fit: BoxFit.fitHeight,
            //                                       height: 80,
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 SizedBox(
            //                                   height: 8.0,
            //                                 ),
            //                                 Text(
            //                                   'No property found',
            //                                   style: appTextStyleWLS(
            //                                     FontWeight.w500,
            //                                     12.0,
            //                                     Colors.black54,
            //                                   ),
            //                                   textAlign: TextAlign.center,
            //                                 ),
            //                               ],
            //                             ),
            //                           );
            //                         }
            //                       }
            //                   }
            //                 }),

            //             // Container(
            //             //   width: double.infinity,
            //             //   color: Colors.black12,
            //             // child: ListView.builder(
            //             //     physics: BouncingScrollPhysics(),
            //             //     shrinkWrap: true,
            //             //     itemCount: 2,
            //             //     padding: EdgeInsets.all(0),
            //             //     itemBuilder: (BuildContext context, int index) {
            //             //       return Container(
            //             //         color: Colors.black38,
            //             //         height: 104.0,
            //             //         child: Card(
            //             //           shape: RoundedRectangleBorder(
            //             //             borderRadius: BorderRadius.circular(15.0),
            //             //           ),
            //             //           child: Container(),
            //             //         ),
            //             //       );
            //             //     }),
            //             // ),
            //           ],
            //         ),
            //         //,               Container(
            //         //                 height: 300.0,
            //         //                 // width: double.infinity,
            //         //                 color: Colors.yellow,
            //         //                 child: FutureBuilder(
            //         //                   future: propertyList, // async work
            //         //                   builder:
            //         //                       (BuildContext context, AsyncSnapshot snapshot) {
            //         // switch (snapshot.connectionState) {
            //         //   case ConnectionState.waiting:
            //         //     return Container(
            //         //       // color: Colors.white,
            //         //       child: Column(
            //         //         crossAxisAlignment: CrossAxisAlignment.center,
            //         //         mainAxisAlignment: MainAxisAlignment.center,
            //         //         children: [
            //         //           Align(
            //         //             alignment: Alignment.center,
            //         //             child: CircularProgressIndicator(
            //         //               backgroundColor: kPrimary,
            //         //               strokeWidth: 2,
            //         //               valueColor:
            //         //                   AlwaysStoppedAnimation<Color>(
            //         //                 kSecondary,
            //         //               ),
            //         //             ),
            //         //           ),
            //         //         ],
            //         //       ),
            //         //     );
            //         //                       default:
            //         //                         if (snapshot.hasError) {
            //         //                           return Container();
            //         //                         } else {
            //         //                           if (snapshot.data != null) {
            //         //                             return ListView.builder(
            //         //                                 physics: BouncingScrollPhysics(),
            //         //                                 shrinkWrap: true,
            //         //                                 itemCount: snapshot.data.length >= 5
            //         //                                     ? 5
            //         //                                     : snapshot.data.length,
            //         //                                 padding: EdgeInsets.all(0),
            //         //                                 itemBuilder:
            //         //                                     (BuildContext context, int index) {
            //         //                                   print(snapshot.data[index]
            //         //                                       ['estate_featured']);
            //         //                                   if (snapshot.data[index]
            //         //                                           ['estate_featured'] ==
            //         //                                       '1') {
            //         //                                     return Container(
            //         //                                       margin: EdgeInsets.only(
            //         //                                         right: 16.0,
            //         //                                       ),
            //         //                                       child: GestureDetector(
            //         //                                         onTap: (() {
            //         //                                           Navigator.push(
            //         //                                             context,
            //         //                                             MaterialPageRoute(
            //         //                                               builder: (context) =>
            //         //                                                   DetailScreen(),
            //         //                                             ),
            //         //                                           );
            //         //                                         }),
            //         // child: NewBuildings(
            //         //   buildings: snapshot.data[index]
            //         //           ['title']['rendered']
            //         //       .toString()
            //         //       .titleCase,
            //         //   address: null,
            //         //   rating: 4.2,
            //         //   price: 203,
            //         //   photoAddress: snapshot
            //         //                   .data[index][
            //         //               'featured_media'] !=
            //         //           0
            //         //       ? snapshot.data[index]
            //         //                   ['_embedded']
            //         //               ['wp:featuredmedia']
            //         //           [0]['source_url']
            //         //       : 'https://gharjhagga.com/wp-content/uploads/2021/11/no-image.png',
            //         // ),

            //         //                                         child: Container(
            //         // width: double.infinity,
            //         // height: 104.0,
            //         // color: Colors.black45,
            //         // child: Card(
            //         //   shape: RoundedRectangleBorder(
            //         //     borderRadius: BorderRadius.circular(15.0),
            //         //   ),),),
            //         //                                       ),
            //         //                                     );
            //         //                                   } else {
            //         //                                     return Container();
            //         //                                   }
            //         //                                 });
            //         //                           } else {
            //         //                             return Container(
            //         //                               width: double.infinity,
            //         //                               padding:
            //         //                                   EdgeInsets.symmetric(horizontal: 20.0),
            //         //                               child: Column(
            //         //                                 mainAxisAlignment:
            //         //                                     MainAxisAlignment.center,
            //         //                                 children: [
            //         //                                   Hero(
            //         //                                     tag: "no_data",
            //         //                                     child: Material(
            //         //                                       color: Colors.transparent,
            //         //                                       child: Image.asset(
            //         //                                         "assets/images/no_data.png",
            //         //                                         fit: BoxFit.fitHeight,
            //         //                                         height: 80,
            //         //                                       ),
            //         //                                     ),
            //         //                                   ),
            //         //                                   SizedBox(
            //         //                                     height: 8.0,
            //         //                                   ),
            //         //                                   Text(
            //         //                                     'No news found',
            //         //                                     style: appTextStyleWLS(
            //         //                                       FontWeight.w500,
            //         //                                       12.0,
            //         //                                       Colors.black54,
            //         //                                     ),
            //         //                                     textAlign: TextAlign.center,
            //         //                                   ),
            //         //                                 ],
            //         //                               ),
            //         //                             );
            //         //                           }
            //         //                         }
            //         //                     }
            //         //                   },
            //         //                 ),
            //         //               ),
            //       ],
            //     ),
            //   ),
            // ),
//             // Expanded(
//             //   // flex: 3,
//             // child: Container(
//             //   // height: 500.0,
//             //   width: double.infinity,
//             //   padding: EdgeInsets.only(
//             //     top: 8.0,
//             //     left: 22.0,
//             //     right: 22.0,
//             //   ),
//             // decoration: BoxDecoration(
//             //   color: Theme.of(context).scaffoldBackgroundColor,
//             //   borderRadius: BorderRadius.only(
//             //     topRight: Radius.circular(30.0),
//             //     topLeft: Radius.circular(30.0),
//             //   ),
//             // ),
//             //     child: ListView(
//             //       padding: EdgeInsets.only(
//             //         top: 12.0,
//             //       ),
//             //       physics: BouncingScrollPhysics(),
//             //       children: [
//             // Container(
//             //   width: double.infinity,
//             //   // color: Colors.green,
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //     children: [
//             //       Text(
//             //         'Special for you',
//             //         style: appTextStyle(
//             //           FontWeight.bold,
//             //           22.0,
//             //           kTextColor,
//             //         ),
//             //       ),
//             //       Text(
//             //         'See All',
//             //         // style: TextStyle(
//             //         //   color: Colors.red,
//             //         // ),
//             //         style: appTextStyle(
//             //           FontWeight.normal,
//             //           14.0,
//             //           kThemeColor,
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             // SizedBox(
//             //   height: 10.0,
//             // ),
//             //         Container(
//             //           height: 300.0,
//             //           width: double.infinity,
//             //           // color: Colors.blue,
//             // child: ListView(
//             //   scrollDirection: Axis.horizontal,
//             //   physics: BouncingScrollPhysics(),
//             //   children: [
//             //     GestureDetector(
//             //       onTap: (() {
//             //         Navigator.push(
//             //           context,
//             //           MaterialPageRoute(
//             //             builder: (context) => DetailScreen(),
//             //           ),
//             //         );
//             //       }),
//             //       child: BlastApartment(
//             //         photoLink:
//             //             'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/2e/25/da/old-town-by-welcome-apartment.jpg?w=900&h=-1&s=1',
//             //         apartmentName: 'Blast Apartment',
//             //         price: 246,
//             //         location: 'Purwokerto, Indonesia',
//             //       ),
//             //     ),
//             //     SizedBox(
//             //       width: 10.0,
//             //     ),
//             //     BlastApartment(
//             //       photoLink:
//             //           'https://cdn.home-designing.com/wp-content/uploads/2014/08/colorful-apartment.jpg',
//             //       apartmentName: 'Classic Apartment',
//             //       price: 132,
//             //       location: 'Banduwa, Indonesia',
//             //     ),
//             //   ],
//             // ),
//             //         ),
//             // SizedBox(
//             //   height: 20.0,
//             // ),
//             // Container(
//             //   // height: 100.0,
//             //   width: double.infinity,
//             //   // color: Colors.brown,
//             //   child: Text(
//             //     'New Buildings',
//             //     style: appTextStyle(
//             //       FontWeight.bold,
//             //       22.0,
//             //       kTextColor,
//             //     ),
//             //   ),
//             // ),
//             // SizedBox(
//             //   height: 8.0,
//             // ),
//             //       Container(
//             //         // height: 300.0,
//             //         width: double.infinity,
//             //         // color: Colors.yellow,
//             //         child: Column(
//             //           children: [
//             // NewBuildings(
//             //   buildings: 'Luxury Hotel',
//             //   address: 'Elandung, Indonesia',
//             //   rating: 4.2,
//             //   price: 203,
//             //   photoAddress:
//             //       'https://www.travelplusstyle.com/wp-content/uploads/2021/01/g-02-patina-maldives-1.jpg',
//             // ),
//             //             NewBuildings(
//             //               buildings: 'Rahayu House',
//             //               address: 'Jakarta, Indonesia',
//             //               rating: 4.1,
//             //               price: 195,
//             //               photoAddress:
//             //                   'https://pix4.agoda.net/hotelimages/12230086/0/53172a8bca61ab12104fc72f7a00584e.jpg',
//             //             ),
//             //             NewBuildings(
//             //               buildings: 'Xitend Apartment',
//             //               address: 'Solo, Indonesia',
//             //               rating: 4.3,
//             //               price: 188,
//             //               photoAddress:
//             //                   'https://pix10.agoda.net/hotelImages/2163054/-1/4f3b334212d6cf837f60ee731edf916d.jpg',
//             //             ),
//             //           ],
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
