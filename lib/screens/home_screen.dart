import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_hands/palette.dart';

import 'package:hungry_hands/screens/account.dart';
import 'package:hungry_hands/screens/history.dart';
import 'package:hungry_hands/screens/shoppingCart.dart';

import '../models/arborGrillModel.dart';
import '../models/elPolloLocoModel.dart';
import '../models/freudianSipModel.dart';
import '../models/fryShackModel.dart';
import '../models/pandaModel.dart';
import '../models/sambazonModel.dart';
import '../models/shakeSmart.dart';
import '../models/subwayModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ScrollController _homeController = ScrollController();

  Widget _listViewBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: projectGrey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 75,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/hungryhands-69809.appspot.com/o/hungryhandsLogo.jpg?alt=media&token=824ce48a-2e33-438a-82d8-45415bb8a110"))),
                ),
                Container(
                  height: 75,
                  width: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          projectWhite,
                          projectRed,
                        ],
                        //begin: Alignment.bottomLeft,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Restaurants Near You",
                          style:
                              GoogleFonts.passionOne(textStyle: kBodyTextwhite),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: projectWhite,
                            ),
                            Text(
                              "CSUN",
                              style: GoogleFonts.passionOne(
                                  textStyle: kBodyTextwhite),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          //El Pollo Loco
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: projectRed, width: 1),
                  borderRadius: BorderRadius.circular(32)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: Container(
                          //useful width: i will expand depeding the width of the screen
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          // color: Colors.grey,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1200,height=672,format=auto/https://doordash-static.s3.amazonaws.com/media/store/header/7a7733b7-3a2c-4a19-9b62-2b91f3533da3.jpg'))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FetchMenuPollo()));
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 80,
                          height: 20,
                          decoration: BoxDecoration(
                              color: projectGrey,
                              borderRadius: BorderRadius.circular(32)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '15-20 min',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //-------------------------
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                      width: 700,
                      height: 50,
                      decoration: BoxDecoration(
                          color: projectGrey,
                          borderRadius: BorderRadius.circular(32)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'El Pollo Loco',
                            style: GoogleFonts.passionOne(textStyle: kBodyText),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '18111 Nordhoff St Northridge, CA ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //inside box------------------------
                ],
              ),
            ),
          ),
          //Freudian Sip
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: projectRed, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Container(
                          //useful width: i will expand depeding the width of the screen
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          // color: Colors.grey,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/hungryhands-69809.appspot.com/o/Freudiansipimage%20copy.jpg?alt=media&token=921762df-8c51-4a71-acfd-153891c8d51e'))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FetchMenuFred()));
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 80,
                          height: 20,
                          decoration: BoxDecoration(
                              color: projectGrey,
                              borderRadius: BorderRadius.circular(32)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '15-20 min',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //-------------------------
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 700,
                      height: 50,
                      decoration: BoxDecoration(
                          color: projectGrey,
                          borderRadius: BorderRadius.circular(23)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Freudian Sip',
                              style:
                                  GoogleFonts.passionOne(textStyle: kBodyText)),
                          const SizedBox(height: 5),
                          Text(
                            '18111 Nordhoff St Northridge, CA',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //inside box------------------------
                ],
              ),
            ),
          ),
          //Subway
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: projectRed, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Container(
                          //useful width: i will expand depeding the width of the screen
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          // color: Colors.grey,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://www.multivu.com/players/English/8918051-subway-eat-fresh-refresh-menu-update/image/SubwayClub_1625251990414-HR.jpg'))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FetchMenuSub()));
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 80,
                          height: 20,
                          decoration: BoxDecoration(
                              color: projectGrey,
                              borderRadius: BorderRadius.circular(32)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '15-20 min',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //-------------------------
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: 700,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: projectGrey),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Subway',
                            style: GoogleFonts.passionOne(textStyle: kBodyText),
                          ),
                          // const SizedBox(height: 5),
                          Text(
                            '18111 Nordhoff St Northridge, CA ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //inside box------------------------
                ],
              ),
            ),
          ),
          //panda express
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: projectRed, width: 1),
                  borderRadius: BorderRadius.circular(32)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Container(
                          //useful width: i will expand depeding the width of the screen
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          // color: Colors.grey,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://ddl1ff62eln9g.cloudfront.net/ez-image/122453/26_Office_Platter_Rev1.jpg?fh=1200&fw=600&h=1250&l=0&oh=1624&ow=2500&q=60&t=173&w=2500'))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FetchMenuPanda()));
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 80,
                          height: 20,
                          decoration: BoxDecoration(
                              color: projectGrey,
                              borderRadius: BorderRadius.circular(32)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '15-20 min',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                      width: 700,
                      height: 50,
                      decoration: BoxDecoration(
                          color: projectGrey,
                          borderRadius: BorderRadius.circular(32)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Panda Express',
                            style: GoogleFonts.passionOne(textStyle: kBodyText),
                          ),
                          //const SizedBox(height: 5),
                          Text(
                            '18111 Nordhoff St Northridge, CA ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Sambazon Acai
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: projectRed, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Container(
                          //useful width: i will expand depeding the width of the screen
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          // color: Colors.grey,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://reviewed-com-res.cloudinary.com/image/fetch/s--BJnYMR4I--/b_white,c_limit,cs_srgb,f_auto,fl_progressive.strip_profile,g_center,q_auto,w_972/https://reviewed-production.s3.amazonaws.com/1556296147933/Smoothie_bowl_hero.jpg'))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FetchMenuSamba()));
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 80,
                          height: 20,
                          decoration: BoxDecoration(
                              color: projectGrey,
                              borderRadius: BorderRadius.circular(32)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '15-20 min',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //-------------------------
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 700,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: projectGrey,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Sambazon Acai',
                            style: GoogleFonts.passionOne(textStyle: kBodyText),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '18111 Nordhoff St Northridge, CA ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //inside box------------------------
                ],
              ),
            ),
          ),
          //Fry Shack
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: projectRed, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Container(
                          //useful width: i will expand depeding the width of the screen
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          // color: Colors.grey,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://i.iheart.com/v3/re/new_assets/6257250a6dce9818d751d522?ops=contain(1480,0)'))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FetchMenuFry()));
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 80,
                          height: 20,
                          decoration: BoxDecoration(
                              color: projectGrey,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '15-20 min',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //-------------------------
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 700,
                      height: 50,
                      decoration: BoxDecoration(
                          color: projectGrey,
                          borderRadius: BorderRadius.circular(32)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Fry Shack',
                            style: GoogleFonts.passionOne(textStyle: kBodyText),
                          ),
                          //const SizedBox(height: 5),
                          Text(
                            'Santa Susana Hall, Prairie St, Northridge, CA',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //inside box------------------------
                ],
              ),
            ),
          ),
          //Arbor grill
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: projectRed, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          //useful width: i will expand depeding the width of the screen
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          // color: Colors.grey,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://www.csun.edu/sites/default/files/Arbor%20Grill%402x.png'))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FetchMenuAG()));
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 80,
                          height: 20,
                          decoration: BoxDecoration(
                              color: projectGrey,
                              borderRadius: BorderRadius.circular(32)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '15-20 min',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //-------------------------
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 700,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: projectGrey,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              'Arbor Grill',
                              style: GoogleFonts.passionOne(
                                textStyle: kBodyText,
                              ),
                            ),
                          ),
                          //const SizedBox(height: 1),
                          Text(
                            'N Garden Grove Ave, Northridge, CA ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //inside box------------------------
                ],
              ),
            ),
          ),
          //Shake Smart
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: projectRed, width: 1.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Container(
                          //useful width: i will expand depeding the width of the screen
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          // color: Colors.grey,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://pbs.twimg.com/media/EDoxsZeVAAA7F9J.jpg'))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FetchMenuShake()));
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 80,
                          height: 20,
                          decoration: BoxDecoration(
                              color: projectGrey,
                              borderRadius: BorderRadius.circular(32)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '15-20 min',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //-------------------------
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                      decoration: BoxDecoration(
                          color: projectGrey,
                          borderRadius: BorderRadius.circular(32)),
                      width: 700,
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Shake Smart ',
                            style: GoogleFonts.passionOne(textStyle: kBodyText),
                          ),
                          //const SizedBox(height: 5),
                          Text(
                            '18111 Nordhoff St Northridge, CA',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //inside box------------------------
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hungry Hands, 2023",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listViewBody(),
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
                // _homeController.animateTo(
                //   0.0,
                //   duration: const Duration(milliseconds: 500),
                //   curve: Curves.easeOut,
                // );
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
    );
  }
}
