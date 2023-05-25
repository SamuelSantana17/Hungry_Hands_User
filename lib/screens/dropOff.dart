// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:hands/update_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_hands/screens/Delivery.dart';

//import 'package:hungry_hands/screens/account.dart';
import 'package:hungry_hands/screens/home_screen.dart';

import '../palette.dart';
//import 'package:hungry_hands/screens/pickUp.dart';

// ignore: camel_case_types
class DropOff extends StatefulWidget {
  const DropOff({Key? key}) : super(key: key);

  @override
  State<DropOff> createState() => _FetchDataState();
}

//toggle section

class _FetchDataState extends State<DropOff>
//toggle section
    with
        SingleTickerProviderStateMixin {
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

//-------------------------

// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final CollectionReference _products =
      FirebaseFirestore.instance.collection('cart');
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');

  final CollectionReference _dropOffLocationsStream =
      FirebaseFirestore.instance.collection('DropOffLocations');

  String? _selectedLocation;

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
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

        final double subTotal =
            previousTotalPrice + (previousQuantity * itemPrice);
        const double deliveryFee = 5.99;
        const double taxRate = 0.095;

        final double totalPrice = (subTotal + deliveryFee) * (1 + taxRate);

        await cartItem.reference.update({
          'quantity': previousQuantity + 1,
          'totalPrice': totalPrice,
          'subTotal': subTotal,
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
        });
      }
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }

  Future<void> deleteFromCart(String productId) async {
    final DocumentSnapshot cartItem = await cartCollection.doc(productId).get();
    final int previousQuantity = cartItem.get('quantity');
    final double previousTotalPrice = cartItem.get('totalPrice');
    final double previousSubTotal = cartItem.get('subTotal');
    final double itemPrice = cartItem.get('price');
    final double subTotal = previousSubTotal / previousQuantity;

    if (previousQuantity == 1) {
      await cartCollection.doc(productId).delete();
    } else {
      const double deliveryFee = 5.99;
      const double taxRate = 0.095;
      final double totalPrice =
          (previousTotalPrice - itemPrice - deliveryFee) * (1 + taxRate);
      await cartCollection.doc(productId).update({
        'quantity': previousQuantity - 1,
        'totalPrice': totalPrice,
        'subTotal': subTotal * (previousQuantity - 1),
      });
    }
  }

//gets the total price
  Future<void> addToShoppingCart() async {
    double totalPrice = 0;
    double deliveryFee = 5.99;
    double tax = 0.095;
    double taxCal = 0;
    double subtotal = 0;
    String RestaurantID = '';

    // double noDeliveryFee = 0;
    List<Map<String, dynamic>> cartItems = [];
    String customerName = '';

    final cartSnapshot =
        await FirebaseFirestore.instance.collection('cart').get();

    // Loop through the cart items and calculate the total price
    for (var item in cartSnapshot.docs) {
      Map<String, dynamic> cartItem = {
        'food': item['food'],
        'price': item['price'],
        'quantity': item['quantity'],
      };
      // change delivery fee, if we add pick up
      subtotal += item['price'] * item['quantity'];
      taxCal += (subtotal) * tax;
      totalPrice += item['price'] * item['quantity'] + deliveryFee + taxCal;
      RestaurantID = item['RestaurantID'];
      cartItems.add(cartItem);
    }

    // final customerInfoSnapshot =
    //     await FirebaseFirestore.instance.collection('Customer Info').get();
    // if (customerInfoSnapshot.docs.isNotEmpty) {
    //   customerName = customerInfoSnapshot.docs[0].get('Name');
    // }

    // Add the total price and cart items to the "Shopping Cart" collection
    await FirebaseFirestore.instance.collection('Shopping Cart').add({
      'totalPrice': totalPrice.toStringAsFixed(2),
      'subTotal': subtotal.toStringAsFixed(2),
      'timestamp': FieldValue.serverTimestamp(),
      'restaurantLocations': RestaurantID,
      'deliveryLocation': _selectedLocation,
      'cartItems': cartItems,
      'customerName': FirebaseAuth.instance.currentUser!.displayName,
      'OrderCompletion': false,
      'OrderStatus': false,
      'Order': 'Delivery'
    });

    // Delete all documents in the "cart" collection
    final cartDocs = await FirebaseFirestore.instance.collection('cart').get();
    for (DocumentSnapshot doc in cartDocs.docs) {
      await doc.reference.delete();
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

  //---------------------------------------------------------
  double getTotalPrice(QuerySnapshot cartSnapshot) {
    double totalPrice = 0;

    for (final DocumentSnapshot document in cartSnapshot.docs) {
      totalPrice += document.get('totalPrice');
    }

    return totalPrice;
  }

  double getSubTotal(QuerySnapshot cartSnapshot) {
    double subTotal = 0;

    for (final DocumentSnapshot document in cartSnapshot.docs) {
      subTotal += document.get('subTotal');
    }

    return subTotal;
  }
  //=-----------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 650,
        child: Column(children: [
          Expanded(
            child: StreamBuilder(
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
                        margin: const EdgeInsets.all(3),
                        child: ListTile(
                          title: Text(documentSnapshot['food']),
                          subtitle:
                              Text('\$${documentSnapshot['price'].toString()}'),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                Expanded(
                                  child: IconButton(
                                      icon: const Icon(Icons.add_outlined,
                                          color: Colors.deepOrange),
                                      onPressed: () =>
                                          addToCart(documentSnapshot)),
                                ),
                                Text('${documentSnapshot['quantity'] ?? 0}'),
                                Expanded(
                                  child: IconButton(
                                      icon: const Icon(Icons.remove_outlined),
                                      onPressed: () =>
                                          mainDelete(documentSnapshot)),
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
          ),
          // Row for dropdown menu and button
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dropdown menu
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _dropOffLocationsStream.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //         // Extract drop off locations from the snapshot
                      List<QueryDocumentSnapshot> dropOffLocations =
                          snapshot.data!.docs;
                      dropOffLocations = snapshot.data!.docs;

                      // Create a List of DropdownMenuItem widgets from the drop off locations
                      List<DropdownMenuItem<String>> dropDownItems = [
                        // Add a default or initial item to the dropdown menu
                        const DropdownMenuItem<String>(
                          //value: null, // or set the default value you want to use
                          child: Text(
                            'Select Location',
                            style: TextStyle(
                              color: projectRed,
                            ),
                          ), // Set the default or initial text
                        ),

                        ...dropOffLocations
                            .map((doc) => DropdownMenuItem<String>(
                                  value: doc.id,
                                  child: Text(doc['location']),
                                ))
                            .toList()
                      ];

                      return DropdownButton<String>(
                        items: dropDownItems,
                        value: _selectedLocation,
                        onChanged: (value) {
                          setState(() {
                            _selectedLocation = value;
                          });
                        },
                      );
                    } else if (snapshot.hasError) {
                      // Handle error if necessary
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Show loading indicator if data is not yet available
                      return CircularProgressIndicator(
                        color: projectRed,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          Container(
            height: 220.0,
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Subtotal",
                      style: TextStyle(
                          color: Color(0xFF9BA7C6),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('cart')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else {
                                final cartSnapshot = snapshot.data!;
                                final subTotal = getSubTotal(cartSnapshot);
                                return Text(
                                  "\$${subTotal.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      color: Color(0xFF6C6D6D),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text(
                      "Tax",
                      style: TextStyle(
                          color: Color(0xFF9BA7C6),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "% 9.5",
                      style: TextStyle(
                          color: Color(0xFF6C6D6D),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                //delete from here
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text(
                      "Delivery Fee",
                      style: TextStyle(
                          color: Color(0xFF9BA7C6),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$5.99",
                      style: TextStyle(
                          color: Color(0xFF6C6D6D),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                //---------------------------------------------------
                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  height: 2.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Total",
                      style: TextStyle(
                          color: Color(0xFF9BA7C6),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10),
                    //   child:
                    Row(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('cart')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(
                                color: projectRed,
                              );
                            } else {
                              final cartSnapshot = snapshot.data!;
                              final totalPrice = getTotalPrice(cartSnapshot);
                              return
                                  //Expanded(
                                  Text(
                                '\$${totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    color: Color(0xFF6C6D6D),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                                //  ),
                              );
                            }
                          },
                        ),
                      ],
                      //),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10.0,
                ),
                //new button ?
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return projectGrey;
                            }
                            return projectRed;
                          },
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                    side: BorderSide(color: projectRed)))),
                    onPressed: () {
                      addToShoppingCart();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DeliveryScreen()));
                    },
                    child: const Center(child: Text('Complete your Order!')),
                  ),
                ), //end of button
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
