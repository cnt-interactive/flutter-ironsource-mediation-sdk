import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ironsource_flutter_ads_example/ironsource_android_widget.dart';
import 'package:ironsource_flutter_ads/IOS/ironsource_flutter.dart';

import 'ironsource_ios_widget.dart';


void main() {

  runApp(MyApp());
}



class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    if (defaultTargetPlatform == TargetPlatform.android) {

      return IronsourceAndroidState();
    }else if (defaultTargetPlatform == TargetPlatform.iOS){

      return IronsourceIOSState();
    }

    return null;
  }



}

