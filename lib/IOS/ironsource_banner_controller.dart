import 'package:flutter/services.dart';
import 'package:ironsource_flutter_ads/IOS/ironsource_event_handler.dart';
import 'package:ironsource_flutter_ads/IOS/ironsource_events.dart';

class IronsourceBannerController extends IronsourceEventHandler {
  final MethodChannel _channel;

  IronsourceBannerController(int id, Function(IronsourceAdEvent, Map<String, dynamic>) listener)
      : _channel = MethodChannel('ironsource_ads/banner_$id'),
        super(listener) {
    if (listener != null) {
      _channel.setMethodCallHandler(handleEvent);
      _channel.invokeMethod('setListener');
    }
  }

  void dispose() {
    _channel.invokeMethod('dispose');
  }
}
