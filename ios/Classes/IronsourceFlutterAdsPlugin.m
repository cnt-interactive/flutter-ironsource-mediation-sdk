#import "IronsourceFlutterAdsPlugin.h"
#import <ironsource_flutter_ads-Swift.h>

@implementation IronsourceFlutterAdsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [SwiftIronsourceFlutterAdsPlugin registerWithRegistrar:registrar];
    [IronsourceIntersitialPlugin registerWithRegistrar: registrar];
}
@end
