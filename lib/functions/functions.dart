// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<bool> imageURLCheck(String url) async {
  final response = await http.head(Uri.parse(url));

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
