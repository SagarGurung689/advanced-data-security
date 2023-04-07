import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FillYourProfile extends StatefulWidget {
  const FillYourProfile({super.key});

  @override
  State<FillYourProfile> createState() => _FillYourProfileState();
}

class _FillYourProfileState extends State<FillYourProfile> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var hh = media.height;
    var ww = media.width;
    return Scaffold(
      body: Column(children: [
        Row(
          children: [
            Expanded(
              child: Icon(Icons.arrow_back),
            ),
            Expanded(child: Text("Fill Your Profile"),)
          ],
        )
      ]),
    );
  }
}
