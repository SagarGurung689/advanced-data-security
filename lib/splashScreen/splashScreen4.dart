import 'package:flutter/material.dart';
import 'package:google_captch/authentication/starting.dart';

class SplashScreen4 extends StatefulWidget {
  const SplashScreen4({super.key});

  @override
  State<SplashScreen4> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen4> {
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
            height: hh * 0.01,
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
                flex: 15,
                child: Wrap(
                  children: [
                    Text(
                      "Bobo will be ready to chat and make you happy",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          SizedBox(
            height: hh * 0.122,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return StartingPage();
                      },
                    ));
                  },
                  child: Container(
                    height: hh * 0.05,
                    width: ww * 0.5,
                    decoration: BoxDecoration(
                        color: Color(0xFF01D1c1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                      "Get Started ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                    // child: ElevatedButton(onPressed: () {}, child: Text("NEXT")))
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
