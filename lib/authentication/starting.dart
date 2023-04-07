import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_captch/authentication/login.dart';
import 'package:google_captch/authentication/signup.dart';
import 'package:google_captch/components/color.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  @override
  State<StartingPage> createState() => _SignIn1State();
}

class _SignIn1State extends State<StartingPage> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var hh = media.height;
    var ww = media.width;
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: hh * 0.1,
        ),
        SizedBox(
          height: hh * 0.001,
          child: Row(
            children: [
              // Expanded(child: SizedBox()),
              Expanded(
                flex: 4,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      print("hello");
                    },
                    child: Icon(Icons.arrow_back)),
              ),
              Expanded(flex: 20, child: SizedBox()),
            ],
          ),
        ),
        // SizedBox(
        //   height: hh * 0.01,
        // ),
        SizedBox(
          height: hh * 0.27,
          child: Row(
            children: [
              Expanded(
                  child: Image(
                image: AssetImage('assets/images/nobg.png'),
              ))
            ],
          ),
        ),
        Row(
          children: [
            Expanded(child: SizedBox()),
            Expanded(
                flex: 3,
                child: Text(
                  "Let's you in",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                )),
            Expanded(child: SizedBox()),
          ],
        ),
        //                                                            facebook
        SizedBox(
          height: hh * 0.03,
        ),
        Container(
          height: hh * 0.06,
          width: ww * 0.85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: ww * 0.0004)),
          child: Row(children: [
            Expanded(child: SizedBox()),
            Expanded(
                child: SvgPicture.asset(
              'assets/icons/facebook.svg',
              height: 30,
            )),
            Expanded(
                flex: 3,
                child: Text(
                  "Continue with Facebook",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Expanded(child: SizedBox())
          ]),
        ),
        //                                                                                                google
        SizedBox(
          height: hh * 0.02,
        ),
        Container(
          height: hh * 0.06,
          width: ww * 0.85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: ww * 0.0004)),
          child: Row(children: [
            Expanded(child: SizedBox()),
            Expanded(
                child: SvgPicture.asset(
              'assets/icons/google.svg',
              height: 30,
            )),
            Expanded(
                flex: 3,
                child: Text(
                  "Continue with Google",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Expanded(child: SizedBox())
          ]),
        ),
        //                                                                                          apple

        SizedBox(
          height: hh * 0.02,
        ),
        Container(
          height: hh * 0.06,
          width: ww * 0.85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: ww * 0.0004)),
          child: Row(children: [
            Expanded(child: SizedBox()),
            Expanded(
                child: SvgPicture.asset(
              'assets/icons/apple.svg',
              height: 30,
            )),
            Expanded(
                flex: 3,
                child: Text(
                  "Continue with Apple",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Expanded(child: SizedBox())
          ]),
        ),
        SizedBox(
          height: hh * 0.06,
        ),
        //                                                                                  or
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
                    border: Border.all(color: Colors.black, width: ww * 0.001)),
              )),
          Expanded(
              child: Center(
            child: Text('or'),
          )),
          Expanded(
              flex: 2,
              child: Container(
                height: hh * 0.001,
                width: ww * 0.02,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: ww * 0.001)),
              )),
          Expanded(
            child: SizedBox(),
          ),
        ]),

        //                                                                                      Sign in with password
        SizedBox(
          height: hh * 0.05,
        ),
        Container(
          height: hh * 0.06,
          width: ww * 0.83,
          decoration: BoxDecoration(
              color: primary_color, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return LogIn();
                  },
                ));
              },
              splashColor: Colors.grey,
              child: Text(
                "Sign in with password",
                style: TextStyle(fontWeight: FontWeight.bold, color: white),
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
            Expanded(flex: 2, child: Text("Dont' have an account?")),
            Expanded(
                child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SignUp();
                  },
                ));
              },
              child: Text(
                " Sign Up",
                style: TextStyle(
                    color: primary_color,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            )),
            Expanded(child: SizedBox()),
            
          ],
        )
      ]),
    );
  }
}
