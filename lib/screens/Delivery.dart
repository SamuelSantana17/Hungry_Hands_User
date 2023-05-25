import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry_hands/authentication/login.dart';

import 'home_screen.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    () {
      Get.to(const LoginScreen());
    };
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(219, 9, 9, 10),
          image: DecorationImage(
            image:
                AssetImage("images/image_processing20191006-13674-14onvms.gif"),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Thank you for your Order",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(
              height: 260,
              width: 5,
              //style: GoogleFonts.lemon(textStyle: kBodyText),
            ),

            //add more login and sign up options, maybe ?
            Container(
              //alignment: AlignmentDirectional.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.black;
                  }
                  return Colors.white;
                })),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Return to Home",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
