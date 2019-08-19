import 'dart:async';

import 'package:flutter/services.dart';
import 'Ironsource_consts.dart';
import 'ironsource_error.dart';
import 'ironsource_error.dart';
export 'ironsource_banner.dart';

class IronSource {
  static const MethodChannel _channel = MethodChannel("com.spt.ironsource");
  static IronSourceListener _listener;
  static IronSourceListener getListener() {
    return _listener;
  }

  static Future<Null> initialize(
      {final String appKey, final IronSourceListener listener}) async {
    _listener = listener;
    _channel.setMethodCallHandler(_listener._handle);
    await _channel.invokeMethod('initialize', {'appKey': appKey});
  }


  static Future<Null> validateIntegration() async {
    await _channel.invokeMethod('validateIntegration');
  }




  static Future<Null> loadInterstitial() async {
    await _channel.invokeMethod('loadInterstitial');
  }

  static Future<Null> showInterstitial() async {
    await _channel.invokeMethod('showInterstitial');
  }



  static Future<bool> isInterstitialReady() async {
    return await _channel.invokeMethod('isInterstitialReady');
  }

  static Future<Null> activityResumed() async {
    await _channel.invokeMethod('onResume');
  }

  static Future<Null> activityPaused() async {
    await _channel.invokeMethod('onPause');
  }


}

abstract class IronSourceListener {
  Future<Null> _handle(MethodCall call) async {

//    interstitial
     if (call.method == INTERSTITIAL_CLICKED)
      onInterstitialAdClicked();
    else if (call.method == INTERSTITIAL_CLOSED)
      onInterstitialAdClosed();
    else if (call.method == INTERSTITIAL_OPENED)
      onInterstitialAdOpened();
    else if (call.method == INTERSTITIAL_READY)
      onInterstitialAdReady();
    else if (call.method == INTERSTITIAL_SHOW_SUCCEEDED)
      onInterstitialAdShowSucceeded();
    else if (call.method == INTERSTITIAL_LOAD_FAILED)
      onInterstitialAdLoadFailed(IronSourceError(
          errorCode: call.arguments["errorCode"],
          errorMessage: call.arguments["errorMessage"]));
    else if (call.method == INTERSTITIAL_SHOW_FAILED)
      onInterstitialAdShowFailed(IronSourceError(
          errorCode: call.arguments["errorCode"],
          errorMessage: call.arguments["errorMessage"]));
  }



  // Interstitial
  void onInterstitialAdClicked();

  void onInterstitialAdReady();

  void onInterstitialAdLoadFailed(IronSourceError error);

  void onInterstitialAdOpened();

  void onInterstitialAdClosed();

  void onInterstitialAdShowSucceeded();

  void onInterstitialAdShowFailed(IronSourceError error);
}
