import 'package:ironsource_flutter_ads/android/ironsource.dart';
import 'package:ironsource_flutter_ads/android/ironsource_error.dart';

import 'package:ironsource_flutter_ads/helper/interstitial_abstract.dart';

class InterstitialHelperAndroid extends InterstitialAbstract
    with IronSourceListener {
  static InterstitialHelperAndroid _interstitialHelper;
  bool _canInterstitial = false;
  String _appId = "";
  String testID = "9b563ab5";

  String tag = "INTERSTITIAL_HELPER";

  factory InterstitialHelperAndroid(String appID) {
    return _interstitialHelper ??= InterstitialHelperAndroid._(appID);
  }

  InterstitialHelperAndroid._(String appID) {
    _appId = (appID != null) ? appID : testID;
    initIronSource();
  }

  void loadInterstitial() {
    IronSource.loadInterstitial();
  }

  void showInterstitial() async {
    if (await IronSource.isInterstitialReady()) {
      IronSource.showInterstitial();
    } else {
      print(
        "$tag Interstial is not ready. use 'Ironsource.loadInterstial' before showing it",
      );
    }
  }

  onPause() {
    IronSource.activityPaused();
  }

  onResume() {
    IronSource.activityResumed();
  }

  bool get canInterstitial => _canInterstitial;

  void initIronSource() async {
    print("$tag Okey");
    await IronSource.validateIntegration();
    await IronSource.initialize(appKey: _appId, listener: this);
    IronSource.loadInterstitial();
  }

  @override
  void onInterstitialAdClicked() {
    print("$tag onInterstitialAdClicked");
    _canInterstitial = false;
    loadInterstitial();
  }

  @override
  void onInterstitialAdClosed() {
    print("$tag onInterstitialAdClosed");
    _canInterstitial = false;
    loadInterstitial();
  }

  @override
  void onInterstitialAdLoadFailed(IronSourceError error) {
    print("$tag onInterstitialAdLoadFailed : ${error.toString()}");
    _canInterstitial = false;
  }

  @override
  void onInterstitialAdOpened() {
    print("$tag onInterstitialAdOpened");
    _canInterstitial = false;
  }

  @override
  void onInterstitialAdReady() {
    print("$tag onInterstitialReady");
    _canInterstitial = true;
  }

  @override
  void onInterstitialAdShowFailed(IronSourceError error) {
    print("$tag onInterstitialAdShowFailed : ${error.toString()}");
    _canInterstitial = false;
  }

  @override
  void onInterstitialAdShowSucceeded() {
    print("$tag InterstitialAdShowSucceeded");
  }

  @override
  bool isShow() {
    return _canInterstitial;
  }

  @override
  onDestroy() {
    return _interstitialHelper.onDestroy();
  }

  @override
  onShow() {
     IronSource.showInterstitial();
  }
}
