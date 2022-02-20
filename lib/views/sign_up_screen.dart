import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:gharjagga/views/sign_in_screen.dart';
import 'package:http/http.dart' as http;
import 'package:recase/recase.dart';
import 'package:iconly/iconly.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showPassword = false;
  String dropdownValue = 'customer';

  TextEditingController _role = TextEditingController();
  TextEditingController _emailId = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _userName = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: theme.backgroundColor,

        key: _scaffoldKey,
        // appBar: AppBar(),
        body: FadedSlideAnimation(
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: Column(
            children: [
              SizedBox(
                height: 60.0,
              ),
              Row(
                children: [
                  Container(
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
                      horizontal: 16,
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
                        Icons.chevron_left_rounded,
                        size: 28.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 32.0,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 32.0,
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Create your account',
                              style: appTextStyle(
                                FontWeight.bold,
                                22.0,
                                kTextColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Please enter your data to create account',
                            style: appTextStyle(
                              FontWeight.normal,
                              16,
                              kTextColorLight,
                            ),
                          ),
                          SizedBox(
                            height: 28.0,
                          ),
                          // Text(
                          //   'Email or Phone Number',
                          //   style: appTextStyle(
                          //     FontWeight.bold,
                          //     16,
                          //     kTextColorLight,
                          //   ),
                          // ),
                          RichText(
                            text: TextSpan(
                              text: 'User name',
                              style: appTextStyle(
                                FontWeight.w500,
                                16.0,
                                kTextColor,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "*",
                                  style: appTextStyle(
                                    FontWeight.bold,
                                    16,
                                    Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            controller: _userName,
                            style: appTextStyle(
                              FontWeight.normal,
                              14.0,
                              kTextColor,
                            ),
                            cursorColor: kSecondary,
                            decoration: InputDecoration(
                              // labelText: 'Enter something',
                              hintText: 'Enter your username',
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
                          ),
                          SizedBox(
                            height: 28.0,
                          ),
                          // Text(
                          //   'Email or Phone Number',
                          //   style: appTextStyle(
                          //     FontWeight.bold,
                          //     16,
                          //     kTextColorLight,
                          //   ),
                          // ),
                          RichText(
                            text: TextSpan(
                              text: 'Role',
                              style: appTextStyle(
                                FontWeight.w500,
                                16.0,
                                kTextColor,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "*",
                                  style: appTextStyle(
                                    FontWeight.bold,
                                    16,
                                    Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(
                              IconlyLight.arrow_down_2,
                              size: 20,
                            ),
                            iconSize: 20,
                            elevation: 1,
                            isExpanded: true,
                            underline: Container(
                              height: 1,
                              color: kBorderColor,
                            ),
                            onChanged: (newValue) {
                              print(newValue);
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['customer', 'agent']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                  child: Text(
                                    value.toString().titleCase,
                                    style: appTextStyle(
                                      FontWeight.normal,
                                      14.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),

                          RichText(
                            text: TextSpan(
                              text: 'Email',
                              style: appTextStyle(
                                FontWeight.w500,
                                16.0,
                                kTextColor,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "*",
                                  style: appTextStyle(
                                    FontWeight.bold,
                                    16,
                                    Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            controller: _emailId,
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
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Password',
                              style: appTextStyle(
                                FontWeight.w500,
                                16.0,
                                kTextColor,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "*",
                                  style: appTextStyle(
                                    FontWeight.bold,
                                    16,
                                    Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            controller: _password,
                            style: appTextStyle(
                              FontWeight.normal,
                              14.0,
                              kTextColor,
                            ),
                            cursorColor: kSecondary,
                            decoration: InputDecoration(
                              // labelText: 'Enter something',
                              hintText: 'Enter your password',
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
                            obscureText: !showPassword,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Checkbox(
                                      value: this.showPassword,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          this.showPassword = value!;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Show Password',
                                      style: appTextStyle(
                                        FontWeight.w400,
                                        14.0,
                                        kTextHintColor,
                                      ),
                                    ),
                                    SizedBox(width: 0),
                                  ],
                                ),
                              ),
                              // Expanded(
                              //   child: Align(
                              //     alignment: Alignment.centerRight,
                              //     child: TextButton(
                              //       onPressed: () {},
                              //       child: Text(
                              //         'Forgot Password?',
                              //         style: appTextStyle(
                              //           FontWeight.w400,
                              //           14.0,
                              //           kTextColorLight,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 32.0,
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(vertical: 20.0),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  kButtonBg,
                                ),
                              ),
                              child: Text(
                                'Continue',
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
                                registrationUser();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: kDividerColor,
                                ),
                              ),
                              Container(
                                width: 32.0,
                                child: Text(
                                  'or',
                                  style: appTextStyle(
                                    FontWeight.bold,
                                    14.0,
                                    kTextColorLight,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: kDividerColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          Container(
                            width: double.infinity,
                            child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(vertical: 20.0),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.white,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Image.asset(
                                    'assets/icons/google.png',
                                    height: 25,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Sign Up with Google',
                                      style: appTextStyle(
                                        FontWeight.w500,
                                        16.0,
                                        kTextColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 28.0,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                print('Pressed');
                                FocusScope.of(context).requestFocus(
                                  new FocusNode(),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 32.0,
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Already have an account? ',
                                style: appTextStyle(
                                  FontWeight.w500,
                                  16.0,
                                  kTextColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Log In",
                                    style: appTextStyle(
                                      FontWeight.w500,
                                      16,
                                      kSecondary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = (() {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SignInScreen(),
                                          ),
                                        );
                                      }),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registrationUser() async {
    var username = _userName.text.toString().trim();
    var email = _emailId.text.toString().trim();
    var password = _password.text.toString().trim();

    // print("username = $username");
    // print("email = $email");
    // print("password = $password");
    if (username.isEmpty) {
      toastMeaasge('Empty Username.', kRedColor, context);
    } else {
      if (email.isEmpty) {
        toastMeaasge('Empty email address.', kRedColor, context);
      } else {
        if (password.isEmpty) {
          toastMeaasge('Empty password.', kRedColor, context);
        } else {
          // print('New');

          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(email);

          print(emailValid);

          if (emailValid) {
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
                      'Creating New Account.....',
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
            var request = http.MultipartRequest('POST',
                Uri.parse('https://gharjhagga.com/wp-json/wp/v2/users'));
            request.fields.addAll({
              'username': _userName.text,
              'email': _emailId.text,
              'roles': dropdownValue,
              'password': _password.text,
            });

            request.headers.addAll(headers);

            http.StreamedResponse response = await request.send();

            // print(await response.stream.bytesToString());

            var streamData = await response.stream.bytesToString();
            var jsonResponse = json.decode(streamData);
            print(jsonResponse);
            if (!jsonResponse.containsKey('code')) {
              snackBar.close();
              toastMeaasge('User created successfully.', kGreenColor, context);
              await Future.delayed(const Duration(seconds: 3), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              });
            } else {
              snackBar.close();
              toastMeaasge(jsonResponse['message'], kRedColor, context);
            }
          } else {
            toastMeaasge('Invalid email address.', kRedColor, context);
          }
        }
      }
    }
  }
}
