import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungry_hands/screens/shoppingCart.dart';

import '../palette.dart';
import '../screens/account.dart';
import '../screens/history.dart';
import '../screens/home_screen.dart';

class FetchMenuFred extends StatefulWidget {
  const FetchMenuFred({Key? key}) : super(key: key);

  @override
  State<FetchMenuFred> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchMenuFred> {
  int _selectedIndex = 0;
// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final CollectionReference _products =
      FirebaseFirestore.instance.collection('ln4mVus0REWI3zocMZ63zgyRmC42');
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');

  bool itemAdded = false; // track whether an item has been added to the cart

  Future<void> create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'food'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  Future<void> addToCart(DocumentSnapshot? menuItem) async {
    if (menuItem == null) {
      return; // Return early if menuItem is null
    }
    //added --------------------
    setState(() {
      itemAdded =
          true; // set itemAdded to true when an item is added to the cart
    });

    try {
      final QuerySnapshot result = await cartCollection
          .where('food', isEqualTo: menuItem.get('food'))
          .limit(1)
          .get();
      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final DocumentSnapshot cartItem = documents.first;
        final int previousQuantity = cartItem.get('quantity');
        final double previousTotalPrice = cartItem.get('totalPrice');
        final double itemPrice = menuItem.get('price');
        final double subTotal = previousTotalPrice / previousQuantity;
        const double deliveryFee = 5.99;
        const double taxRate = 0.095;
        final double totalPrice =
            (previousTotalPrice + itemPrice + deliveryFee) * (1 + taxRate);

        await cartItem.reference.update({
          'quantity': previousQuantity + 1,
          'totalPrice': totalPrice,
          'subTotal': subTotal * (previousQuantity + 1),
        });
      } else {
        final double itemPrice = menuItem.get('price');
        const double deliveryFee = 5.99;
        const double taxRate = 0.095;
        final double totalPrice = (itemPrice + deliveryFee) * (1 + taxRate);

        await cartCollection.add({
          'food': menuItem.get('food'),
          'price': itemPrice,
          'quantity': 1,
          'totalPrice': totalPrice,
          'subTotal': itemPrice,
          'RestaurantID': 'ln4mVus0REWI3zocMZ63zgyRmC42'
        });
      }
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }

  Future<void> deleteFromCart(String productId) async {
    final DocumentSnapshot cartItem = await cartCollection.doc(productId).get();
    final int previousQuantity = cartItem.get('quantity');

    if (previousQuantity == 1) {
      await cartCollection.doc(productId).delete();
    } else {
      await cartCollection
          .doc(productId)
          .update({'quantity': previousQuantity - 1});
    }
  }

  Future<void> mainDelete(DocumentSnapshot? menuItem) async {
    if (menuItem == null) {
      return; // Return early if menuItem is null
    }

    final QuerySnapshot result = await cartCollection
        .where('food', isEqualTo: menuItem.get('food'))
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;

    if (documents.isNotEmpty) {
      final DocumentSnapshot cartItem = documents.first;
      await deleteFromCart(cartItem.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: projectRed,
        title: const Center(child: Text('Freudian Sip Menu')),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const shoppingCart()));
                },
              ),
              if (itemAdded) // display an asterisk icon if an item has been added
                const Positioned(
                  right: 4,
                  top: 0,
                  child: Text("*"),
                ),
            ],
          ),
        ],
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
      body: StreamBuilder(
        stream: _products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: projectGrey, width: 1),
                      borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['food']),
                    subtitle: Text('\$${documentSnapshot['price'].toString()}'),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: BorderSide(
                                        color: projectRed, width: 1.0),
                                  ),
                                ),
                              ),
                              onPressed: () => addToCart(documentSnapshot),
                              child: const Text(
                                "Add",
                                style: TextStyle(color: projectRed),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: projectRed,
            ),
          );
        },
      ),
// Add new product
    );
  }
}
