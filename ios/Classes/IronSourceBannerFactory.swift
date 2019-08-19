//
//  IronSourceFactory.swift
//  ironsource_flutter_ads
//
//  Created by Onurcan Yurt on 7.08.2019.
//

import Foundation

import Flutter
import Foundation

class IronSourceBannerFactory : NSObject, FlutterPlatformViewFactory {
    let messeneger: FlutterBinaryMessenger
    
    init(messeneger: FlutterBinaryMessenger) {
        self.messeneger = messeneger
    }
    
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return IronSourceBanner(
            frame: frame,
            viewId: viewId,
            args: args as? [String : Any] ?? [:],
            messeneger: messeneger
        )
    }
    
    //Returns the `FlutterMessageCodec` for decoding the args parameter of `createWithFrame`.
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
