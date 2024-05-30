import 'package:flutter/material.dart';
import 'package:snow_login/screens/homescreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

int _selectedIndex = 0;
  String _title = '';
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen()
  ];

  @override
   void initState(){
    super.initState();

    _title = 'default';
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBar(
          elevation: 2,
          toolbarHeight: 100,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: _title == 'default' ? Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
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
                          // Text(
                          //   'RAT',
                          //  overflow: TextOverflow.ellipsis,
                          //         maxLines: 1,
                          //         style: TextStyle(
                          //           fontSize: 20,
                                    
                                 
                          //           color: Colors.black,
                          //           fontWeight: FontWeight.w900
                          //         ),
                          // ),
                          // // Text(
                          //         'User',
                          //         overflow: TextOverflow.ellipsis,
                          //         maxLines: 1,
                          //         style: TextStyle(
                          //           fontSize: 12,
                          //           color: Colors.black,
                          //         ),
                          //       ),
                      
                        ],
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                        radius: 30,
                        child: CircleAvatar(
                          radius: 27,
                          backgroundImage:
                          AssetImage('../asset/images/profile.jpeg'),
                          backgroundColor: Colors.amber,
                        ),
                      ),
              ],
            ),
          )
           : Text(_title,
          maxLines: 1,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
        ),
      )
        ),
        preferredSize: Size.fromHeight(70.0),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
                child: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.blue,
          selectedItemColor: Colors.red,
          items: [
            BottomNavigationBarItem(
              label: "Beranda",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Jelajahi",
              icon: Icon(Icons.explore),
            ),
            BottomNavigationBarItem(
              label: "Kategori",
              icon: Icon(Icons.category),
            ),
            BottomNavigationBarItem(
              label: "Profil",
              icon: Icon(Icons.people),
            ),
            
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          {
            _title = 'default';
          }
          break;
        case 1:
          {
            _title = 'navbar 1';
          }
          break;
        case 2:
          {
            _title = 'navbar 2';
          }
          break;
        case 3:
          {
            _title = 'navbar 3';
          }
          break;
      }
    });
  }
}