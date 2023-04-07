import 'package:flutter/material.dart';
import 'package:google_captch/splashScreen/splashScreen3.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen2> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var hh = media.height;
    var ww = media.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: hh * 0.03,
          ),
          Row(
            children: [
              Expanded(
                child: Image(image: AssetImage('assets/images/sc2.png')),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                flex: 12,
                child: Text(
                  "Welcome to Bobo, a great friend to chat with you",
                  style: TextStyle(fontSize: 37, fontWeight: FontWeight.bold),
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
                flex: 2,
                child: Container(
                  height: hh * 0.05,
                  width: ww * 0.5,
                  decoration: BoxDecoration(
                      color: Color(0xFF01D1c1),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Text(
                    "NEXT",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                  // child: ElevatedButton(onPressed: () {}, child: Text("NEXT")))
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
