import 'package:flutter/material.dart';
import 'package:snow_login/jelajahi.dart';
import 'package:snow_login/kategori.dart';
import 'package:snow_login/profile.dart';
import 'package:snow_login/screens/homescreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:snow_login/model/user.dart'; 

class Dashboard extends StatefulWidget {
  final User currentUser;

  const Dashboard({super.key, required this.currentUser});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  String _title = '';
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _title = 'default';
    _widgetOptions = <Widget>[
      HomeScreen(),
      Jelajahi(),
      Kategori(),
      Profile(user: widget.currentUser), 
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,233, 246, 255),
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          elevation: 1,
          toolbarHeight: 50,
          backgroundColor: Color.fromARGB(255, 40, 2, 116),
          centerTitle: true,
          title: _title == 'default'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                '../asset/images/logo2.png',
                                width: 150,
                                height: 150,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Text(
                  _title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color.fromARGB(255, 40, 2, 116),
        buttonBackgroundColor: Color.fromARGB(255, 254, 122, 54),
        height: 60,
        animationDuration: Duration(milliseconds: 300),
        index: _selectedIndex,
        onTap: onTabTapped,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.explore, size: 30, color: Colors.white),
          Icon(Icons.category, size: 30, color: Colors.white),
          Icon(Icons.people, size: 30, color: Colors.white),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _title = 'default';
          break;
        case 1:
          _title = 'default';
          break;
        case 2:
          _title = 'default';
          break;
        case 3:
          _title = 'default';
          break;
      }
    });
  }
}
