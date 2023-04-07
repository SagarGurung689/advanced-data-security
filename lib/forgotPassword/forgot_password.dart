import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_captch/components/color.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _errorMessage;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var hh = media.height;
    var ww = media.width;
    return Scaffold(
      // backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: hh * 0.08,
          ),
          //                                                                                    arrow + forgot password
          Row(
            children: [
              Expanded(child: Icon(Icons.arrow_back)),
              Expanded(
                flex: 2,
                child: Text(
                  "Forgot Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Expanded(flex: 2, child: SizedBox())
            ],
          ),
          SizedBox(
            height: hh * 0.01,
          ),

          SizedBox(
            height: hh * 0.3,
            width: ww * 1,
            child: Row(
              children: [
                Expanded(
                    child: Image(
                  image: AssetImage('assets/images/nobg.png'),
                ))
              ],
            ),
          ),
          SizedBox(
            height: hh * 0.06,
            child: Row(children: [
              Expanded(child: SizedBox()),
              Expanded(
                flex: 8,
                child: Text(
                  'please enter your email  to reset your password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Expanded(child: SizedBox()),
            ]),
          ),

          SizedBox(
            height: hh * 0.05,
          ),
          //                                                                                                enter your email
          Row(
            children: [
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                flex: 15,
                child: Container(
                  height: hh * 0.10,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: primary_color, width: hh * 0.003),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: primary_color,
                          ),
                          hintText: "Enter your email",
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          SizedBox(
            height: hh * 0.1,
          ),

          Row(
            children: [
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                flex: 10,
                child: InkWell(
                  onTap: () async {
                    await resetPassword(_emailController.text);
                    if (_errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(_errorMessage!)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("reset email send to your email")));
                    }
                  },
                  child: Container(
                    height: hh * 0.07,
                    decoration: BoxDecoration(
                        color: primary_color,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      "Continure",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    )),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
