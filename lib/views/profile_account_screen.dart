import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharjagga/functions/functions.dart';
import 'package:gharjagga/utlis/userpreferences.dart';
import 'dart:core';
import 'package:iconly/iconly.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:recase/recase.dart';
import 'package:http/http.dart' as http;

class AccountScreen extends StatefulWidget {
  // final Color _primaryColor;
  // final Color _secondaryColor;

  // AccountScreen(this._primaryColor, this._secondaryColor);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String userName = '';
  String userAvatar = '';
  String userRole = '';
  String userFullName = '';
  String userEmail = '';
  String userFirstName = '';
  String userLastName = '';

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    init();

    super.initState();

    // _firstNameController.dispose();
    // _lastNameController.dispose();
    // _emailController.dispose();
  }

  init() async {
    var avatarURL = await UserPreferences.getUserAvatar();
    var role = await UserPreferences.getUserRole();
    var fullName = await UserPreferences.getName();
    var email = await UserPreferences.getUserEmail();
    var firstName = await UserPreferences.getUserFirstName();
    var lastName = await UserPreferences.getUserLastName();
    var username = await UserPreferences.getUsername();

    setState(() {
      userRole = role!;
      userFullName = fullName!;
      userEmail = email!;
      userAvatar = avatarURL!;
      userFirstName = firstName!;
      userLastName = lastName!;
      userName = username!;
      _firstNameController.text = userFirstName;
      _lastNameController.text = userLastName;
      _emailController.text = userEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: kThemeColor,
        title: Text(
          'My Account',
          style: appTextStyle(
            FontWeight.bold,
            20.0,
            Colors.white,
          ),
        ),
        actions: [
          !isEditing
              ? IconButton(
                  icon: Icon(
                    IconlyLight.edit_square,
                  ),
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                )
              : Container(),
          // isEditing
          //     ? IconButton(
          //         icon: Icon(
          //           IconlyBroken.tick_square,
          //         ),
          //         onPressed: () {
          //           setState(() {
          //             isEditing = !isEditing;
          //           });
          //         },
          //       )
          //     : Container(),
        ],
      ),
      key: _scaffoldKey,
      body: FadedSlideAnimation(
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        // child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 16.0,
              ),
              // CircleAvatar(
              //   radius: 40.0,
              //   backgroundImage: NetworkImage(
              //     userAvatar,
              //   ),
              // ),
              userAvatar.isNotEmpty
                  ? FutureBuilder(
                      future: imageURLCheck(userAvatar),
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          if (asyncSnapshot.data != null) {
                            return Container(
                              // color: Colors.black,
                              // width: 200,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: kThemeColor,
                                child: CircleAvatar(
                                  radius: 39,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                    userAvatar,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              // color: Colors.black,
                              // width: 200,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                  "assets/images/user_d.png",
                                ),
                              ),
                            );
                          }
                        } else {
                          return Container(
                            // color: Colors.black,
                            // width: 200,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: kThemeColor,
                              child: CircleAvatar(
                                radius: 39,
                                backgroundColor: Colors.white,
                                // backgroundImage: AssetImage(
                                //   "assets/images/user_d.png",
                                // ),
                                child: CupertinoActivityIndicator(),
                              ),
                            ),
                          );
                        }
                      },
                    )
                  : Container(
                      // color: Colors.black,
                      // width: 200,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                          "assets/images/user_d.png",
                        ),
                      ),
                    ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                userName,
                style: appTextStyleWLS(
                  FontWeight.w500,
                  16.0,
                  kTextColor,
                ),
              ),
              Text(
                userRole.titleCase,
                style: appTextStyleWLS(
                  FontWeight.normal,
                  12.0,
                  kTextColor,
                ),
              ),

              Divider(
                color: kDividerColor,
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'First Name',
                            style: appTextStyle(
                              FontWeight.w500,
                              16.0,
                              kTextColor,
                            ),
                            // children: <TextSpan>[
                            //   TextSpan(
                            //     text: "*",
                            //     style: appTextStyle(
                            //       FontWeight.bold,
                            //       16,
                            //       Colors.red,
                            //     ),
                            //   ),
                            // ],
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        isEditing
                            ? TextFormField(
                                controller: _firstNameController,
                                style: appTextStyle(
                                  FontWeight.normal,
                                  14.0,
                                  kTextColor,
                                ),
                                cursorColor: kSecondary,
                                decoration: InputDecoration(
                                  // labelText: 'Enter something',
                                  hintText: 'Enter your first name',
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
                                keyboardType: TextInputType.name,
                              )
                            : Text(
                                userFirstName,
                                style: appTextStyle(
                                  FontWeight.normal,
                                  14.0,
                                  kTextColor,
                                ),
                              ),
                        SizedBox(
                          height: 16.0,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Last Name',
                            style: appTextStyle(
                              FontWeight.w500,
                              16.0,
                              kTextColor,
                            ),
                            // children: <TextSpan>[
                            //   TextSpan(
                            //     text: "*",
                            //     style: appTextStyle(
                            //       FontWeight.bold,
                            //       16,
                            //       Colors.red,
                            //     ),
                            //   ),
                            // ],
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        isEditing
                            ? TextFormField(
                                controller: _lastNameController,
                                style: appTextStyle(
                                  FontWeight.normal,
                                  14.0,
                                  kTextColor,
                                ),
                                cursorColor: kSecondary,
                                decoration: InputDecoration(
                                  // labelText: 'Enter something',
                                  hintText: 'Enter your last name',
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

                                  // suffix: GestureDetector(
                                  //   child: Icon(Icons.remove_red_eye_rounded),
                                  //   onTap: (() {}),
                                  // ),
                                ),
                                // obscureText: !showPassword,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                              )
                            : Text(
                                userLastName,
                                style: appTextStyle(
                                  FontWeight.normal,
                                  14.0,
                                  kTextColor,
                                ),
                              ),
                        SizedBox(
                          height: 16.0,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Email Address',
                            style: appTextStyle(
                              FontWeight.w500,
                              16.0,
                              kTextColor,
                            ),
                            // children: <TextSpan>[
                            //   TextSpan(
                            //     text: "*",
                            //     style: appTextStyle(
                            //       FontWeight.bold,
                            //       16,
                            //       Colors.red,
                            //     ),
                            //   ),
                            // ],
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        isEditing
                            ? TextFormField(
                                controller: _emailController,
                                style: appTextStyle(
                                  FontWeight.normal,
                                  14.0,
                                  kTextColor,
                                ),
                                cursorColor: kSecondary,
                                decoration: InputDecoration(
                                  // labelText: 'Enter something',
                                  hintText: 'Enter your email address',
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

                                  // suffix: GestureDetector(
                                  //   child: Icon(Icons.remove_red_eye_rounded),
                                  //   onTap: (() {}),
                                  // ),
                                ),
                                // obscureText: !showPassword,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.name,
                              )
                            : Text(
                                userEmail,
                                style: appTextStyle(
                                  FontWeight.normal,
                                  14.0,
                                  kTextColor,
                                ),
                              ),
                        SizedBox(
                          height: 32.0,
                        ),
                        isEditing
                            ? Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 16.0),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                      kButtonBg,
                                    ),
                                  ),
                                  child: Text(
                                    'Update',
                                    style: appTextStyle(
                                      FontWeight.w500,
                                      16.0,
                                      Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    print('Pressed');
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());

                                    _userUpdate();

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
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  _userUpdate() async {
    var token = await UserPreferences.getToken();
    print(token);

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(
      _emailController.text.trim().toString(),
    );

    if (emailValid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    // color: Colors.black,
                    child: Image.asset('assets/icons/logo.png'),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  flex: 12,
                  child: Text(
                    'Gharjagga',
                    style: appTextStyle(
                      FontWeight.bold,
                      18.0,
                      Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            content: TextFormField(
              controller: _passwordController,
              style: appTextStyle(
                FontWeight.normal,
                14.0,
                kTextColor,
              ),
              cursorColor: kSecondary,
              decoration: InputDecoration(
                // labelText: 'Enter something',
                hintText: 'Please enter your password',
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
              obscureText: true,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.name,
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text(
                  'Cancel',
                  style: appTextStyle(
                    FontWeight.w500,
                    14.0,
                    Colors.black54,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _passwordController.text = '';
                },
              ),
              new TextButton(
                child: new Text(
                  'Confirm',
                  style: appTextStyleWLS(
                    FontWeight.w500,
                    14.0,
                    Colors.black54,
                  ),
                ),
                onPressed: () async {
                  // Navigator.of(context).pop();
                  FocusScope.of(context).requestFocus(new FocusNode());
                  var password = _passwordController.text.trim().toString();

                  var token = await UserPreferences.getToken();
                  var hashedPassword =
                      base64Encode(utf8.encode('$userName:$password'));

                  if (token == hashedPassword) {
                    print('update');
                    Navigator.of(context).pop();
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
                              'Updating profile.....',
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
                      'Authorization': 'Basic eW9nOTgyNzg6TmVwYWxAMTIz'
                    };
                    var request = http.MultipartRequest(
                        'POST',
                        Uri.parse(
                            'https://gharjhagga.com/wp-json/wp/v2/users/me?context=edit'));
                    request.fields.addAll({
                      'first_name': _firstNameController.text.trim().toString(),
                      'name':
                          '${_firstNameController.text.trim().toString()} ${_lastNameController.text.trim().toString()}',
                      'last_name': _lastNameController.text.trim().toString(),
                      'email': _emailController.text.trim().toString()
                    });

                    request.headers.addAll(headers);

                    print(request.fields);

                    http.StreamedResponse response = await request.send();

                    var responseString = await response.stream.bytesToString();

                    print(responseString);

                    var jsonResponse = json.decode(responseString);

                    if (!jsonResponse.containsKey('code')) {
                      snackBar.close();
                      // toastMeaasge(
                      //   'Profile Updated Successfully.',
                      //   kGreenColor,
                      //   context,
                      // );
                      setState(() {
                        isEditing = !isEditing;
                        userFirstName = _firstNameController.text.toString();
                        userLastName = _lastNameController.text.toString();
                        userEmail = _emailController.text.toString();
                        UserPreferences.setName(
                            "${_firstNameController.text.toString()} ${_lastNameController.text.toString()}");
                        UserPreferences.setUserFirstName(
                          _firstNameController.text.toString(),
                        );
                        UserPreferences.setUserLastName(
                          _lastNameController.text.toString(),
                        );
                        UserPreferences.setUserEmail(
                          _emailController.text.toString(),
                        );
                      });
                      print(responseString);
                    } else {
                      snackBar.close();
                      if (jsonResponse['code'] == 'rest_user_invalid_email') {
                        print(jsonResponse['message']);
                        toastMeaasge(
                            jsonResponse['message'], kRedColor, context);
                      } else {
                        toastMeaasge('Invalid data.', kRedColor, context);
                      }
                    }
                  } else {
                    toastMeaasge('Invalid Password.', kRedColor, context);
                  }
                },
              ),
            ],
          );
        },
      );
    } else {
      toastMeaasge('Invalid Email Address.', kRedColor, context);
    }
  }
}
