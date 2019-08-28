# Ironsource Flutter Mediation SDK

A Flutter plugin that uses native platform views (IOS & Android) to show IronSource banner and interstitial ads!


</br></br>

<img width="300" alt="portfolio_view" src="https://live.staticflickr.com/65535/48574710632_fd7f318277_b.jpg">&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<img width="300" alt="portfolio_view" src="https://media.giphy.com/media/jqwcyovkVTiiDl9ZKh/giphy.gif"></br></br>


# Getting Started 🚀

<b>1. Initialize the plugin: </b>

<h2>Android Installing</h2>

<h3>Manifest Permissions # </h3>

Add the following permissions to your AndroidManifest.xml file inside the manifest tag but outside the <application> tag:

```dart
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```
<h3>Manifest Activities # </h3>
Add the following activities inside the <application> tag in your AndroidManifest:

```dart
    <activity
                android:name="com.ironsource.sdk.controller.ControllerActivity"
                android:configChanges="orientation|screenSize"
                android:hardwareAccelerated="true" />
    <activity
                android:name="com.ironsource.sdk.controller.InterstitialActivity"
                android:configChanges="orientation|screenSize"
                android:hardwareAccelerated="true"
                android:theme="@android:style/Theme.Translucent" />
    <activity
                android:name="com.ironsource.sdk.controller.OpenUrlActivity"
                android:configChanges="orientation|screenSize"
                android:hardwareAccelerated="true"
                android:theme="@android:style/Theme.Translucent" />
```

<h3>Create object</h3>

```dart
    String testAppId = "9b563ab5";
    InterstitialHelper interstitialHelper = InterstitialHelper(testAppId);
```

<b>3. Show Interstitial Ads</b>

* Show Interstitial Ad:

```dart

   //interstitial ready is can show?

   if(interstitialHelper.isShow()){
   interstitialHelper.onShow();
   }

```

 </br></br>

<b> 3. Interstitial Methods </b>

*Methods InterstitialHelper

```dart

   //onPause interstitial just work Android

   interstitialHelper.onPause();

   //onResume interstitial just work Android

   interstitialHelper.onResume();

   //onDestroy interstitial

   interstitialHelper.onDestroy();

```

<b>2. Show Banner Ad:</b>

```dart
  IronSourceBanner(
      adSize: bannerSize,
      listener: (
        IronsourceAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
       },
     ),
```




# Future Work
* Implement for type of rewarded and offerwall ads.


