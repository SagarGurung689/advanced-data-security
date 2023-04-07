import 'package:flutter/material.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var hh = media.height;
    var ww = media.width;
    return Scaffold(
      backgroundColor: Color(0xFF01D1c1),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: hh * 0.04,
          ),
          Row(
            children: [
              Expanded(
                child: Image(image: AssetImage('assets/images/sc1.png')),
              )
            ],
          )
        ]),
      ),
    );
  }
}
