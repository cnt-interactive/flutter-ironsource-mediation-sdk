import Flutter
import UIKit

public class SwiftIronsourceFlutterAdsPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftIronsourceFlutterAdsPlugin()
        
        let defaultChannel = FlutterMethodChannel(name: "ironsource_ads", binaryMessenger: registrar.messenger())
        
        registrar.addMethodCallDelegate(instance, channel: defaultChannel)
        
        
        registrar.register(
            IronSourceBannerFactory(messeneger: registrar.messenger()),
            withId: "ironsource_ads/banner"
        )
    }
    
    
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize":
            
            if let ironsourceID = call.arguments as! String? {
                 IronSource.initWithAppKey(ironsourceID, adUnits:[IS_BANNER, IS_INTERSTITIAL])
            }
            
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
