import 'dart:io';

import 'package:ironsource_flutter_ads/helper/interstitial_abstract.dart';

import 'package:ironsource_flutter_ads/helper/interstitial_helper_android.dart';
import 'package:ironsource_flutter_ads/helper/interstitial_helper_ios.dart';

class InterstitialHelper {
  static InterstitialHelper _interstitialHelper;
  InterstitialAbstract _interstitialAbstract;

  String _appId = "";
  String testID = "9b563ab5";

  factory InterstitialHelper(String appID) {
    return _interstitialHelper ??= InterstitialHelper._(appID);
  }

  InterstitialHelper._(appID) {
    _appId = (appID != null) ? appID : testID;
    createInterstitial();
  }

  void createInterstitial() {
    if (Platform.isAndroid) {
      _interstitialAbstract = InterstitialHelperAndroid(_appId);
    } else if (Platform.isIOS) {
      _interstitialAbstract = InterstitialHelperIos(_appId);
    } else {
      print("Sorry! 'e can't support your platform");
    }
  }

  onShow() {
    _interstitialAbstract?.onShow();
  }

  onPause() {
    _interstitialAbstract?.onPause();
  }

  onResume() {
    _interstitialAbstract?.onResume();
  }

  onDestroy() {
    _interstitialAbstract?.onDestroy();
  }

  bool isShow() {
    return _interstitialAbstract?.isShow();
  }
}
