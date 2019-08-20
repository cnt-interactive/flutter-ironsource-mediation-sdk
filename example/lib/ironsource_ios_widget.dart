import 'package:flutter/material.dart';
import 'package:ironsource_flutter_ads/IOS/ironsource_flutter.dart';

import 'constants.dart';
import 'main.dart';



class IronsourceIOSState extends State<MyApp> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  IronSourceBannerSize bannerSize;


  IronsourceInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();

    init();

    bannerSize = IronSourceBannerSize.BANNER;

    interstitialAd = IronsourceInterstitial(
      listener: (IronsourceAdEvent event, Map<String, dynamic> args) {
        if (event == IronsourceAdEvent.closed) {
          interstitialAd.load();
        }
        handleEvent(event, args, 'Interstitial');
      },
    );


    interstitialAd.load();
  }

  void init() async {

    await IronsourceFlutterAds.initialize(Constants.appID);
  }

  void handleEvent(
      IronsourceAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case IronsourceAdEvent.loaded:

        showSnackBar('New ironsource $adType Ad loaded!');
        break;
      case IronsourceAdEvent.opened:
        showSnackBar('ironsource $adType Ad opened!');
        break;
      case IronsourceAdEvent.closed:
        showSnackBar('ironsource $adType Ad closed!');
        break;
      case IronsourceAdEvent.shown:
        showSnackBar('ironsource $adType Ad shown!');
        break;
      case IronsourceAdEvent.failedToLoad:
        showSnackBar('ironsource $adType failed to load.');
        break;
      default:
    }
  }

  void showSnackBar(String content) {
    scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(content),
      duration: Duration(milliseconds: 1500),
    ));
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.lightBlue
      ),
      home: Scaffold(
          key: scaffoldState,
          appBar: AppBar(
            title: const Text('Ironsource Test',
              style: TextStyle(color: Colors.white),),
          ),

          body:  Column(
            children: <Widget>[
              Container(
                color: Colors.black12,
                margin: EdgeInsets.only(bottom: 20.0),
                child: IronSourceBanner(
                  adSize: bannerSize,
                  listener: (
                      IronsourceAdEvent event, Map<String, dynamic> args) {
                    handleEvent(event, args, 'Banner');
                  },
                ),
              ),
              Container(
                height: 30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: FlatButton(
                          color: Colors.lightBlue,
                          child: Text(
                            'Show Interstitial',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (await interstitialAd.isLoaded)
                              interstitialAd.show();
                            else
                              showSnackBar("Interstitial ad is still loading...");
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  @override
  void dispose() {

    super.dispose();
  }
}
