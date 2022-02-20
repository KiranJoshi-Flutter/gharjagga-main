import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:gharjagga/delegates/gridviewdelegate.dart';
import 'package:gharjagga/utlis/userpreferences.dart';
import 'dart:core';
import 'package:iconly/iconly.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:getwidget/getwidget.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;

class AddNewPropertyScreen extends StatefulWidget {
  @override
  _AddNewPropertyScreenState createState() => _AddNewPropertyScreenState();
}

class _AddNewPropertyScreenState extends State<AddNewPropertyScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // quill.QuillController _controller = quill.QuillController.basic();

  XFile? _image;
  // Pick multiple images
  List<File> _imgGallery = [];
  List<String> _imgGalleryId = [];

  void _imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      _image = image;
    });
  }

  void _galleryPicker() async {
    var images = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      _imgGallery.add(File(images!.path));
    });

    print(_imgGallery);
  }

  int _dropdownValuePropertyType = 5;
  int _dropdownValueZipCode = 44600;
  int _dropdownValueCity = 10;
  int _dropdownValueNeighborhood = 153;
  int _dropdownValueStreet = 160;
  int _dropdownValueOfferType = 3;

  List _cityData = [];
  List _neighborhoodData = [];
  List _streetData = [];
  List _offerTypeData = [];

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _propertyTypeController = TextEditingController();
  TextEditingController _offerTypeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _bedroomsController = TextEditingController();
  TextEditingController _bathroomsController = TextEditingController();
  TextEditingController _lotSizeController = TextEditingController();
  TextEditingController _propertySizeController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _featuresController = TextEditingController();

  TextEditingController _streetController = TextEditingController();
  TextEditingController _neighborhoodController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  late Future _propertyType;
  var selectedPropertyType;

  late Future _offerType;
  var selectedOfferType;

  late Future _features;
  var selectedFeatures = [];
  var selectedFeaturesId = [];

  late Future _streets;
  var selectedStreet;

  late Future _neighborhood;
  var selectedNeighborhood;

  late Future _city;
  var selectedCity;

  var selectedFeaturedMediaId;

  bool isFeaturedMediaSaved = false;
  bool isGallerySaved = false;

  @override
  void initState() {
    super.initState();
    _propertyType = fetchPorpertyType();
    _offerType = fetchOfferType();
    _features = fetchFeatures();
    _city = fetchCity();
    _neighborhood = fetchNeighborhood();
    _streets = fetchStreet();
    // fetchOfferType();
  }

  Future fetchPorpertyType() async {
    final request = await http.get(
      Uri.parse(
        "https://gharjhagga.com/wp-json/wp/v2/property-type?_embed",
      ),
    );

    var res = json.decode(request.body);
    print(res);

    if (res.length != 0) {
      // print('id');
      return res;
    } else {
      return null;
    }
  }

  // https://gharjhagga.com/wp-json/wp/v2/features

  Future fetchOfferType() async {
    final response = await http.get(
      Uri.parse(
        'https://gharjhagga.com/wp-json/wp/v2/offer-type',
      ),
    );

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      if (res.length != 0) {
        // print('id');
        return res;
      } else {
        return null;
      }
      // return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Offer Type');
    }
  }

  Future fetchFeatures() async {
    final response = await http.get(
      Uri.parse(
        'https://gharjhagga.com/wp-json/wp/v2/features',
      ),
    );

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      if (res.length != 0) {
        // print('id');
        return res;
      } else {
        return null;
      }
      // return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Offer Type');
    }
  }

  Future fetchNeighborhood() async {
    final response = await http
        .get(Uri.parse('https://gharjhagga.com/wp-json/wp/v2/neighborhood'));

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      if (res.length != 0) {
        // print('id');
        return res;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load Neighborhood');
    }
  }

  Future fetchCity() async {
    final response =
        await http.get(Uri.parse('https://gharjhagga.com/wp-json/wp/v2/city'));

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      if (res.length != 0) {
        // print('id');
        return res;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load city');
    }
  }

  Future fetchStreet() async {
    final response = await http
        .get(Uri.parse('https://gharjhagga.com/wp-json/wp/v2/street'));

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      if (res.length != 0) {
        // print('id');
        return res;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load Street');
    }
  }

  void _uploadGallery() async {
    var userId = await UserPreferences.getUserId();

    for (int a = 0; a < _imgGallery.length; a++) {
      // final snackBar = ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         CircularProgressIndicator(
      //           color: kThemeColor,
      //           backgroundColor: kPrimary,
      //           strokeWidth: 1.5,
      //         ),
      //         SizedBox(
      //           width: 16.0,
      //         ),
      //         Text(
      //           'Uploading Gallery.....',
      //           style: appTextStyle(
      //             FontWeight.bold,
      //             16.0,
      //             Colors.white,
      //           ),
      //         ),
      //       ],
      //     ),
      //     duration: Duration(hours: 1),
      //   ),
      // );

      toastMeaasge(
        'Uploading Gallery.....',
        kGreenColor,
        context,
      );

      print(_imgGallery[a]);

      print(userId);
      print('Image Path = ${_imgGallery[a].path}');

      var headers = {
        'Authorization': 'Basic YWRtaW46bGlnaHR3ZWJncm91cC5jb20xMDAw'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://gharjhagga.com/wp-json/wp/v2/media'));
      request.fields.addAll({
        'author': '$userId',
        'media_type': 'image',
        'title': 'Gallery $a - ${_titleController.text.trim().toString()}',
        'alt_text': 'gallery'
      });
      request.files
          .add(await http.MultipartFile.fromPath('file', _imgGallery[a].path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var res = (await response.stream.bytesToString());
        var resJSON = json.decode(res);

        if (a == _imgGallery.length - 1) {
          print('last');
          setState(() {
            isGallerySaved = true;
          });

          // snackBar.close();
          toastMeaasge(
            'Gallery Uploaded.....',
            kGreenColor,
            context,
          );
        }

        setState(() {
          _imgGalleryId.add(resJSON['id'].toString());
        });
        print(_imgGalleryId);
      } else {
        print(response.reasonPhrase);
      }
    }

    print(_imgGalleryId);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kThemeColor,
        title: Text(
          'Add Property',
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
        child: Container(
          color: theme.scaffoldBackgroundColor,
          child:
              //  Padding(
              // padding: const EdgeInsets.symmetric(
              //   horizontal: 16.0,
              //   vertical: 16.0,
              // ),
              // child:
              ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 16.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: TextFormField(
                  controller: _titleController,
                  style: appTextStyle(
                    FontWeight.normal,
                    14.0,
                    kTextColor,
                  ),
                  cursorColor: kSecondary,
                  decoration: InputDecoration(
                    // labelText: 'Enter something',
                    hintText: 'Title',
                    hintStyle: appTextStyle(
                      FontWeight.normal,
                      14.0,
                      kTextHintColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.75,
                        color: kBorderColor,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kSecondary,
                      ),
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                ),
              ),

              SizedBox(
                height: 8.0,
              ),
              // Description
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: null,
                  style: appTextStyle(
                    FontWeight.normal,
                    14.0,
                    kTextColor,
                  ),
                  cursorColor: kSecondary,
                  decoration: InputDecoration(
                    // labelText: 'Enter something',
                    hintText: 'Description',
                    hintStyle: appTextStyle(
                      FontWeight.normal,
                      14.0,
                      kTextHintColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.75,
                        color: kBorderColor,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kSecondary,
                      ),
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              // Price
              // Container(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: 16.0,
              //   ),
              //   child: TextFormField(
              //     controller: _priceController,
              //     style: appTextStyle(
              //       FontWeight.normal,
              //       14.0,
              //       kTextColor,
              //     ),
              //     cursorColor: kSecondary,
              //     decoration: InputDecoration(
              //       // labelText: 'Enter something',
              //       hintText: 'Price (Rs.)',
              //       hintStyle: appTextStyle(
              //         FontWeight.normal,
              //         14.0,
              //         kTextHintColor,
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           width: 0.75,
              //           color: kBorderColor,
              //         ),
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           width: 1,
              //           color: kSecondary,
              //         ),
              //         borderRadius: BorderRadius.circular(
              //           12,
              //         ),
              //       ),
              //     ),
              //     textInputAction: TextInputAction.next,
              //     keyboardType: TextInputType.number,
              //   ),
              // ),
              // SizedBox(
              //   height: 16.0,
              // ),
              // Property Type
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Property Type',
                      style: appTextStyle(
                        FontWeight.normal,
                        16.0,
                        kTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FutureBuilder(
                      future: _propertyType, // async work
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container(
                              // color: Colors.white,
                              child: GFShimmer(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      // horizontal: 16,
                                      ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          // width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                          ),
                                          height: 46,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          default:
                            if (snapshot.hasError) {
                              return Container();
                            } else {
                              if (snapshot.data != null) {
                                return FadedSlideAnimation(
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          // context and builder are
                                          // required properties in this widget
                                          context: context,
                                          builder: (BuildContext context) {
                                            // we set up a container inside which
                                            // we create center column and display text
                                            return Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8.0,
                                                    ),
                                                    child: Text(
                                                      'Property Types',
                                                      style: appTextStyle(
                                                        FontWeight.bold,
                                                        16.0,
                                                        Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: kDividerColor,
                                                  ),
                                                  Expanded(
                                                    child: ListView.builder(
                                                      // controller:
                                                      //     _scrollController,
                                                      shrinkWrap: true,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        // vertical: 16.0,
                                                      ),
                                                      // itemExtent: 80,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              _propertyTypeController
                                                                      .text =
                                                                  snapshot.data[
                                                                          index]
                                                                      ['name'];

                                                              selectedPropertyType =
                                                                  snapshot.data[
                                                                          index]
                                                                      ['id'];

                                                              print(
                                                                  "selectedPropertyType = ${selectedPropertyType}");
                                                            });

                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                          child: Card(
                                                            elevation: 0,
                                                            color: Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4,
                                                              ),
                                                            ),
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical: 16.0,
                                                                horizontal:
                                                                    16.0,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      snapshot.data[
                                                                              index]
                                                                          [
                                                                          'name'],
                                                                      style:
                                                                          appTextStyle(
                                                                        FontWeight
                                                                            .w500,
                                                                        14.0,
                                                                        kTextColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  selectedPropertyType ==
                                                                          snapshot.data[index]
                                                                              [
                                                                              'id']
                                                                      ? Icon(
                                                                          Icons
                                                                              .check,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              kThemeColor,
                                                                        )
                                                                      : Container(),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      itemCount:
                                                          snapshot.data.length,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: TextFormField(
                                      controller: _propertyTypeController,
                                      style: appTextStyle(
                                        FontWeight.normal,
                                        14.0,
                                        kTextColor,
                                      ),
                                      cursorColor: kSecondary,
                                      enabled: false,
                                      focusNode: FocusNode(),
                                      decoration: InputDecoration(
                                        // labelText: 'Enter something',
                                        hintText: 'Select Property Type',
                                        hintStyle: appTextStyle(
                                          FontWeight.normal,
                                          14.0,
                                          kTextHintColor,
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.75,
                                            color: kBorderColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.75,
                                            color: kBorderColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: kSecondary,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            IconlyLight.arrow_down_2,
                                            color: kTextColorLight,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  beginOffset: Offset(0, 0.3),
                                  endOffset: Offset(0, 0),
                                  slideCurve: Curves.linearToEaseOut,
                                );
                              } else {
                                return Container();
                              }
                            }
                        }
                      },
                    ),

                    SizedBox(
                      height: 16.0,
                    ),

                    // Offer Type
                    Text(
                      'Offer Type',
                      style: appTextStyle(
                        FontWeight.normal,
                        16.0,
                        kTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    FutureBuilder(
                      future: _offerType, // async work
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container(
                              // color: Colors.white,
                              child: GFShimmer(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      // horizontal: 16,
                                      ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          // width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                          ),
                                          height: 46,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          default:
                            if (snapshot.hasError) {
                              return Container();
                            } else {
                              if (snapshot.data != null) {
                                return FadedSlideAnimation(
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          // context and builder are
                                          // required properties in this widget
                                          context: context,
                                          builder: (BuildContext context) {
                                            // we set up a container inside which
                                            // we create center column and display text
                                            return Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8.0,
                                                    ),
                                                    child: Text(
                                                      'Offer Type',
                                                      style: appTextStyle(
                                                        FontWeight.bold,
                                                        16.0,
                                                        Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: kDividerColor,
                                                  ),
                                                  Expanded(
                                                    child: ListView.builder(
                                                      // controller:
                                                      //     _scrollController,
                                                      shrinkWrap: true,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        // vertical: 16.0,
                                                      ),
                                                      // itemExtent: 80,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              _offerTypeController
                                                                      .text =
                                                                  snapshot.data[
                                                                          index]
                                                                      ['name'];

                                                              selectedOfferType =
                                                                  snapshot.data[
                                                                          index]
                                                                      ['id'];

                                                              print(
                                                                  "selectedOfferType = ${selectedOfferType}");
                                                            });

                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                          child: Card(
                                                            elevation: 0,
                                                            color: Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4,
                                                              ),
                                                            ),
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical: 16.0,
                                                                horizontal:
                                                                    16.0,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      snapshot.data[
                                                                              index]
                                                                          [
                                                                          'name'],
                                                                      style:
                                                                          appTextStyle(
                                                                        FontWeight
                                                                            .w500,
                                                                        14.0,
                                                                        kTextColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  selectedOfferType ==
                                                                          snapshot.data[index]
                                                                              [
                                                                              'id']
                                                                      ? Icon(
                                                                          Icons
                                                                              .check,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              kThemeColor,
                                                                        )
                                                                      : Container(),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      itemCount:
                                                          snapshot.data.length,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: TextFormField(
                                      controller: _offerTypeController,
                                      style: appTextStyle(
                                        FontWeight.normal,
                                        14.0,
                                        kTextColor,
                                      ),
                                      cursorColor: kSecondary,
                                      enabled: false,
                                      focusNode: FocusNode(),
                                      decoration: InputDecoration(
                                        // labelText: 'Enter something',
                                        hintText: 'Select Offer Type',
                                        hintStyle: appTextStyle(
                                          FontWeight.normal,
                                          14.0,
                                          kTextHintColor,
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.75,
                                            color: kBorderColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.75,
                                            color: kBorderColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: kSecondary,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            IconlyLight.arrow_down_2,
                                            color: kTextColorLight,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                      // keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  beginOffset: Offset(0, 0.3),
                                  endOffset: Offset(0, 0),
                                  slideCurve: Curves.linearToEaseOut,
                                );
                              } else {
                                return Container();
                              }
                            }
                        }
                      },
                    ),

                    SizedBox(
                      height: 16.0,
                    ),
                    // Offer Type
                    Text(
                      'Features',
                      style: appTextStyle(
                        FontWeight.normal,
                        16.0,
                        kTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    FutureBuilder(
                      future: _features, // async work
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container(
                              // color: Colors.white,
                              child: GFShimmer(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      // horizontal: 16,
                                      ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          // width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                          ),
                                          height: 46,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          default:
                            if (snapshot.hasError) {
                              return Container();
                            } else {
                              if (snapshot.data != null) {
                                return FadedSlideAnimation(
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          // context and builder are
                                          // required properties in this widget
                                          context: context,
                                          builder: (BuildContext context) {
                                            // we set up a container inside which
                                            // we create center column and display text
                                            return Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8.0,
                                                    ),
                                                    child: Text(
                                                      'Features',
                                                      style: appTextStyle(
                                                        FontWeight.bold,
                                                        16.0,
                                                        Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: kDividerColor,
                                                  ),
                                                  Expanded(
                                                    child: ListView.builder(
                                                      // controller:
                                                      //     _scrollController,
                                                      shrinkWrap: true,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        // vertical: 16.0,
                                                      ),
                                                      // itemExtent: 80,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedFeatures
                                                                  .add(
                                                                snapshot.data[
                                                                        index]
                                                                    ['name'],
                                                              );
                                                              selectedFeaturesId
                                                                  .add(
                                                                snapshot.data[
                                                                        index]
                                                                    ['id'],
                                                              );
                                                              _featuresController
                                                                      .text =
                                                                  selectedFeatures
                                                                      .join(
                                                                          ", ");

                                                              // selectedOfferType =
                                                              // snapshot.data[
                                                              //         index]
                                                              //     ['id'];

                                                              print(
                                                                  "selectedFeatures = ${selectedFeatures}");
                                                            });

                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                          child: Card(
                                                            elevation: 0,
                                                            color: Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4,
                                                              ),
                                                            ),
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical: 16.0,
                                                                horizontal:
                                                                    16.0,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      snapshot.data[
                                                                              index]
                                                                          [
                                                                          'name'],
                                                                      style:
                                                                          appTextStyle(
                                                                        FontWeight
                                                                            .w500,
                                                                        14.0,
                                                                        kTextColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  selectedFeaturesId.contains(
                                                                          snapshot.data[index]
                                                                              [
                                                                              'id'])
                                                                      ? Icon(
                                                                          Icons
                                                                              .check,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              kThemeColor,
                                                                        )
                                                                      : Container(),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      itemCount:
                                                          snapshot.data.length,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.0,
                                        horizontal: 16.0,
                                      ),
                                      // height: 40.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Select Features',
                                              style: appTextStyle(
                                                FontWeight.w500,
                                                16.0,
                                                Colors.grey[600]!,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            IconlyLight.plus,
                                            color: kTextColorLight,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  beginOffset: Offset(0, 0.3),
                                  endOffset: Offset(0, 0),
                                  slideCurve: Curves.linearToEaseOut,
                                );
                              } else {
                                return Container();
                              }
                            }
                        }
                      },
                    ),

                    selectedFeatures.length != 0
                        ? ListView.builder(
                            // controller:
                            //     _scrollController,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                // horizontal: 16.0,
                                // vertical: 16.0,
                                ),
                            // itemExtent: 80,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 0.25,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    4,
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 16.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          selectedFeatures[index],
                                          style: appTextStyle(
                                            FontWeight.w500,
                                            12.0,
                                            kTextColor,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedFeatures.removeAt(index);
                                          });
                                        },
                                        child: Icon(
                                          IconlyLight.close_square,
                                          size: 20,
                                          color: kRedColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: selectedFeatures.length,
                          )
                        : Container(),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
              Divider(
                color: kDividerColor,
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Street',
                      style: appTextStyle(
                        FontWeight.normal,
                        16.0,
                        kTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _streetController,
                      style: appTextStyle(
                        FontWeight.normal,
                        14.0,
                        kTextColor,
                      ),
                      cursorColor: kSecondary,
                      enabled: true,
                      focusNode: FocusNode(),
                      decoration: InputDecoration(
                        // labelText: 'Enter something',
                        hintText: 'Select Street',
                        hintStyle: appTextStyle(
                          FontWeight.normal,
                          14.0,
                          kTextHintColor,
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.75,
                            color: kBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.75,
                            color: kBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kSecondary,
                          ),
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            IconlyLight.arrow_down_2,
                            color: kTextColorLight,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'Neighborhood',
                      style: appTextStyle(
                        FontWeight.normal,
                        16.0,
                        kTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FutureBuilder(
                      future: _neighborhood, // async work
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container(
                              // color: Colors.white,
                              child: GFShimmer(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      // horizontal: 16,
                                      ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          // width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                          ),
                                          height: 46,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          default:
                            if (snapshot.hasError) {
                              return Container();
                            } else {
                              if (snapshot.data != null) {
                                return FadedSlideAnimation(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: TextFormField(
                                      controller: _neighborhoodController,
                                      style: appTextStyle(
                                        FontWeight.normal,
                                        14.0,
                                        kTextColor,
                                      ),
                                      cursorColor: kSecondary,
                                      enabled: true,
                                      focusNode: FocusNode(),
                                      decoration: InputDecoration(
                                        // labelText: 'Enter something',
                                        hintText: 'Select Neighborhood',
                                        hintStyle: appTextStyle(
                                          FontWeight.normal,
                                          14.0,
                                          kTextHintColor,
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.75,
                                            color: kBorderColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.75,
                                            color: kBorderColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: kSecondary,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            IconlyBold.arrow_down_circle,
                                            color: kTextColorLight,
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 16.0,
                                                            vertical: 8.0,
                                                          ),
                                                          child: Text(
                                                            'Neighborhood',
                                                            style: appTextStyle(
                                                              FontWeight.bold,
                                                              16.0,
                                                              Colors.black87,
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(
                                                          color: kDividerColor,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              ListView.builder(
                                                            // controller:
                                                            //     _scrollController,
                                                            shrinkWrap: true,
                                                            physics:
                                                                BouncingScrollPhysics(),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal: 16.0,
                                                              // vertical: 16.0,
                                                            ),
                                                            // itemExtent: 80,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  setState(
                                                                    () {
                                                                      _neighborhoodController
                                                                          .text = snapshot
                                                                              .data[index]
                                                                          [
                                                                          'name'];

                                                                      selectedNeighborhood =
                                                                          snapshot.data[index]
                                                                              [
                                                                              'id'];

                                                                      print(
                                                                          "selectedNeighborhood = $selectedNeighborhood");
                                                                    },
                                                                  );

                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                },
                                                                child: Card(
                                                                  elevation: 0,
                                                                  color: Colors
                                                                      .white,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      4,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      vertical:
                                                                          16.0,
                                                                      horizontal:
                                                                          16.0,
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            snapshot.data[index]['name'],
                                                                            style:
                                                                                appTextStyle(
                                                                              FontWeight.w500,
                                                                              14.0,
                                                                              kTextColor,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        selectedNeighborhood ==
                                                                                snapshot.data[index]['id']
                                                                            ? Icon(
                                                                                Icons.check,
                                                                                size: 18,
                                                                                color: kThemeColor,
                                                                              )
                                                                            : Container(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            itemCount: snapshot
                                                                .data.length,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  beginOffset: Offset(0, 0.3),
                                  endOffset: Offset(0, 0),
                                  slideCurve: Curves.linearToEaseOut,
                                );
                              } else {
                                return Container();
                              }
                            }
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'City',
                      style: appTextStyle(
                        FontWeight.normal,
                        16.0,
                        kTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FutureBuilder(
                      future: _city, // async work
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container(
                              // color: Colors.white,
                              child: GFShimmer(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      // horizontal: 16,
                                      ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          // width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                          ),
                                          height: 46,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          default:
                            if (snapshot.hasError) {
                              return Container();
                            } else {
                              if (snapshot.data != null) {
                                return FadedSlideAnimation(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: TextFormField(
                                      controller: _cityController,
                                      style: appTextStyle(
                                        FontWeight.normal,
                                        14.0,
                                        kTextColor,
                                      ),
                                      cursorColor: kSecondary,
                                      enabled: true,
                                      focusNode: FocusNode(),
                                      decoration: InputDecoration(
                                        // labelText: 'Enter something',
                                        hintText: 'Select City',
                                        hintStyle: appTextStyle(
                                          FontWeight.normal,
                                          14.0,
                                          kTextHintColor,
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.75,
                                            color: kBorderColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.75,
                                            color: kBorderColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: kSecondary,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            IconlyBold.arrow_down_circle,
                                            color: kTextColorLight,
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                              // context and builder are
                                              // required properties in this widget
                                              context: context,
                                              builder: (BuildContext context) {
                                                // we set up a container inside which
                                                // we create center column and display text
                                                return Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 16.0,
                                                          vertical: 8.0,
                                                        ),
                                                        child: Text(
                                                          'Cities',
                                                          style: appTextStyle(
                                                            FontWeight.bold,
                                                            16.0,
                                                            Colors.black87,
                                                          ),
                                                        ),
                                                      ),
                                                      Divider(
                                                        color: kDividerColor,
                                                      ),
                                                      Expanded(
                                                        child: ListView.builder(
                                                          // controller:
                                                          //     _scrollController,
                                                          shrinkWrap: true,
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 16.0,
                                                            // vertical: 16.0,
                                                          ),
                                                          // itemExtent: 80,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  _cityController
                                                                      .text = snapshot
                                                                              .data[
                                                                          index]
                                                                      ['name'];

                                                                  selectedCity =
                                                                      snapshot.data[
                                                                              index]
                                                                          [
                                                                          'id'];

                                                                  print(
                                                                      "selectedCity = $selectedCity");
                                                                });

                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              child: Card(
                                                                elevation: 0,
                                                                color: Colors
                                                                    .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    4,
                                                                  ),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        16.0,
                                                                    horizontal:
                                                                        16.0,
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          snapshot.data[index]
                                                                              [
                                                                              'name'],
                                                                          style:
                                                                              appTextStyle(
                                                                            FontWeight.w500,
                                                                            14.0,
                                                                            kTextColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      selectedCity ==
                                                                              snapshot.data[index]['id']
                                                                          ? Icon(
                                                                              Icons.check,
                                                                              size: 18,
                                                                              color: kThemeColor,
                                                                            )
                                                                          : Container(),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          itemCount: snapshot
                                                              .data.length,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  beginOffset: Offset(0, 0.3),
                                  endOffset: Offset(0, 0),
                                  slideCurve: Curves.linearToEaseOut,
                                );
                              } else {
                                return Container();
                              }
                            }
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),

              Divider(
                color: kDividerColor,
              ),

              // Gallery
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Featured Media',
                      style: appTextStyle(
                        FontWeight.w500,
                        16.0,
                        kTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    _image != null
                        ? GestureDetector(
                            onTap: () {
                              _imgFromGallery();
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  width: double.infinity,
                                  child: ClipRect(
                                    child: Image.file(
                                      File(_image!.path),
                                      width: double.infinity,
                                      height: 100.0,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: GFButton(
                                    onPressed: () async {
                                      isFeaturedMediaSaved =
                                          !isFeaturedMediaSaved;
                                      toastMeaasge(
                                        'Uploading feature media.....',
                                        kGreenColor,
                                        context,
                                      );
                                      var userId =
                                          await UserPreferences.getUserId();

                                      print(userId);
                                      print('Image Path = ${_image!.path}');

                                      var headers = {
                                        'Authorization':
                                            'Basic YWRtaW46bGlnaHR3ZWJncm91cC5jb20xMDAw'
                                      };
                                      var request = http.MultipartRequest(
                                          'POST',
                                          Uri.parse(
                                              'https://gharjhagga.com/wp-json/wp/v2/media'));
                                      request.fields.addAll({
                                        'author': '$userId',
                                        'media_type': 'image',
                                        'title': 'dasfdas',
                                        'alt_text': 'featured_media'
                                      });
                                      request.files.add(
                                          await http.MultipartFile.fromPath(
                                              'file', _image!.path));
                                      request.headers.addAll(headers);

                                      http.StreamedResponse response =
                                          await request.send();
                                      print(response.statusCode);

                                      if (response.statusCode >= 200 &&
                                          response.statusCode <= 299) {
                                        var res = (await response.stream
                                            .bytesToString());
                                        var resJSON = json.decode(res);

                                        setState(() {
                                          isFeaturedMediaSaved = true;
                                          selectedFeaturedMediaId =
                                              resJSON['id'];
                                        });
                                        print(selectedFeaturedMediaId);
                                        toastMeaasge(
                                          'Image has been saved.',
                                          kGreenColor,
                                          context,
                                        );
                                      } else {
                                        print(response.reasonPhrase);
                                      }
                                    },
                                    text:
                                        isFeaturedMediaSaved ? 'Saved' : 'Save',
                                    textStyle: appTextStyle(
                                      FontWeight.w500,
                                      15.0,
                                      Colors.white,
                                    ),
                                    icon: Icon(
                                      Icons.save,
                                      size: 16.0,
                                    ),
                                    shape: GFButtonShape.pills,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              _imgFromGallery();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              width: double.infinity,
                              height: 200.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[200],
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Click to select photo',
                                    style: appTextStyle(
                                      FontWeight.w500,
                                      16.0,
                                      Colors.grey[200]!,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),

              SizedBox(
                height: 16.0,
              ),

              // Gallery
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gallery',
                      style: appTextStyle(
                        FontWeight.w500,
                        16.0,
                        kTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    GFButton(
                      onPressed: () {
                        _galleryPicker();
                      },
                      size: GFSize.LARGE,
                      text: "Add Image",
                      textStyle: appTextStyle(
                        FontWeight.w500,
                        16.0,
                        Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      icon: Icon(
                        IconlyLight.plus,
                      ),
                      shape: GFButtonShape.pills,
                      color: kBorderColor,
                    ),
                    _imgGallery.length != 0
                        ? Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text('Selected Images',
                                    style: appTextStyle(
                                        FontWeight.w500, 16.0, kTextColor)),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 2,
                                  height: 220.0,
                                ),
                                itemCount: _imgGallery.length,
                                itemBuilder: (BuildContext context, int index) {
                                  //print("address $address");

                                  //print(imgURL);
                                  return InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                top: 8.0,
                                                bottom: 4.0,
                                                right: 8.0,
                                                left: 8.0,
                                              ),
                                              child: Container(
                                                height: 200,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: kButtonBg,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(12),
                                                  ),
                                                  image: DecorationImage(
                                                    alignment:
                                                        Alignment(-.2, 0),
                                                    image: FileImage(
                                                      _imgGallery[index],
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              // left: 0,
                                              top: 0,
                                              right: 0,

                                              child: GestureDetector(
                                                onTap: (() {
                                                  setState(() {
                                                    _imgGallery.removeAt(index);
                                                  });
                                                }),
                                                child: CircleAvatar(
                                                  backgroundColor: kThemeColor,
                                                  radius: 12,
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    size: 18.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ); //return Container();
                                },
                              )
                            ],
                          )
                        : Container(),
                    _imgGallery.length != 0
                        ? GFButton(
                            fullWidthButton: true,
                            onPressed: !isGallerySaved
                                ? () {
                                    _uploadGallery();
                                  }
                                : null,
                            size: GFSize.LARGE,
                            text: "Save Gallery",
                            textStyle: appTextStyle(
                              FontWeight.w500,
                              16.0,
                              Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            icon: Icon(
                              IconlyLight.tick_square,
                            ),
                            shape: GFButtonShape.pills,
                            color: kBorderColor,
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 20.0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      kThemeColor,
                    ),
                  ),
                  child: Text(
                    'Add Property',
                    style: appTextStyle(
                      FontWeight.w500,
                      16.0,
                      Colors.white,
                    ),
                  ),
                  onPressed: () {
                    print('Pressed');
                    FocusScope.of(context).requestFocus(new FocusNode());
                    addProperty();

                    // Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MainScreen(),
                    //   ),
                    // );
                    // userLogin();
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }

  Future<void> addProperty() async {
    var userId = await UserPreferences.getUserId();
    final snackBar = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              'Submitting new property.....',
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

    var headers = {
      'Authorization': 'Basic YWRtaW46bGlnaHR3ZWJncm91cC5jb20xMDAw'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://gharjhagga.com/wp-json/wp/v2/estate'));
    request.fields.addAll({
      'title': _titleController.text.trim().toString(),
      'content': _descriptionController.text.trim().toString(),
      'author': '$userId',
      'featured_media': '$selectedFeaturedMediaId',
      'property-type': '$selectedPropertyType',
      'offer-type': '$selectedOfferType',
      'city': '$selectedCity',
      'neighborhood': '$selectedNeighborhood',
      // 'street': '174',
      // 'features': selectedFeatures,
      // 'features[]': '21',
      // 'features[]': '50',
      // 'price': '100000',
      // 'bedrooms': '2',
      // '_estate_attr_bathrooms': '2',
      // 'estate_gallery': _imgGalleryId,
      // 'estate_gallery[]': '3553',
      // 'estate_gallery[]': '3562',
      'status': 'draft',
    });

    // request.fields['estate_gallery[0]'] = selectedFeaturedMediaId.toString();
    // for (int a = 0; a < _imgGallery.length; a++) {
    //   request.fields.addAll({'estate_gallery[${a + 1}]': _imgGalleryId[a]});
    // }

    // print(selectedFeaturesId);

    for (int b = 0; b < selectedFeaturesId.length; b++) {
      print('F$b = ${selectedFeaturesId[b]}');
      request.fields['features[$b]'] = selectedFeaturesId[b].toString();
    }
    request.headers.addAll(headers);

    print(request.fields);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      snackBar.close();
      toastMeaasge(
          'New Property has been added. The property will visible after admin approval.',
          kGreenColor,
          context,);
      print(await response.stream.bytesToString());
    } else {
      snackBar.close();
      print(await response.stream.bytesToString());
      print(response.reasonPhrase);
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }
}
