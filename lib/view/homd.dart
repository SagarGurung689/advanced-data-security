import 'package:flutter/material.dart';

import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: WebViewPlus(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controllerPlus) {
                controllerPlus.loadUrl('assets/webpages/index.html');
              },
              javascriptChannels: Set.from([
                JavascriptChannel(
                    name: "Captcha",
                    onMessageReceived: (JavascriptMessage message) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ));
                    })
              ])),
        ),
      ),
    );
  }
}
