import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gharjagga/utlis/constant.dart';

import 'package:http/http.dart' as http;

class BlogScreen2 extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String date;
  final String description;

  const BlogScreen2(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.date,
      required this.description})
      : super(key: key);

  @override
  _BlogScreen2State createState() => _BlogScreen2State();
}

class _BlogScreen2State extends State<BlogScreen2> {
  int aDayAge() {
    print('${widget.date}');
    var date = DateTime.parse("${widget.date}");
    var now = DateTime.now();
    var diff = now.difference(date).inDays;
    return diff;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          //title: Text(widget.title),
          backgroundColor: kThemeColor,
          centerTitle: false,
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(
                  left: 16.0,
                  top: 16.0,
                  bottom: 16.0,
                  right: 16.0,
                ),
                // color: Colors.grey,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 220.0,
                      // color: Colors.purple,
                      child: Image.network(
                        widget.imageUrl,
                        scale: 4.0,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      // height: 40.0,
                      width: double.infinity,
                      // color: Colors.yellow,
                      child: Text(
                        widget.title,
                        style: appTextStyle(
                          FontWeight.bold,
                          16.0,
                          Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      height: 40.0,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/icons/logo.png'),
                              Text('Gharjagga'),
                            ],
                          ),
                          Text('${aDayAge()} days ago'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // height: 40.0,
                        width: double.infinity,
                        // color: Colors.green,
                        child: Html(
                          data: widget.description,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      height: 30.0,
                      width: double.infinity,
                      // color: Colors.orange,
                      child: Text(
                        'Related Posts',
                        style: appTextStyle(
                          FontWeight.bold,
                          16.0,
                          kTextColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      // tileColor: Colors.red,
                      leading: Text('How to determine your house price ?'),
                      trailing: Image.network(
                        'https://gharjhagga.com/wp-content/uploads/2017/10/WhatsApp-Image-2021-08-05-at-5.22.28-PM-1.jpeg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      // tileColor: Colors.red,
                      leading: Text('Registration Fees for Buying'),
                      trailing: Image.network(
                        'https://gharjhagga.com/wp-content/uploads/2017/09/241400445_576129423521746_3264372576409146858_n.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
