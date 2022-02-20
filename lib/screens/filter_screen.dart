import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:iconly/iconly.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double rating = 3.0;
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  int _value = 0;
  int _value2 = -1;
  int _valueFace = -1;
  int _roomsValue = 4;

  List<String> properties = [
    'All',
    'House',
    'Apartment',
    'Office',
    'Landmark',
  ];

  List<String> propertyType = [
    'Commercial',
    'Residential',
  ];

  List<String> propertyFace = [
    'East',
    'West',
    'North',
    'South',
  ];

  List<String> rooms = [
    'Any',
    '1',
    '2',
    '3',
    '4',
    '5+',
  ];

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
                  left: 26.0,
                  top: 38.0,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (() {
                        Navigator.pop(context);
                      }),
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFEC5A22),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80.0,
                    ),
                    Text(
                      'Filter',
                      style: appTextStyle(
                        FontWeight.w700,
                        28.0,
                        Colors.white,
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
                child: ListView(
                  padding: EdgeInsets.only(
                    top: 16.0,
                    left: 0.0,
                  ),
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 0.0,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            width: double.infinity,
                            // color: Colors.green,
                            child: Text(
                              'Properties',
                              style: appTextStyle(
                                FontWeight.w700,
                                18.0,
                                kTextColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 9.0,
                          ),
                          Container(
                            // color: Colors.purple,
                            height: 39.0,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: List<Widget>.generate(
                                properties.length,
                                (int index) {
                                  return Row(
                                    children: [
                                      ChoiceChip(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Color(0xFFDADADA),
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                          vertical: 10.0,
                                        ),
                                        selectedColor: kSecondary,
                                        backgroundColor: Colors.white,
                                        label: Text(
                                          properties[index],
                                          style: appTextStyle(
                                            FontWeight.w400,
                                            14.0,
                                            _value == index
                                                ? Colors.white
                                                : kTextHintColor,
                                          ),
                                        ),
                                        selected: _value == index,
                                        onSelected: (bool selected) {
                                          setState(() {
                                            _value = (selected ? index : null)!;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 12.0,
                                      ),
                                    ],
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                      ),
                      child: Column(
                        children: [
                          Container(
                            // height: 100.0,
                            width: double.infinity,
                            // color: Colors.grey,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  // color: Colors.green,
                                  child: Text(
                                    'Property Type',
                                    style: appTextStyle(
                                      FontWeight.w700,
                                      18.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 9.0,
                                ),
                                Container(
                                  // color: Colors.purple,
                                  height: 39.0,
                                  child: ListView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: List<Widget>.generate(
                                      propertyType.length,
                                      (int index) {
                                        return Row(
                                          children: [
                                            ChoiceChip(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Color(0xFFDADADA),
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0,
                                              ),
                                              selectedColor: kSecondary,
                                              backgroundColor: Colors.white,
                                              label: Text(
                                                propertyType[index],
                                                style: appTextStyle(
                                                  FontWeight.w400,
                                                  14.0,
                                                  _value2 == index
                                                      ? Colors.white
                                                      : kTextHintColor,
                                                ),
                                              ),
                                              selected: _value2 == index,
                                              onSelected: (bool selected) {
                                                setState(() {
                                                  _value2 = (selected
                                                      ? index
                                                      : null)!;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 12.0,
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // height: 100.0,
                            width: double.infinity,
                            // color: Colors.yellow,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  // color: Colors.green,
                                  child: Text(
                                    'Property Face',
                                    style: appTextStyle(
                                      FontWeight.w700,
                                      18.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 9.0,
                                ),
                                Container(
                                  // color: Colors.purple,
                                  height: 39.0,
                                  child: ListView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: List<Widget>.generate(
                                      propertyFace.length,
                                      (int index) {
                                        return Row(
                                          children: [
                                            ChoiceChip(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Color(0xFFDADADA),
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0,
                                              ),
                                              selectedColor: kSecondary,
                                              backgroundColor: Colors.white,
                                              label: Text(
                                                propertyFace[index],
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: _valueFace == index
                                                      ? Colors.white
                                                      : kTextHintColor,
                                                ),
                                              ),
                                              selected: _valueFace == index,
                                              onSelected: (bool selected) {
                                                setState(() {
                                                  _valueFace = (selected
                                                      ? index
                                                      : null)!;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 12.0,
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // height: 100.0,
                            width: double.infinity,
                            // color: Colors.blue,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  // color: Colors.green,
                                  child: Text(
                                    'Price Range',
                                    style: appTextStyle(
                                      FontWeight.w700,
                                      18.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 9.0,
                                ),
                                RangeSlider(
                                  activeColor: kThemeColor,
                                  inactiveColor: Color(0xFFE8E5E7),
                                  values: _currentRangeValues,
                                  min: 0,
                                  max: 200,
                                  divisions: 10,
                                  labels: RangeLabels(
                                    _currentRangeValues.start
                                        .round()
                                        .toString(),
                                    _currentRangeValues.end.round().toString(),
                                  ),
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      _currentRangeValues = values;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100.0,
                            width: double.infinity,
                            // color: Colors.pink,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  // color: Colors.green,
                                  child: Text(
                                    'Bathrooms',
                                    style: appTextStyle(
                                      FontWeight.w700,
                                      18.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 9.0,
                                ),
                                Container(
                                  // color: Colors.purple,
                                  height: 39.0,
                                  child: ListView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: List<Widget>.generate(
                                      rooms.length,
                                      (int index) {
                                        return Row(
                                          children: [
                                            ChoiceChip(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Color(0xFFDADADA),
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0,
                                              ),
                                              selectedColor: kSecondary,
                                              backgroundColor: Colors.white,
                                              label: Text(
                                                rooms[index],
                                                style: appTextStyle(
                                                  FontWeight.w400,
                                                  14.0,
                                                  _roomsValue == index
                                                      ? Colors.white
                                                      : kTextHintColor,
                                                ),
                                              ),
                                              selected: _roomsValue == index,
                                              onSelected: (bool selected) {
                                                setState(() {
                                                  _roomsValue = (selected
                                                      ? index
                                                      : null)!;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 12.0,
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // height: 100.0,
                            width: double.infinity,
                            // color: Colors.orange,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  // color: Colors.green,
                                  child: Text(
                                    'Property Size',
                                    style: appTextStyle(
                                      FontWeight.w700,
                                      18.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 9.0,
                                ),
                                RangeSlider(
                                  activeColor: kThemeColor,
                                  inactiveColor: Color(0xFFE8E5E7),
                                  values: _currentRangeValues,
                                  min: 0,
                                  max: 200,
                                  divisions: 10,
                                  labels: RangeLabels(
                                    _currentRangeValues.start
                                        .round()
                                        .toString(),
                                    _currentRangeValues.end.round().toString(),
                                  ),
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      _currentRangeValues = values;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // height: 100.0,
                            width: double.infinity,
                            // color: Colors.lightBlue,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  // color: Colors.green,
                                  child: Text(
                                    'Star Range',
                                    style: appTextStyle(
                                      FontWeight.w700,
                                      18.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 9.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  // color: Colors.black,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: RatingBar.builder(
                                              initialRating: 5,
                                              itemSize: 20,
                                              minRating: 1,
                                              ignoreGestures: true,
                                              direction: Axis.horizontal,
                                              // allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0,
                                              ),
                                              itemBuilder: (context, _) => Icon(
                                                IconlyBold.star,
                                                size: 8.0,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rate) {
                                                print(rate);
                                                setState(() {
                                                  rating = rate;
                                                });
                                              },
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                            child: Checkbox(
                                              tristate: true,
                                              value: true,
                                              activeColor: kThemeColor,
                                              onChanged: (bool? value) async {
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: RatingBar.builder(
                                              initialRating: 4,
                                              itemSize: 20,
                                              minRating: 1,
                                              ignoreGestures: true,
                                              direction: Axis.horizontal,
                                              // allowHalfRating: true,
                                              itemCount: 4,
                                              itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0,
                                              ),
                                              itemBuilder: (context, _) => Icon(
                                                IconlyBold.star,
                                                size: 8.0,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rate) {
                                                print(rate);
                                                setState(() {
                                                  rating = rate;
                                                });
                                              },
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                            child: Checkbox(
                                              tristate: true,
                                              value: false,
                                              activeColor: kThemeColor,
                                              onChanged: (bool? value) async {
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: RatingBar.builder(
                                              initialRating: 3,
                                              itemSize: 20,
                                              minRating: 1,
                                              ignoreGestures: true,
                                              direction: Axis.horizontal,
                                              // allowHalfRating: true,
                                              itemCount: 3,
                                              itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0,
                                              ),
                                              itemBuilder: (context, _) => Icon(
                                                IconlyBold.star,
                                                size: 8.0,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rate) {
                                                print(rate);
                                                setState(() {
                                                  rating = rate;
                                                });
                                              },
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                            child: Checkbox(
                                              tristate: true,
                                              value: false,
                                              activeColor: kThemeColor,
                                              onChanged: (bool? value) async {
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: RatingBar.builder(
                                              initialRating: 2,
                                              itemSize: 20,
                                              minRating: 1,
                                              ignoreGestures: true,
                                              direction: Axis.horizontal,
                                              // allowHalfRating: true,
                                              itemCount: 2,
                                              itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0,
                                              ),
                                              itemBuilder: (context, _) => Icon(
                                                IconlyBold.star,
                                                size: 8.0,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rate) {
                                                print(rate);
                                                setState(() {
                                                  rating = rate;
                                                });
                                              },
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                            child: Checkbox(
                                              tristate: true,
                                              value: false,
                                              activeColor: kThemeColor,
                                              onChanged: (bool? value) async {
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: RatingBar.builder(
                                              initialRating: 1,
                                              itemSize: 20,
                                              minRating: 1,
                                              ignoreGestures: true,
                                              direction: Axis.horizontal,
                                              // allowHalfRating: true,
                                              itemCount: 1,
                                              itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0,
                                              ),
                                              itemBuilder: (context, _) => Icon(
                                                IconlyBold.star,
                                                size: 8.0,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rate) {
                                                print(rate);
                                                setState(() {
                                                  rating = rate;
                                                });
                                              },
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                            child: Checkbox(
                                              tristate: true,
                                              value: false,
                                              activeColor: kThemeColor,
                                              onChanged: (bool? value) async {
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25.0,
              right: 25.0,
              bottom: 20.0,
              top: 20.0,
            ),
            child: Container(
              height: 60.0,
              // width: 214.0,
              decoration: BoxDecoration(
                color: Color(0xFF1B1839),
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: Center(
                child: Text(
                  'Apply Filter',
                  style: appTextStyle(
                    FontWeight.normal,
                    16.0,
                    Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
