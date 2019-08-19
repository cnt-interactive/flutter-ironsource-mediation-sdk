import 'dart:async';

import 'package:flutter/services.dart';

class IronsourceFlutterAds {

  IronsourceFlutterAds.initialize(String appId) {
    MethodChannel _channel = const MethodChannel('ironsource_ads');
    _channel.invokeMethod('initialize', appId);
  }

}


