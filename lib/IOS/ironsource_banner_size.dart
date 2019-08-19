import 'package:meta/meta.dart';

class IronSourceBannerSize {
  final int width, height;
  final String name;

  static const IronSourceBannerSize BANNER = IronSourceBannerSize(width: 320, height: 50, name: 'BANNER');

  const IronSourceBannerSize({
    @required this.width,
    @required this.height,
    this.name,
  });

  Map<String, dynamic> get toMap => <String, dynamic>{
    'width': width,
    'height': height,
    'name': name,
  };
}
