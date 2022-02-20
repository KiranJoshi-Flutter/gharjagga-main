import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharjagga/functions/functions.dart';
// import 'package:gharjagga/screens/detail_screen.dart';
import 'package:gharjagga/utlis/constant.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:gharjagga/views/property_detail_screen.dart';
import 'package:iconly/iconly.dart';

// ignore: must_be_immutable
class BlastApartment extends StatefulWidget {
  String? propertyId;
  String? photoLink;
  String? apartmentName;
  String? price;
  String? location;
  String? desc;
  String? offerType;
  String? bedroom;
  String? bathroom;
  String? propertySize;
  String? neighborhood;
  String? street;
  String? city;

  BlastApartment({
    this.propertyId,
    this.photoLink,
    this.apartmentName,
    this.price,
    this.location,
    this.desc,
    this.offerType,
    this.bedroom,
    this.bathroom,
    this.propertySize,
    this.neighborhood,
    this.street,
    this.city,
  });

  @override
  _BlastApartmentState createState() => _BlastApartmentState();
}

class _BlastApartmentState extends State<BlastApartment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      // color: Colors.grey,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.0,
            ),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 12,
                    // height: 150,
                    child: Container(
                      height: 110,
                      child: FutureBuilder(
                        future: imageURLCheck(widget.photoLink!),
                        builder: (context, asyncSnapshot) {
                          if (asyncSnapshot.hasData) {
                            if (asyncSnapshot.data != null) {
                              return Container(
                                // height: 150,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      spreadRadius: 0.7,
                                      blurRadius: 1,
                                      offset: Offset(
                                        0.2,
                                        0.75,
                                      ), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(
                                    8.0,
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      widget.photoLink!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                // color: Colors.black,
                                // width: 200,
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
                              height: 110,
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
                    height: 8.0,
                  ),
                  // Expanded(
                  //   flex: 9,
                  //   child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.apartmentName}',
                              style: appTextStyle(
                                FontWeight.bold,
                                18.0,
                                kTextColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.0,
                      ),

                      RichText(
                        text: TextSpan(
                          text: 'Rs. ${widget.price} /-',
                          style: appTextStyle(
                            FontWeight.bold,
                            16.0,
                            kThemeColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      // Row(
                      //   children: [
                      //     ImageIcon(
                      //       AssetImage("assets/icons/Location.png"),
                      //       color: kTextHintColor,
                      //       // size: 30,
                      //     ),
                      //     SizedBox(
                      //       width: 5.0,
                      //     ),
                      //     Text(
                      //       '${widget.location}',
                      //       style: appTextStyle(
                      //         FontWeight.normal,
                      //         14.0,
                      //         kTextHintColor,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(
                              IconlyBold.location,
                              size: 12.0,
                              color: kTextHintColor,
                            ),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: "${widget.neighborhood}",
                                style: appTextStyle(
                                  FontWeight.w500,
                                  12.0,
                                  kTextHintColor,
                                ),
                                children: [
                                  widget.neighborhood != ''
                                      ? TextSpan(
                                          text: ",",
                                          style: appTextStyle(
                                            FontWeight.w500,
                                            12.0,
                                            kTextHintColor,
                                          ),
                                        )
                                      : TextSpan(),
                                  TextSpan(
                                    text: " ${widget.city}",
                                    style: appTextStyle(
                                      FontWeight.w500,
                                      12.0,
                                      kTextHintColor,
                                    ),
                                  ),
                                  widget.street != ''
                                      ? TextSpan(
                                          text: " (${widget.street})",
                                          style: appTextStyle(
                                            FontWeight.w500,
                                            12.0,
                                            kTextHintColor,
                                          ),
                                        )
                                      : TextSpan(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: [
                          widget.bedroom! != "0"
                              ? Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Card(
                                          color: Color(0xFFE7E7E9),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: ImageIcon(
                                              AssetImage(
                                                  "assets/icons/blast_apartment/Group415.png"),
                                              color: kTextColor,
                                              // size: 8.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        Expanded(
                                          child: Text(
                                            widget.bedroom!,
                                            style: appTextStyle(
                                              FontWeight.bold,
                                              14.0,
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
                                        Card(
                                          color: Color(0xFFE7E7E9),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: ImageIcon(
                                              AssetImage(
                                                  "assets/icons/blast_apartment/Group419.png"),
                                              color: kTextColor,
                                              // size: 8.0,
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
                                              14.0,
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
                                        Card(
                                          color: Color(0xFFE7E7E9),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: ImageIcon(
                                              AssetImage(
                                                  "assets/icons/blast_apartment/Group417.png"),
                                              color: kTextColor,
                                              // size: 8.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${widget.propertySize!} ft²",
                                            style: appTextStyle(
                                              FontWeight.bold,
                                              14.0,
                                              kTextColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),

                          // Expanded(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          // Card(
                          //   color: Color(0xFFE7E7E9),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(2.0),
                          //     child: ImageIcon(
                          //       AssetImage(
                          //           "assets/icons/blast_apartment/Group415.png"),
                          //       color: kTextColor,
                          //       // size: 8.0,
                          //     ),
                          //   ),
                          // ),
                          //       Text(
                          //         widget.bedroom!,
                          // style: appTextStyle(
                          //   FontWeight.bold,
                          //   14.0,
                          //   kTextColor,
                          // ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Expanded(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Card(
                          //         color: Color(0xFFE7E7E9),
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(2.0),
                          //           child: ImageIcon(
                          //             AssetImage(
                          //                 "assets/icons/blast_apartment/Group419.png"),
                          //             color: kTextColor,
                          //             // size: 8.0,
                          //           ),
                          //         ),
                          //       ),
                          //       Text(
                          //         widget.bathroom!,
                          //         style: appTextStyle(
                          //           FontWeight.bold,
                          //           14.0,
                          //           kTextColor,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Expanded(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Card(
                          //         color: Color(0xFFE7E7E9),
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(2.0),
                          //           child: ImageIcon(
                          //             AssetImage(
                          //                 "assets/icons/blast_apartment/Group417.png"),
                          //             color: kTextColor,
                          //             // size: 8.0,
                          //           ),
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         width: 8.0,
                          //       ),
                          //       Text(
                          //         "${widget.propertySize!} * 100000000000000000 ",
                          //         style: appTextStyle(
                          //           FontWeight.bold,
                          //           14.0,
                          //           kTextColor,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 10.0,
                          // ),
                        ],
                      ),
                    ],
                  ),
                  // ),
                ],
              ),
            ),
            widget.offerType!.isNotEmpty
                ? Positioned(
                    child: Container(
                      // color: kThemeColor,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            16.0,
                          ),
                        ),
                        color: kSecondary,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Text(
                        widget.offerType!.toUpperCase(),
                        style: appTextStyleWLS(
                          FontWeight.bold,
                          12.0,
                          Colors.white,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
