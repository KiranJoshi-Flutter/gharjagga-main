import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gharjagga/screens/blog_screen_2.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:http/http.dart' as http;

Future fetchAlbum() async {
  final response = await http.get(Uri.parse(
      'https://gharjhagga.com/wp-json/wp/v2/posts?_embed&per_page=4'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load album');
  }
}

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  late Future futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    String yearMonthDay(var date) {
      var dateParsed = DateTime.parse("$date");
      String convertedDate = dateParsed.toIso8601String().split("T").first;
      return convertedDate;
    }

    return Container(
      color: Theme.of(context).backgroundColor,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/bg.png'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            SizedBox(
              height: 60.0,
            ),
            Expanded(
              flex: 6,
              child: Container(
                height: 200.0,
                width: double.infinity,
                // color: Colors.green,
                padding: EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  // bottom: 16.0,
                ),
                child: Container(
                  height: 100.0,
                  // color: Colors.grey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // height: 20.0,
                        // color: Colors.green,
                        child: FutureBuilder(
                          future: futureAlbum,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Container(
                                    // alignment: Alignment.topLeft,
                                    height: 180.0,
                                    // color: Colors.yellow,
                                    child: Image.network(
                                      '${snapshot.data![0]['_embedded']['wp:featuredmedia'][0]['source_url']}',
                                      // scale: 4.0,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    '${snapshot.data![0]['title']['rendered']}',
                                    style: appTextStyle(
                                      FontWeight.bold,
                                      18.0,
                                      kTextColor,
                                    ),
                                  ),
                                  Container(
                                    height: 130.0,
                                    child: Html(
                                      style: {
                                        "body": Style(
                                          margin: EdgeInsets.zero,
                                          padding: EdgeInsets.zero,
                                        ),
                                      },
                                      data: snapshot.data![0]['excerpt']
                                          ['rendered'],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  // Text('${snapshot.data![0]['date']}'),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      '${yearMonthDay(snapshot.data![0]['date'])}',
                                      style: appTextStyle(
                                        FontWeight.normal,
                                        16.0,
                                        kTextColor,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return Center(
                              child: Column(
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                // height: 500.0,
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: 8.0,
                  left: 22.0,
                  right: 22.0,
                ),
                // decoration: BoxDecoration(
                //   color: Theme.of(context).scaffoldBackgroundColor,
                //   borderRadius: BorderRadius.only(
                //     topRight: Radius.circular(30.0),
                //     topLeft: Radius.circular(30.0),
                //   ),
                // ),
                child: FutureBuilder(
                  future: futureAlbum,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlogScreen2(
                                    title: snapshot.data![index]['title']
                                        ['rendered'],
                                    imageUrl: snapshot.data![index]['_embedded']
                                        ['wp:featuredmedia'][0]['source_url'],
                                    date: snapshot.data![index]['date'],
                                    description: snapshot.data![index]
                                        ['excerpt']['rendered'],
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image.network(
                                '${snapshot.data![index]['_embedded']['wp:featuredmedia'][0]['source_url']}',
                                width: 80.0,
                                // height: 100.0,
                                fit: BoxFit.fill,
                              ),
                              title: Text(
                                  '${snapshot.data![index]['title']['rendered']}'),
                              subtitle: Column(
                                children: [
                                  // Text(
                                  //   'Price is the most crucial factor to determine before selling your house',
                                  // ),
                                  Container(
                                    height: 80.0,
                                    child: Html(
                                      data: snapshot.data![index]['excerpt']
                                          ['rendered'],
                                    ),
                                  ),
                                  Text(
                                      '${yearMonthDay(snapshot.data![index]['date'])}'),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
