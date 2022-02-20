import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gharjagga/screens/blog_screen.dart';
// import 'package:gharjagga/screens/detail_screen.dart';
// import 'package:gharjagga/screens/filter_screen.dart';
import 'package:gharjagga/screens/home_screen.dart';
import 'package:gharjagga/utlis/constant.dart';
import 'package:gharjagga/views/profile_screen.dart';
import 'package:gharjagga/views/saved_screen.dart';
// import 'package:gharjagga/widgets/blast_apartment.dart';
// import 'package:gharjagga/widgets/new_buildings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // bool _active = false;
  int _selectedNavItem = 0;
  String title = 'Ghar Jagga';

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomeScreen(),
        SavedScreen(),
        BlogScreen(),
        ProfileScreen(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      _selectedNavItem = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      _selectedNavItem = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: buildPageView(),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: ((value) {
            setState(() {
              _selectedNavItem = value;
            });
            print(title);
            bottomTapped(value);
          }),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/Category.png"),
                // color: Colors.white,
                color: _selectedNavItem == 0
                    ? kTextColor
                    : kBottomNavigarionBarIconColor,
                size: 26,
              ),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/Bookmark.png"),
                color: _selectedNavItem == 1
                    ? kTextColor
                    : kBottomNavigarionBarIconColor,
                size: 26,
              ),
              label: 'Bookmark',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/blog.png"),
                color: _selectedNavItem == 2
                    ? kTextColor
                    : kBottomNavigarionBarIconColor,
                size: 26,
              ),
              label: 'Blog',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/Profile.png"),
                color: _selectedNavItem == 3
                    ? kTextColor
                    : kBottomNavigarionBarIconColor,
                size: 26,
              ),
              label: 'Profile',
            ),
          ],
          selectedItemColor: kTextColor,
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
        ),
      ),
    );
  }
}
