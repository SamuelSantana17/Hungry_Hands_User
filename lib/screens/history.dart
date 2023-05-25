import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
//import 'package:hands/update_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungry_hands/screens/home_screen.dart';
import 'package:hungry_hands/screens/shoppingCart.dart';

import '../palette.dart';
import 'account.dart';

// do i need update_record.dart ?
class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  State<history> createState() => _FetchDataState();
}

class _FetchDataState extends State<history> {
  int _selectedIndex = 0;
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('Shopping Cart');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: projectRed,
        title: const Center(child: Text('Order History')),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _products
            .where('customerName',
                isEqualTo: FirebaseAuth.instance.currentUser!.displayName)
            .snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.hasData) {
            final documents = streamSnapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final document = documents[index];
                final totalPrice = document['totalPrice'];
                final cartItems = document['cartItems'];
                final customerName = document['customerName'];
                final timestamp = document['timestamp'];

                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: projectRed, width: 1),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          'Customer: $customerName',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      const Divider(height: 1),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          final food = cartItem['food'];
                          final price = cartItem['price'];
                          final quantity = cartItem['quantity'];

                          return ListTile(
                            title: Text(food),
                            subtitle: Text(
                              'Price: $price  x$quantity ',
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          'Total Price: $totalPrice',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          'Date: ${timestamp.toDate()}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
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
    );
  }
}
