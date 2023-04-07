import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_captch/authentication/login.dart';

import 'package:google_captch/components/color.dart';

import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignIn1State();
}

class _SignIn1State extends State<SignUp> {
  bool _isHidden = true;
  void changeVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  String? confirmpassword;
  late String passwords;
  String text = '';
  double strength = 0;
  bool isObscure = true;

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  RegExp specialReg = RegExp(r".*[@,#,$,&,*,!,^].*");

  void checkPassword(String value) {
    passwords = value.trim();
    if (passwords.isEmpty) {
      setState(() {
        strength = 0;
        text = "please enter the passwords";
      });
    } else if (passwords.length < 6) {
      setState(() {
        strength = 1 / 4;
        text = "Your passwords is too short";
      });
    } else if (passwords.length < 8) {
      setState(() {
        strength = 2 / 4;
        text = "The passwords in llacceptable but not strong";
      });
    } else {
      if (!specialReg.hasMatch(passwords) || !numReg.hasMatch(passwords)) {
        setState(() {
          strength = 3 / 4;
          text =
              "Your Password is strong but missing special character or number";
        });
      } else {
        setState(() {
          strength = 1;
          text = "Your Password is Great";
          print('helo');
        });
      }
    }
  }

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String? _erroMessage;

  // register method
  Future<void> registerUser(String email, String password, String name) async {
    try {
      // await AuthenticationServices()
      //     .Signup(_emailController.text, _passwordController.text);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      userCredential.user!.updateDisplayName(name);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'name': name, 'email': email});
    } on FirebaseAuthException catch (e) {
      setState(() {
        _erroMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var hh = media.height;
    var ww = media.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: hh * 0.01,
          ),
          SizedBox(
            height: hh * 0.12,
            child: Row(
              children: [
                // Expanded(child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                ),
                Expanded(flex: 20, child: SizedBox()),
              ],
            ),
          ),
          // SizedBox(
          //   height: hh * 0.1,
          // ),

          SizedBox(
            height: hh * 0.1,
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                    flex: 6,
                    child: Text(
                      "Create Your Account",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    )),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
          //                                                                          user name

          SizedBox(
            height: hh * 0.06,
          ),
          Container(
            height: hh * 0.08,
            width: ww * 0.85,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 230, 223, 223),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'User name',
                    prefixIcon: SvgPicture.asset(
                      'assets/icons/user1.svg',
                      height: 20,
                      colorFilter:
                          ColorFilter.mode(primary_color, BlendMode.srcIn),
                    )),
              ),
            ),
          ),
          //
          SizedBox(
            height: hh * 0.03,
          ),
          //                                                                                  Email
          Container(
            height: hh * 0.08,
            width: ww * 0.85,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 230, 223, 223),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: primary_color,
                  ),
                ),
              ),
            ),
          ),
          //                                                                                        passwords
          SizedBox(
            height: hh * 0.03,
          ),
          Container(
            height: hh * 0.08,
            width: ww * 0.85,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 230, 223, 223),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: TextFormField(
                controller: _passwordController,
                onChanged: ((val) => checkPassword(val)),
                obscureText: _isHidden,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: primary_color, width: ww * 0.005),
                      borderRadius: BorderRadius.circular(15)),
                  border: InputBorder.none,
                  hintText: 'Password',
                  prefixIcon: Icon(
                    Icons.password,
                    color: primary_color,
                  ),
                  suffixIcon: IconButton(
                    onPressed: changeVisibility,
                    icon: _isHidden
                        ? Icon(
                            Icons.visibility_off,
                            color: primary_color,
                          )
                        : Icon(
                            Icons.visibility,
                            color: primary_color,
                          ),
                  ),
                ),
              ),
            ),
          ),
          //                                                                                  confirm passwords
          SizedBox(
            height: hh * 0.03,
          ),
          Container(
            height: hh * 0.08,
            width: ww * 0.85,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 230, 223, 223),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: TextFormField(
                controller: _confirmPasswordController,
                onChanged: (val) {
                  confirmpassword = val;
                },
                obscureText: _isHidden,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: primary_color, width: ww * 0.005),
                      borderRadius: BorderRadius.circular(15)),
                  border: InputBorder.none,
                  hintText: 'Confirm Password',
                  prefixIcon: Icon(
                    Icons.password,
                    color: primary_color,
                  ),
                  suffixIcon: IconButton(
                    onPressed: changeVisibility,
                    icon: _isHidden
                        ? Icon(
                            Icons.visibility_off,
                            color: primary_color,
                          )
                        : Icon(
                            Icons.visibility,
                            color: primary_color,
                          ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            height: hh * 0.03,
          ),
          Row(
            children: [
              Expanded(child: SizedBox()),
              Expanded(
                flex: 2,
                child: LinearProgressIndicator(
                    value: strength,
                    backgroundColor: Colors.grey,
                    color: strength <= 1 / 4
                        ? Colors.red
                        : strength == 2 / 4
                            ? Colors.yellow
                            : strength == 3 / 4
                                ? Colors.blue
                                : primary_color),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
          SizedBox(
            height: hh * 0.01,
          ),

          SizedBox(
            child: Row(children: [
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                  flex: 2,
                  child: Text(
                    text,
                    style: GoogleFonts.overpass(fontWeight: FontWeight.bold),
                  )),
              Expanded(
                child: SizedBox(),
              ),
            ]),
          ),
          //                                                                                      Sign in with passwords
          SizedBox(
            height: hh * 0.05,
          ),
          InkWell(
            onTap: strength < 1 / 2 ? null : () {},
            child: InkWell(
              onTap: () async {
                if (_erroMessage != null) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(_erroMessage!)));
                }
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => LogIn()));

                if (passwords == confirmpassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('passwords match'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  await registerUser(_emailController.text,
                      _passwordController.text, _userNameController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("User created Sucessfully")));

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogIn(),
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('passwords didnt march'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  ;
                }
              },
              child: Container(
                height: hh * 0.06,
                width: ww * 0.83,
                decoration: BoxDecoration(
                    color: primary_color,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "Sign up",
                    style: TextStyle(fontWeight: FontWeight.bold, color: white),
                  ),
                ),
              ),
            ),
          ),
          //                                                                                  dont have an acccount? sign up

          SizedBox(
            height: hh * 0.07,
          ),

          Row(
            children: [
              Expanded(child: SizedBox()),
              Expanded(flex: 3, child: Text("Already have an account?")),
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return LogIn();
                    },
                  ));
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: primary_color, fontWeight: FontWeight.bold),
                ),
              )),
              Expanded(child: SizedBox()),
            ],
          )
        ]),
      ),
    );
  }
}
