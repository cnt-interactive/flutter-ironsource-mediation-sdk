//
//  IronSourceBanner.swift
//  ironsource_flutter_ads
//
//  Created by Onurcan Yurt on 7.08.2019.
//

import Foundation

class IronSourceBanner : NSObject, FlutterPlatformView {
    
    private var channel: FlutterMethodChannel
    private let messeneger: FlutterBinaryMessenger
    private let frame: CGRect
    private let viewId: Int64
    private let args: [String: Any]
    private var adView: UIView
    
    init(frame: CGRect, viewId: Int64, args: [String: Any], messeneger: FlutterBinaryMessenger) {
        self.args = args
        self.messeneger = messeneger
        self.frame = frame
        self.viewId = viewId
        self.adView = UIView(frame: frame)
        channel = FlutterMethodChannel(name: "ironsource_ads/banner_\(viewId)", binaryMessenger: messeneger)
    }
    
    
    //Returns a reference to the `UIView` that is wrapped by this `FlutterPlatformView`.
    func view() -> UIView {
        return getBannerAdView() ?? UIView()
    }
    
    fileprivate func dispose() {
        adView.removeFromSuperview()
        channel.setMethodCallHandler(nil)
    }
    
   
    //bu metod ile geriye bannerView dondururken ayni zamanda, banneri yapilandiriyoruz
    
    private func getBannerAdView() -> UIView? {
        channel.setMethodCallHandler { [weak self] (flutterMethodCall: FlutterMethodCall, flutterResult: FlutterResult) in
                switch flutterMethodCall.method {
                    
                //client den gelen "setListener" komutu ile burada Delegate'imizi bagliyoruz
                case "setListener":
                    IronSource.setBannerDelegate(self!)
                    break
                case "dispose":
                    self?.dispose()
                    break
                default:
                    flutterResult(FlutterMethodNotImplemented)
                }
            }
        
            //banner load islemi
            if let viewController = UIApplication.shared.keyWindow!.rootViewController {
                IronSource.loadBanner(with: viewController, size: ISBannerSize(description: "BANNER"))
            }
        
        return adView
    }
    
}

extension IronSourceBanner : ISBannerDelegate {
    
    func bannerDidLoad(_ bannerView: ISBannerView!) {
        
       self.adView.addSubview(bannerView)
       channel.invokeMethod("loaded", arguments: nil)
     }
    
    func bannerDidFailToLoadWithError(_ error: Error!) {
        channel.invokeMethod("failedToLoad", arguments: ["error":error.localizedDescription])
    }
     func didClickBanner() {
        channel.invokeMethod("clicked", arguments: nil)
    }
    
    func bannerWillPresentScreen() {
      channel.invokeMethod("opened", arguments: nil)
    }
    
    func bannerDidDismissScreen() {
         channel.invokeMethod("closed", arguments: nil)
    }
    
    func bannerWillLeaveApplication() {
         channel.invokeMethod("leftApplication", arguments: nil)
    }
    
}
