import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:gharjagga/utlis/userpreferences.dart';
// import 'package:gharjagga/utlis/userpreferences.dart';
import 'package:gharjagga/views/landing_page.dart';
import 'package:gharjagga/views/main_screen.dart';
import 'package:gharjagga/views/sign_in_screen.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:gharjagga/views/main_screen.dart';
// import 'package:gharjagga/views/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print("Handling a background message");
}

class MyApp extends StatefulWidget {
  // SplashScreen({Key? key, required this.title}) : super(key: key);

  // final String title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  late Future init;

  @override
  void initState() {
    super.initState();

    init = firebaseInit();
  }

  Future firebaseInit() {
    return Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xffB0032B, mPrimaryColor);
    return FutureBuilder(
      // Initialize FlutterFire
      future: init,
      builder: (context, snapshot) {
        // Check for errors

        // if this line was added , it was not running on ios simulator

        // if (snapshot.hasError) {
        //   return MaterialApp(
        //     home: Scaffold(
        //       body: Container(
        //         child: Center(
        //           child: Text("Something went wrong."),
        //         ),
        //       ),
        //     ),
        //   );
        // }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.dmSansTextTheme(),
              appBarTheme: AppBarTheme(
                brightness: Brightness.light,
              ),
              primarySwatch: colorCustom,
            ),

            // home: LandingScreen(),
            home: SplashScreen(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  // SplashScreen({Key? key, required this.title}) : super(key: key);

  // final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // int _counter = 0;

  late FirebaseMessaging messaging;

  late Future initial;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    bool firstAppStatus = await UserPreferences.getFirstAppStatus();
    bool loginStatus = await UserPreferences.getLoginStatus();

    // // print('First App Status = $firstAppStatus');
    // // print('Login Status = $loginStatus');

    // Timer(
    //   Duration(seconds: 3),
    //   () => Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => LandingScreen()),
    //   ),
    // );

    // If firstAppStatus is true that means the user has already installed app and visiting app another time.
    if (firstAppStatus) {
      Timer(
        Duration(seconds: 2),
        (() {
          if (loginStatus) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
            );
          } else {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
            );
          }
        }),
      );
    } else {
      Timer(
        Duration(seconds: 2),
        (() {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LandingScreen(),
            ),
          );
        }),
      );
      UserPreferences.setFirstAppStatus(true);
    }

    // if (loginStatus) {
    //   Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => RoleSelection()),
    //     ),
    //   );
    // }else{

    // }

    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      var token = await messaging.getToken();
      // // print("token $token");

      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          // // print('Got a message whilst in the foreground!');
          // // print('Message data: ${message.data.entries}');
//
          if (message.notification != null) {
            // print('Notification Title: ${message.notification!.title}');
          }
        },
      );
    } on Exception catch (exception) {
      // print(exception);
    } catch (error) {
      // print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 150,
              child: Image.asset(
                "assets/images/bg-top.png",
                alignment: AlignmentDirectional.centerEnd,
              ),
            ),
            Container(
              child: ScaleAnimation(
                child: Image.asset(
                  "assets/icons/logo.png",
                  width: 150,
                ),
                duration: Duration(seconds: 1),
              ),
              // child: Future.delayed(Duration(milliseconds: 100), () {
              //   // Do something
              // }),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  // color: kTextColor,
                  height: 250,
                  child: Image.asset(
                    "assets/images/bg-bottom.png",
                    alignment: AlignmentDirectional.centerStart,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
