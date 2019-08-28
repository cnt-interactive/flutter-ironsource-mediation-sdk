import 'package:ironsource_flutter_ads/IOS/ironsource_events.dart';
import 'package:ironsource_flutter_ads/IOS/ironsource_flutter_ads.dart';
import 'package:ironsource_flutter_ads/IOS/ironsource_interstitial.dart';
import 'package:ironsource_flutter_ads/helper/interstitial_abstract.dart';

class InterstitialHelperIos extends InterstitialAbstract {
  static InterstitialHelperIos _interstitialHelper;
  String appID = "";
  String tag = "InterstitialHelperIOS";
  IronsourceInterstitial _interstitialAd;
  bool _canInterstitial = false;

  factory InterstitialHelperIos(String s) {
    return _interstitialHelper ??= InterstitialHelperIos._(s);
  }

  InterstitialHelperIos._(String appID) {
    this.appID = appID;
    IronsourceFlutterAds.initialize(appID);
    createInterstitial();
  }

  createInterstitial() {
    _interstitialAd = IronsourceInterstitial(
      listener: (IronsourceAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Interstitial');
      },
    );
  }

  void handleEvent(
      IronsourceAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case IronsourceAdEvent.loaded:
        print(' $tag New ironsource $adType Ad loaded!');
        _canInterstitial = true;
        break;
      case IronsourceAdEvent.opened:
        print(' $tag ironsource $adType Ad opened!');
        _canInterstitial = false;
        createInterstitial()..load();
        break;
      case IronsourceAdEvent.closed:
        print(' $tag ironsource $adType Ad closed!');
        _canInterstitial = false;
        createInterstitial()..load();
        break;
      case IronsourceAdEvent.shown:
        print(' $tag ironsource $adType Ad shown!');
        _canInterstitial = false;
        createInterstitial()..load();
        break;
      case IronsourceAdEvent.failedToLoad:
        print(' $tag ironsource $adType failed to load.');
        _canInterstitial = false;
        createInterstitial()..load();
        break;
      default:
    }
  }

  void showInterstitial() async {
    if (_interstitialAd == null) return;
    if (_canInterstitial) createInterstitial();
    if (await _interstitialAd.isLoaded) _interstitialAd.show();
  }

  @override
  onDestroy() {
    _interstitialAd.dispose();
  }

  @override
  onPause() {
    return;
  }

  @override
  onResume() {
    return;
  }

  @override
  onShow() {
    showInterstitial();
    return null;
  }

  @override
  bool isShow() {
    // TODO: implement isShow
    return _canInterstitial;
  }
}
