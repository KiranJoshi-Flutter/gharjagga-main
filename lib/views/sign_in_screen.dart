import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
// import 'package:gharjagga/screens/home_screen.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:gharjagga/utlis/userpreferences.dart';
import 'package:gharjagga/views/main_screen.dart';
import 'package:gharjagga/views/sign_up_screen.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  bool showPassword = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
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
              //         horizontal: 16,
              //       ),
              //       padding: EdgeInsets.symmetric(
              //         horizontal: 8,
              //         vertical: 8.0,
              //       ),
              //       // color: Colors.white,
              //       child: Icon(
              //         Icons.chevron_left_rounded,
              //         size: 28.0,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 48.0,
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
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Welcome to ',
                              style: appTextStyle(
                                FontWeight.bold,
                                22.0,
                                kTextColor,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "$kAppName.",
                                  style: appTextStyle(
                                    FontWeight.bold,
                                    22,
                                    kSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Enter your registered email address or phone number to log in',
                            style: appTextStyle(
                              FontWeight.normal,
                              16,
                              kTextColorLight,
                            ),
                          ),
                          SizedBox(
                            height: 28.0,
                          ),
                          Text(
                            'Username or Email address',
                            style: appTextStyle(
                              FontWeight.bold,
                              16,
                              kTextColorLight,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            controller: _usernameController,
                            style: appTextStyle(
                              FontWeight.normal,
                              14.0,
                              kTextColor,
                            ),
                            cursorColor: kSecondary,
                            decoration: InputDecoration(
                              // labelText: 'Enter something',
                              hintText: 'Enter your username or email address',
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
                          Text(
                            'Password',
                            style: appTextStyle(
                              FontWeight.bold,
                              16,
                              kTextColorLight,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            controller: _passwordController,
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
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Forgot Password?',
                                      style: appTextStyle(
                                        FontWeight.w400,
                                        14.0,
                                        kTextColorLight,
                                      ),
                                    ),
                                  ),
                                ),
                              )
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
                                'Log In',
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

                                // Navigator.pop(context);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => MainScreen(),
                                //   ),
                                // );
                                userLogin();
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
                              // Container(
                              //   width: 32.0,
                              //   child: Text(
                              //     'or',
                              //     style: appTextStyle(
                              //       FontWeight.bold,
                              //       14.0,
                              //       kTextColorLight,
                              //     ),
                              //     textAlign: TextAlign.center,
                              //   ),
                              // ),
                              // Expanded(
                              //   child: Divider(
                              //     color: kDividerColor,
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          // Container(
                          //   width: double.infinity,
                          //   child: TextButton(
                          //     style: ButtonStyle(
                          //       padding: MaterialStateProperty.all(
                          //         EdgeInsets.symmetric(vertical: 20.0),
                          //       ),
                          //       shape: MaterialStateProperty.all<
                          //           RoundedRectangleBorder>(
                          //         RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(16.0),
                          //         ),
                          //       ),
                          //       backgroundColor: MaterialStateProperty.all(
                          //         Colors.white,
                          //       ),
                          //     ),
                          //     child: Row(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         SizedBox(
                          //           width: 16.0,
                          //         ),
                          //         Image.asset(
                          //           'assets/icons/google.png',
                          //           height: 25,
                          //         ),
                          //         Expanded(
                          //           child: Text(
                          //             'Log In with Google',
                          //             style: appTextStyle(
                          //               FontWeight.w500,
                          //               16.0,
                          //               kTextColor,
                          //             ),
                          //             textAlign: TextAlign.center,
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           width: 28.0,
                          //         ),
                          //       ],
                          //     ),
                          //     onPressed: () {
                          //       print('Pressed');
                          //       FocusScope.of(context).requestFocus(
                          //         new FocusNode(),
                          //       );
                          //     },
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 32.0,
                          // ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Don’t have an account? ',
                                style: appTextStyle(
                                  FontWeight.w500,
                                  16.0,
                                  kTextColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Sign Up",
                                    style: appTextStyle(
                                      FontWeight.w500,
                                      16,
                                      kSecondary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print("Sign Up Screen");
                                        // Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen(),
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       'Don’t have an account? ',
                          //       style: appTextStyle(
                          //         FontWeight.w500,
                          //         16.0,
                          //         kTextColor,
                          //       ),
                          //     ),
                          //     GestureDetector(
                          //       onTap: (() {
                          //         print("object");
                          //       }),
                          //       child: Text(
                          //         "Sign Up",
                          //         style: appTextStyle(
                          //           FontWeight.w500,
                          //           16,
                          //           kSecondary,
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // )
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

  userLogin() async {
    var username = _usernameController.text.toString().trim();
    var password = _passwordController.text.toString().trim();

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
              'Logging In.....',
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

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("basicAuth $basicAuth");

    var response = await http.get(
      Uri.parse('https://gharjhagga.com/wp-json/wp/v2/users/me?context=edit'),
      headers: <String, String>{'Authorization': basicAuth},
      // body: {'name': 'doodle', 'color': 'blue'},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var jsonResponse = json.decode(response.body);

    if (!jsonResponse.containsKey('code')) {
      snackBar.close();
      UserPreferences.setToken(
          base64Encode(utf8.encode('$username:$password')));
      UserPreferences.setLoginStatus(true);
      UserPreferences.setUsername(username);
      UserPreferences.setName(jsonResponse['name']);
      UserPreferences.setUserFirstName(jsonResponse['first_name']);
      UserPreferences.setUserLastName(jsonResponse['last_name']);
      UserPreferences.setUserId(jsonResponse['id'].toString());
      UserPreferences.setUserAvatar(jsonResponse['avatar_urls']['96']);
      UserPreferences.setUserEmail(jsonResponse['email']);
      UserPreferences.setUserRole(jsonResponse['roles'].first);

      print(jsonResponse['roles'].first);

      toastMeaasge('Logged In successfully.', kGreenColor, context);
      await Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop();
        // UserPreferences.logout();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
          ModalRoute.withName('/'),
        );
      });
    } else {
      snackBar.close();
      if (jsonResponse['code'] == 'invalid_username') {
        toastMeaasge('Invalid username', kRedColor, context);
      } else if (jsonResponse['code'] == 'invalid_password') {
        print(jsonResponse['message']);
        toastMeaasge('Invalid password.', kRedColor, context);
      } else if (jsonResponse['code'] == 'invalid_email') {
        print(jsonResponse['message']);
        toastMeaasge(jsonResponse['message'], kRedColor, context);
      }
    }
  }
}
