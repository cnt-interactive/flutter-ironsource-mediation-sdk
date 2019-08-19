

import 'package:flutter/services.dart';

import 'package:ironsource_flutter_ads/IOS/ironsource_event_handler.dart';
import 'package:ironsource_flutter_ads/IOS/ironsource_events.dart';

class IronsourceInterstitial extends IronsourceEventHandler {
  static const MethodChannel _channel =
  const MethodChannel('ironsource_ads/interstitial');

  int id;
  MethodChannel _adChannel;
  final void Function(IronsourceAdEvent, Map<String, dynamic>) listener;

  IronsourceInterstitial({
    this.listener,
  }) : super(listener) {
    id = hashCode;
    if (listener != null) {
      _adChannel = MethodChannel('ironsource_ads/interstitial_$id');
      _adChannel.setMethodCallHandler(handleEvent);
    }
  }

  Future<bool> get isLoaded async {
    final bool result =
    await _channel.invokeMethod('isLoaded', <String, dynamic>{
      'id': id,
    });
    return result;
  }

  void load() async {
    await _channel.invokeMethod('load', <String, dynamic>{
      'id': id,
    });

    if (listener != null) {
      _channel.invokeMethod('setListener', <String, dynamic>{
        'id': id,
      });
    }else{
    }
  }

  void show() async {
    if (await isLoaded == true) {
      _channel.invokeMethod('show', <String, dynamic>{
        'id': id,
      });
    }
  }

  void dispose() async {
    await _channel.invokeMethod('dispose', <String, dynamic>{
      'id': id,
    });
  }
}
