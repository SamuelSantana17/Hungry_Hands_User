// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:hungry_hands/palette.dart';
import 'package:hungry_hands/screens/dropOff.dart';
import 'package:hungry_hands/screens/pickUp.dart';

import 'account.dart';
import 'history.dart';
import 'home_screen.dart';

// ignore: camel_case_types
class shoppingCart extends StatefulWidget {
  const shoppingCart({Key? key}) : super(key: key);

  @override
  State<shoppingCart> createState() => _FetchDataState();
}

//toggle section

class _FetchDataState extends State<shoppingCart>
//toggle section
    with
        SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: projectGrey,
      //   title: Text("Your Cart"),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 15,
        selectedIconTheme: const IconThemeData(color: projectWhite),
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
      body: Center(
        child: Expanded(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          const SizedBox(height: 0),
                          Container(
                            width: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: TabBar(
                                    unselectedLabelColor: projectRed,
                                    labelColor: Colors.white,
                                    indicatorColor: Colors.white,
                                    indicatorWeight: 2,
                                    indicator: BoxDecoration(
                                      color: projectRed,
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    controller: tabController,
                                    tabs: const [
                                      Tab(
                                        text: 'Delivery',
                                      ),
                                      Tab(
                                        text: 'Pick Up',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: const [
                                DropOff(),
                                PickUp(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
