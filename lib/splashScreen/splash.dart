import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_captch/authentication/starting.dart';

import 'package:google_captch/view/homepage.dart';
import 'package:google_captch/splashScreen/splashScreen1.dart';
import 'package:google_captch/splashScreen/splashScreen2.dart';
import 'package:google_captch/splashScreen/splashScreen3.dart';
import 'package:google_captch/splashScreen/splashScreen4.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<Color> _dotColors = [
    Color(0xFF01D1c1),
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];
  int _currentPageIndex = 0;
  String? _message;
  @override
  void initState() {
    super.initState();
    // Timer(
    //     Duration(seconds: 4),
    //     () => Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => HomePage(),
    //         )));
    _message = "hello World";
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPageIndex < 3) {
        _currentPageIndex++;
      } else {
        timer.cancel();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StartingPage(),
            ));
      }
      _pageController.animateToPage(_currentPageIndex,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var hh = media.height;
    var ww = media.width;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //     title: Center(
        //   child: Text("hellod"),
        // )),
        body: Stack(children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentPageIndex = index;
                _updateDotColors();
              });
            },
            children: [
              SplashScreen1(),
              SplashScreen2(),
              SplashScreen3(),
              SplashScreen4(),
              // // _buildSplashScreenPage('Splash Screen 1', Colors.green),
              // // _buildSplashScreenPage('Splash Screen 2', Colors.blue),
              // _buildSplashScreenPage('Splash Screen 3', Colors.red),
            ],
          ),
          Positioned(
            left: ww * 0.3,
            right: 0,
            bottom: hh * 0.13,
            child: Container(
              height: hh * 0.004,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _dotColors.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: ww * 0.06,
                    // height: hh * 0.002,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: _dotColors[index],
                    ),
                  );
                },
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildSplashScreenPage(String text, Color color) {
    return Container(
      color: color,
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
      )),
    );
  }

  void _updateDotColors() {
    for (int i = 0; i < _dotColors.length; i++) {
      if (i == 0) {
        _dotColors[i] = Colors.transparent;
      } else if (i == _currentPageIndex) {
        _dotColors[i] = Color(0xFF01D1c1);
      } else {
        _dotColors[i] = Colors.grey;
      }
    }
  }
}
