import 'package:flutter/material.dart';

import '../palette.dart';
import '../screens/account.dart';
import '../screens/history.dart';
import '../screens/home_screen.dart';
import '../screens/shoppingCart.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // final ScrollController _homeController = ScrollController();
  int _currentIndex = 0;

  List<Widget> body = const [
    Icon(Icons.history),
    Icon(Icons.person),
    Icon(Icons.home),
    Icon(Icons.favorite)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 15,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        selectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: projectRed,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
            backgroundColor: projectRed,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: projectRed,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
            backgroundColor: projectRed,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          switch (index) {
            case 0:
              if (_selectedIndex == index) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              }
              break;
            case 1:
              if (_selectedIndex == index) {
                // history class
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const history()));
              }
              break;
            case 2:
              if (_selectedIndex == index) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const shoppingCart()));
              }
              break;
            case 3:
              if (_selectedIndex == index) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountScreen()));
              }
              break;
          }
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),
      // body: Center(
      //   child: body[_currentIndex],
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: (int newIndex) {
      //     //  setState(() {
      //     _currentIndex = newIndex;
      //     // });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       label: 'Home',
      //       icon: Icon(Icons.home),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'History',
      //       icon: Icon(Icons.history),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'Account',
      //       icon: Icon(Icons.person),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'Favorite',
      //       icon: Icon(Icons.favorite),
      //     ),
      //   ],
      // ),
    );
  }
}
