import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_captch/authentication/login.dart';

import 'package:google_captch/services/authentication_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var hh = media.height;
    var ww = media.width;
    return Scaffold(
        appBar: AppBar(
            title: Center(
          child: Text("HomagePage"),
        )),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(
                    height: hh * 0.07,
                  ),
                  SizedBox(
                    height: hh * 0.3,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Image(
                            image: AssetImage(
                              'assets/images/welcome_bg.png',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Welcome,${snapshot.data!['name'].toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        Expanded(child: SizedBox())
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        AuthenticationServices().Signout();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Logout Successfully")));
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return LogIn();
                          },
                        ));
                      },
                      child: Text("Log Out")),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
