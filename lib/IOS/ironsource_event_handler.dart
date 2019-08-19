import 'package:flutter/services.dart';

import 'package:ironsource_flutter_ads/IOS/ironsource_events.dart';
export 'package:ironsource_flutter_ads/IOS/ironsource_banner.dart';

abstract class IronsourceEventHandler {
  final Function(IronsourceAdEvent, Map<String, dynamic>) _listener;

  IronsourceEventHandler(Function(IronsourceAdEvent, Map<String, dynamic>) listener) : _listener = listener;

  Future<dynamic> handleEvent(MethodCall call) async {
    switch (call.method) {
      case 'loaded':
        _listener(IronsourceAdEvent.loaded, null);
        break;
      case 'failedToLoad':
        _listener(IronsourceAdEvent.failedToLoad, Map<String, dynamic>.from(call.arguments));
        break;
      case 'clicked':
        _listener(IronsourceAdEvent.clicked, null);
        break;
      case 'impression':
        _listener(IronsourceAdEvent.impression, null);
        break;
      case 'opened':
        _listener(IronsourceAdEvent.opened, null);
        break;
      case 'leftApplication':
        _listener(IronsourceAdEvent.leftApplication, null);
        break;
      case 'closed':
        _listener(IronsourceAdEvent.closed, null);
        break;
      case 'shown':
        _listener(IronsourceAdEvent.shown, null);
        break;
      case 'completed':
        _listener(IronsourceAdEvent.completed, null);
        break;

      case 'started':
        _listener(IronsourceAdEvent.started, null);
        break;














    }

    return null;
  }
}
