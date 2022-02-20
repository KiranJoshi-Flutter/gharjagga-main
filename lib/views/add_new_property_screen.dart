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
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;

class AddNewPropertyScreen extends StatefulWidget {
  @override
  _AddNewPropertyScreenState createState() => _AddNewPropertyScreenState();
}

class _AddNewPropertyScreenState extends State<AddNewPropertyScreen> {
  final GlobalKey webViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
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
      body: FadedSlideAnimation(
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: WebView(
          initialUrl: 'https://gharjhagga.com/panel/#/submit-property',
          javascriptMode: JavascriptMode.unrestricted,
          zoomEnabled: false,
        ),
      ),
    );
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }
}
