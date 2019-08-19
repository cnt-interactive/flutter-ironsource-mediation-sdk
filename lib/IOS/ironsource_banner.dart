import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironsource_flutter_ads/IOS/ironsource_banner_size.dart';
import 'package:ironsource_flutter_ads/IOS/ironsource_banner_controller.dart';
import 'package:ironsource_flutter_ads/IOS/ironsource_events.dart';

class IronSourceBanner extends StatefulWidget {
  final IronSourceBannerSize adSize;
  final void Function(IronsourceAdEvent, Map<String, dynamic>) listener;
  final void Function(IronsourceBannerController) onBannerCreated;

  IronSourceBanner({
    Key key,
    @required this.adSize,
    this.listener,
    this.onBannerCreated,
  }) : super(key: key);

  @override
  _IronSourceBannerState createState() => _IronSourceBannerState();
}

class _IronSourceBannerState extends State<IronSourceBanner> {
  IronsourceBannerController _controller;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return Container(
        width: widget.adSize.width >= 0 ? widget.adSize.width.toDouble() : double.infinity,
        height: widget.adSize.height >= 0 ? widget.adSize.height.toDouble() : double.infinity,
        child: AndroidView(
          key: UniqueKey(),
          viewType: 'ironsource_ads/banner',
          creationParams: <String, dynamic>{
            "adSize": widget.adSize.toMap,
          },
          creationParamsCodec: StandardMessageCodec(),
          onPlatformViewCreated: _onPlatformViewCreated,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return Container(
        key: UniqueKey(),
        width: widget.adSize.width.toDouble(),
        height: widget.adSize.height.toDouble(),
        child: UiKitView(
          viewType: 'ironsource_ads/banner',
          creationParams: <String, dynamic>{
            "adSize": widget.adSize.toMap,
          },
          creationParamsCodec: StandardMessageCodec(),
          onPlatformViewCreated: _onPlatformViewCreated,
        ),
      );
    } else {
      return Text('$defaultTargetPlatform is not yet supported by the plugin');
    }

  }


  @override
  void dispose() {
    super.dispose();
  }

  void _onPlatformViewCreated(int id) {
    _controller = IronsourceBannerController(id, widget.listener);
    if (widget.onBannerCreated != null) {
      widget.onBannerCreated(_controller);
    }
  }
}
