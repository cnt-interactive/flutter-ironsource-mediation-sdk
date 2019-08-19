import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ironsource_flutter_ads/IOS/ironsource_flutter_ads.dart';

void main() {
  const MethodChannel channel = MethodChannel('ironsource_flutter_ads');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  //test('getPlatformVersion', () async {
    //expect(await IronsourceFlutterAds.platformVersion, '42');
  //});
}
