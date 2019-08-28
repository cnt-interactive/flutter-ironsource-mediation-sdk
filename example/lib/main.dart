import 'package:flutter/material.dart';
import 'package:ironsource_flutter_ads/helper/ironsource_interstitial_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InterstitialHelper interstitialHelper = InterstitialHelper("9b563ab5");

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: RaisedButton(onPressed: () {
              if (interstitialHelper.isShow()) {
                interstitialHelper.onShow();
              }
            }),
          ),
        ),
      ),
    );
  }
}
