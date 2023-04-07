import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_captch/authentication/signup.dart';

import 'package:google_captch/components/color.dart';
import 'package:google_captch/forgotPassword/forgot_password.dart';
import 'package:google_captch/view/homd.dart';
import 'package:google_captch/view/homepage.dart';
import 'package:google_captch/services/authentication_services.dart';
import 'package:google_captch/viewModel/userProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _SignIn1State();
}

class _SignIn1State extends State<LogIn> {
  bool _isHidden = true;
  void changeVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  String? _email;
  String? _password;

  String? confirmpassword;
  late String password;
  String text = '';
  double strength = 0;
  bool isObscure = true;
  bool isChecked = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  void readUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');
    if (mounted && savedEmail != null && savedPassword != null) {
      setState(() {
        isChecked = true;
        _emailController.text = savedEmail;
        _passwordController.text = savedPassword;
      });
    } else if (mounted) {
      setState(() {
        isChecked = false;
      });
    }
  }

  // to save uwer

  void saveEmailandPassword(String? name, String? password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // save the value from each controller

    await prefs.setString('email', _emailController.text);
    await prefs.setString('password', _passwordController.text);
  }

  // this is the shared preferences that delete the temporary data
  void deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  String? errorMessage;

  Future<void> logIn() async {
    // we add code in try can block where error can handle

    try {
      await AuthenticationServices()
          .SignIn(_emailController.text, _passwordController.text);
    } on FirebaseException catch (e) {
      setState(() {
        //to check erro in debug console

        errorMessage = e.message;
      });
    }
  }

  bool _isCaptchaVerified = false;
  bool 
  _canNavigate = false;

  @override
  void initState() {
    readUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var hh = media.height;
    var ww = media.width;
    return Scaffold(
        body: Consumer<LoginProvider>(builder: (context, LoginProvider, child) {
      return SingleChildScrollView(
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
                      "Login to your Account",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                    )),
                Expanded(child: SizedBox()),
              ],
            ),
          ),

          //
          SizedBox(
            height: hh * 0.05,
          ),
          //                                                                                  Email
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: hh * 0.08,
                  width: ww * 0.85,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 230, 223, 223),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: TextFormField(
                      onChanged: (value) {
                        _email = value;
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: primary_color,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        } else if (!value.contains("@")) {
                          return "Please enter a valid email";
                        }

                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: hh * 0.03,
                ),

                ///                                                                                         password section
                Container(
                  height: hh * 0.08,
                  width: ww * 0.85,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 230, 223, 223),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: TextFormField(
                      onChanged: (value) {
                        _password = value;
                      },
                      controller: _passwordController,
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: primary_color, width: ww * 0.005),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }

                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          //                                                                                        password
          SizedBox(
            height: hh * 0.03,
          ),

          SizedBox(
            height: hh * 0.02,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: ww * 0.08),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: ww * 0.001),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: Color(0xFFB19E90),
                        ),
                        child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: Color(0xFFB19E90),
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                                if (isChecked) {
                                  saveEmailandPassword(_email, _password);
                                } else {
                                  deleteUser();
                                  _emailController.clear();
                                  _passwordController.clear();
                                }
                              });
                            }),
                      ),
                    ),
                    Text('Remember me',
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ))
                  ],
                ),
              ),
              SizedBox(
                width: ww * 0.1,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('verify you are human'),
                        content: Container(
                          width: double.maxFinite,
                          height: 400,
                          child: WebViewPlus(
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated: (controllerPlus) {
                              controllerPlus
                                  .loadUrl('assets/webpages/index.html');
                            },
                            javascriptChannels: Set.from([
                              JavascriptChannel(
                                  name: "Captcha",
                                  onMessageReceived:
                                      (JavascriptMessage message) {
                                    setState(() {
                                      _isCaptchaVerified = true;
                                    });
                                  })
                            ]),
                            onPageFinished: (url) {},
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                    padding: EdgeInsets.only(left: ww * 0.12),
                    child: SvgPicture.asset(
                      'assets/icons/captcha.svg',
                      height: hh * 0.05,
                    )),
              ),
            ],
          ),
          //                                                                                      Sign in with password
          SizedBox(
            height: hh * 0.05,
          ),
          InkWell(
            onTap: strength < 1 / 2 ? null : () {},
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ));
              },
              child: InkWell(
                onTap: () async {
                  if (!_isCaptchaVerified) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Please fill the captcha')));
                    return;
                  }
                  _canNavigate = true;
                  await logIn();
                  if (errorMessage != null) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(errorMessage!)));
                    _canNavigate = false;
                  } else {
                    LoginProvider.setIslogin(true);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Login Succesfully")));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
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
                      "Log In",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: hh * 0.04,
          ),
          //                                                                              forgot password
          Row(
            children: [
              Expanded(child: SizedBox()),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ForgotPassword();
                      },
                    ));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: ww * 0.12),
                    child: Text(
                      'Forgot the password?',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                          color: primary_color,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Expanded(child: SizedBox())
            ],
          ),
          SizedBox(
            height: hh * 0.04,
          ),
          //                                                                              or continue with
          Row(children: [
            Expanded(
              child: SizedBox(),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  height: hh * 0.001,
                  width: ww * 0.02,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.black, width: ww * 0.001)),
                )),
            Expanded(
                flex: 4,
                child: Center(
                  child: Text(
                    'or continue with',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  height: hh * 0.001,
                  width: ww * 0.02,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.black, width: ww * 0.001)),
                )),
            Expanded(
              child: SizedBox(),
            ),
          ]),
          SizedBox(
            height: hh * 0.03,
          ),

          //

          Row(
            children: [
              Expanded(flex: 2, child: SizedBox()),
              Expanded(
                  flex: 3,
                  child: Container(
                    height: hh * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(color: Colors.grey, width: ww * 0.002)),
                    child: SvgPicture.asset('assets/icons/facebook.svg'),
                  )),
              Expanded(child: SizedBox()),
              Expanded(
                  flex: 3,
                  child: Container(
                    height: hh * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(color: Colors.grey, width: ww * 0.002)),
                    child: SvgPicture.asset('assets/icons/google.svg'),
                  )),
              Expanded(child: SizedBox()),
              Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(color: Colors.grey, width: ww * 0.002)),
                    height: hh * 0.06,
                    child: Container(
                      height: hh * 0.01,
                      child: SvgPicture.asset(
                        'assets/icons/apple.svg',
                        height: hh * 0.01,
                      ),
                    ),
                  )),
              Expanded(flex: 2, child: SizedBox()),
            ],
          ),

          //                                                                                  dont have an acccount? sign up

          SizedBox(
            height: hh * 0.07,
          ),

          Row(
            children: [
              Expanded(flex: 2, child: SizedBox()),
              Expanded(flex: 4, child: Text("Don't have an account?")),
              Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SignUp();
                        },
                      ));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: primary_color, fontWeight: FontWeight.bold),
                    ),
                  )),
              Expanded(child: SizedBox()),
            ],
          )
        ]),
      );
    }));
  }
}
