import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharjagga/functions/functions.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:iconly/iconly.dart';

// ignore: must_be_immutable
class SavedPropertyList extends StatefulWidget {
  String? buildings;
  String? address;
  double? rating;
  String? price;
  String? photoAddress;
  String? offerType;
  String? bedroom;
  String? bathroom;
  String? propertySize;

  SavedPropertyList({
    this.buildings,
    this.address,
    this.rating,
    this.price,
    this.photoAddress,
    this.offerType,
    this.bedroom,
    this.bathroom,
    this.propertySize,
  });

  @override
  _SavedPropertyListState createState() => _SavedPropertyListState();
}

class _SavedPropertyListState extends State<SavedPropertyList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black38,
      // height: 150.0,
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                16.0,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      // color: Colors.black26,
                      child: FutureBuilder(
                        future: imageURLCheck(widget.photoAddress!),
                        builder: (context, asyncSnapshot) {
                          if (asyncSnapshot.hasData) {
                            if (asyncSnapshot.data != null) {
                              return Container(
                                // color: Colors.green,
                                height: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      widget.photoAddress!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                // color: Colors.black,
                                // width: 200, height: 150,
                                height: 150,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(
                                    "assets/images/no_image.png",
                                  ),
                                ),
                              );
                            }
                          } else {
                            return Container(
                              color: Colors.white,
                              height: 150,
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      // color: Colors.black12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${widget.buildings}',
                            style: appTextStyle(
                              FontWeight.bold,
                              16.0,
                              kTextColor,
                            ),
                            // maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              widget.bedroom! != "0"
                                  ? Expanded(
                                      flex: 3,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              // height: 32,
                                              child: Card(
                                                color: Color(0xFFE7E7E9),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: ImageIcon(
                                                    AssetImage(
                                                        "assets/icons/blast_apartment/Group415.png"),
                                                    color: kTextColor,
                                                    // size: 8.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.0,
                                            ),
                                            Expanded(
                                              child: Text(
                                                widget.bedroom!,
                                                style: appTextStyle(
                                                  FontWeight.bold,
                                                  12.0,
                                                  kTextColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              widget.bathroom! != "0"
                                  ? Expanded(
                                      flex: 3,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              // height: 32,
                                              child: Card(
                                                color: Color(0xFFE7E7E9),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: ImageIcon(
                                                    AssetImage(
                                                        "assets/icons/blast_apartment/Group419.png"),
                                                    color: kTextColor,
                                                    // size: 8.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                            ),
                                            Expanded(
                                              child: Text(
                                                widget.bathroom!,
                                                style: appTextStyle(
                                                  FontWeight.bold,
                                                  12.0,
                                                  kTextColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              widget.propertySize! != "0"
                                  ? Expanded(
                                      flex: 5,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              // height: 32,
                                              child: Card(
                                                color: Color(0xFFE7E7E9),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: ImageIcon(
                                                    AssetImage(
                                                        "assets/icons/blast_apartment/Group417.png"),
                                                    color: kTextColor,
                                                    // size: 8.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${widget.propertySize!} ft??",
                                                style: appTextStyle(
                                                  FontWeight.bold,
                                                  12.0,
                                                  kTextColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Rs. ${widget.price} /-',
                              style: appTextStyle(
                                FontWeight.bold,
                                15.0,
                                kThemeColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 4,
            top: 4,
            child: Container(
              // color: kThemeColor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0)),
                color: kSecondary,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 12.0,
              ),
              child: Text(
                widget.offerType!.toUpperCase(),
                style: appTextStyleWLS(
                  FontWeight.bold,
                  10.0,
                  Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
