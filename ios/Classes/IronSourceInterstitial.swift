//
//  IronSourceInterstitial.swift
//  ironsource_flutter_ads
//
//  Created by Onurcan Yurt on 7.08.2019.
//


import Flutter
import Foundation
import UIKit

public class IronsourceIntersitialPlugin: NSObject, FlutterPlugin {
    
    
    fileprivate var pluginRegistrar: FlutterPluginRegistrar?
    fileprivate var interstitialChannel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = IronsourceIntersitialPlugin()
        instance.pluginRegistrar = registrar
        let channel = FlutterMethodChannel(name: "ironsource_ads/interstitial", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        
       
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String : Any]  else {
            result(FlutterError(code: "Missing args!", message: "Unable to convert args to [String : Any]", details: nil))
            return
        }
        let id = args["id"] as? Int ?? 0
        
        switch call.method {
        case "setListener":
            let channel = FlutterMethodChannel(name: "ironsource_ads/interstitial_\(id)", binaryMessenger: pluginRegistrar!.messenger())
            
            let vc = IronsourceIntersitialPluginDelegate(channel: channel)
            
            IronSource.setInterstitialDelegate(vc)
            IronSource.loadInterstitial()
            ISIntegrationHelper.validateIntegration()
            break
        case "load":
            
            result(nil)
            break
        case "isLoaded":
            if let viewController = UIApplication.shared.keyWindow!.rootViewController {
                if IronSource.hasInterstitial() {
                    IronSource.showInterstitial(with: viewController)
                }
            }
            
            break
        case "show":
            break
        case "dispose":
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }
 
   
}

class IronsourceIntersitialPluginDelegate: NSObject, ISInterstitialDelegate {
    
    let channel: FlutterMethodChannel
    
    init(channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    public func interstitialDidLoad() {

        channel.invokeMethod("loaded", arguments: nil)
        
    }
    
    public func interstitialDidFailToLoadWithError(_ error: Error!) {
         channel.invokeMethod("failedToShow", arguments: ["errorCode": error.localizedDescription])
    }
    
    public func interstitialDidOpen() {
        
        channel.invokeMethod("opened", arguments: nil)
    }
    
    public func interstitialDidClose() {
        
        channel.invokeMethod("closed", arguments: nil)
    }
    
    public func interstitialDidShow() {
        channel.invokeMethod("shown", arguments: nil)
    }
    
    public func interstitialDidFailToShowWithError(_ error: Error!) {
        channel.invokeMethod("failedToShow", arguments: ["errorCode": error])
        
    }
    
    public func didClickInterstitial() {
        channel.invokeMethod("clicked", arguments: nil)
        
    }
    
    
}

