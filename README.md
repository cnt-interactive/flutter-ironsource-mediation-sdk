# ironsource_flutter_ads

A Flutter plugin that uses native platform views (IOS & Android) to show IronSource banner and interstitial ads!


xxx 🚀</br></br>

<img width="300" alt="portfolio_view" src="https://live.staticflickr.com/65535/48574710632_fd7f318277_b.jpg">&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<img width="300" alt="portfolio_view" src="https://media.giphy.com/media/jqwcyovkVTiiDl9ZKh/giphy.gif">


# Getting Started

1. Initialize the plugin: 

```dart
 IronsourceFlutterAds.initialize(Constants.appID);
```

2. Show Banner Ad:

```dart
  IronSourceBanner(
      adSize: bannerSize,
      listener: (
        IronsourceAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
       },
     ),
```

3. Show Interstitial Ad:

```dart
 interstitialAd = IronsourceInterstitial(
      listener: (IronsourceAdEvent event, Map<String, dynamic> args) {
        if (event == IronsourceAdEvent.closed) {
          interstitialAd.load();
        }
        handleEvent(event, args, 'Interstitial');
      },
    );


    interstitialAd.load();
```

```dart
  if (await interstitialAd.isLoaded){
      interstitialAd.show();
  }                        
```






Call FacebookAudienceNetwork.init() during app initialization.



This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
# ironsource-mediation-sdk
# ironsource-mediation-sdk
