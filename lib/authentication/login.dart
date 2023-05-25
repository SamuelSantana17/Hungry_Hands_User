import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hungry_hands/palette.dart';
import 'package:hungry_hands/screens/home_screen.dart';
import 'package:hungry_hands/services/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            projectRed,
            projectWhite,
            projectWhite,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              width: 250,
              height: 110,
              fit: BoxFit.fill,
              image: NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/hungryhands-69809.appspot.com/o/hungryhandsLogo.jpg?alt=media&token=824ce48a-2e33-438a-82d8-45415bb8a110"),
            ),
            Container(
              //alignment: AlignmentDirectional.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseServices().signInWithGoogle();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return projectRed;
                      }
                      return Colors.white;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: projectRed)))),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                        image: AssetImage("images/google.png"),
                        height: 40,
                        width: 40,
                        // image: Null,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Login with Gmail",
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
