
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ironsource_flutter_ads/android/ironsource.dart';
import 'package:ironsource_flutter_ads/android/ironsource_error.dart';

import 'constants.dart';
import 'main.dart';


class IronsourceAndroidState extends State<MyApp> with IronSourceListener , IronSourceBannerListener, WidgetsBindingObserver{

  bool bannerReady = false,
      interstitialReady = true;
  @override
  void initState() {

    print("ppppp onur0");
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    init();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {


    print("ppppp onur1");
    switch(state){

      case AppLifecycleState.resumed:
        IronSource.activityResumed();
        break;
      case AppLifecycleState.inactive:
      // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
      // TODO: Handle this case.
        IronSource.activityPaused();
        break;
      case AppLifecycleState.suspending:
      // TODO: Handle this case.
        break;
    }
  }

  void init() async {

    await IronSource.validateIntegration();
    await IronSource.initialize(appKey: Constants.appID, listener: this);
    bannerReady = true;
    IronSource.loadInterstitial();
    setState(() {});
  }



  void showInterstitial() async {
    if (await IronSource.isInterstitialReady()) {
      IronSource.showInterstitial();
    } else {
      print(
        "Interstial is not ready. use 'Ironsource.loadInterstial' before showing it",
      );
    }
  }




  @override
  Widget build(BuildContext context) {


    print("ppppp onu4444");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Ironsource Test'),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  bannerReady?
                  Align(
                    alignment: Alignment.topCenter,
                    child: IronSourceBannerAd(
                        keepAlive: true, listener: this),
                  ):Container(),


                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FlatButton(
                        color: Colors.lightBlue,
                        child: Text(
                          'Show Interstitial',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: interstitialReady ? showInterstitial : null,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                    ),



                ],
              ),
            ),
// Banner ad

          ],
        ),
      ),
    );
  }

  @override
  void onInterstitialAdClicked() {
    print("onInterstitialAdClicked");
  }

  @override
  void onInterstitialAdClosed() {
    print("onInterstitialAdClosed");
  }

  @override
  void onInterstitialAdLoadFailed(IronSourceError error) {
    print("onInterstitialAdLoadFailed : ${error.toString()}");
  }

  @override
  void onInterstitialAdOpened() {
    print("onInterstitialAdOpened");
      interstitialReady = false;


  }

  @override
  void onInterstitialAdReady() {
    print("onInterstitialAdReady");
      interstitialReady = true;

  }

  @override
  void onInterstitialAdShowFailed(IronSourceError error) {

    print("onInterstitialAdShowFailed : ${error.toString()}");
      interstitialReady = false;
  }

  @override
  void onInterstitialAdShowSucceeded() {
    print("nInterstitialAdShowSucceeded");
  }



  @override
  void onBannerAdClicked() {
    // TODO: implement onBannerAdClicked
  }

  @override
  void onBannerAdLeftApplication() {
    // TODO: implement onBannerAdLeftApplication
  }

  @override
  void onBannerAdLoadFailed(Map<String, dynamic> error) {
    // TODO: implement onBannerAdLoadFailed
  }

  @override
  void onBannerAdLoaded() {
    // TODO: implement onBannerAdLoaded
  }

  @override
  void onBannerAdScreenDismissed() {
    // TODO: implement onBannerAdScreenDismissed
  }

  @override
  void onBannerAdScreenPresented() {
    // TODO: implement onBannerAdScreenPresented
  }

}