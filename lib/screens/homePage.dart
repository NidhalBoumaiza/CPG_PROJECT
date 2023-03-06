import 'package:client/screens/FirstPageOfHome.dart';
import 'package:client/screens/internersPage.dart';
import 'package:client/screens/supervisorPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../components/widgetDrawer.dart';
import 'instituteScreen.dart';

class homePage extends StatefulWidget {
  var i;
  homePage({this.i});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 0;

  List<Widget> _pageOption = <Widget>[
    FirstPageOfHome(),
    supervisorPage(),
    internScreen(),
    instituteScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.i != null) {
      setState(() {
        _selectedIndex = widget.i;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: widgetDrawer(),
        body: Center(
          child: _pageOption.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: GNav(
              onTabChange: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              padding: EdgeInsets.all(10),
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              gap: 8,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Supervisor',
                ),
                GButton(
                  icon: Icons.hail,
                  text: 'Intern',
                ),
                GButton(
                  icon: Icons.school_rounded,
                  text: 'School',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
