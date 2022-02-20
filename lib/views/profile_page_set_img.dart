import 'package:flutter/material.dart';

class ProfilePageSetImage extends StatelessWidget {
  const ProfilePageSetImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 896,
          width: 414,
          color: Colors.blueGrey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 25, top: 60.0, right: 57.0),
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      color: Colors.grey,
                    ),
                    child: Image.asset(
                        "assets/icons/profile_screen/Stroke 1 backColor.png"),
                  ),
                  Container(
                      //color: Colors.green,
                      margin: EdgeInsets.only(top: 60.0),
                      child: Text(
                        "Set Picture",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 28.0,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 110),
                child: Container(
                  // margin: EdgeInsets.only(top: 163),  -------------->> but the screen size is small so I use below margin
                  margin: EdgeInsets.only(top: 0.0),

                  width: 350,
                  height: 350,
                  // color: Colors.yellow,
                  child: CircleAvatar(
                    //backgroundColor: Colors.teal,
                    backgroundImage: AssetImage(
                        'assets/icons/profile_screen/dummy_profile/dummy profile.png'),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.only(bottom: 0, left: 25, right: 25, top: 0),
                    width: 155.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      color: Colors.white,
                    ),
                    child: Center(
                        child: Text("Cancel",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ))),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(bottom: 0, left: 25, right: 25, top: 0),
                    width: 155.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      color: Colors.white,
                    ),
                    child: Center(
                        child: Text("Done",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
