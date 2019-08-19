package com.spt.ironsource_flutter_ads;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import android.app.Activity;
import android.os.AsyncTask;
import android.text.TextUtils;

import com.ironsource.adapters.supersonicads.SupersonicConfig;
import com.ironsource.mediationsdk.IronSource;
import com.ironsource.mediationsdk.integration.IntegrationHelper;
import com.ironsource.mediationsdk.logger.IronSourceError;
import com.ironsource.mediationsdk.model.Placement;
import com.ironsource.mediationsdk.sdk.InterstitialListener;

import java.util.HashMap;
import java.util.Map;


/**
 * IronsourceFlutterAdsPlugin
 */
public class IronsourceFlutterAdsPlugin implements MethodCallHandler, InterstitialListener {




    public final Activity iActivity;
    public final MethodChannel iChannel;

    public IronsourceFlutterAdsPlugin(Activity activity, MethodChannel channel) {
        this.iActivity = activity;
        this.iChannel = channel;
    }


    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), Constants.MAIN_CHANNEL);
        channel.setMethodCallHandler(new IronsourceFlutterAdsPlugin(registrar.activity(), channel));

        final MethodChannel interstitialAdChannel = new MethodChannel(registrar.messenger(), Constants.INTERSTITIAL_CHANNEL);


        registrar.platformViewRegistry().registerViewFactory(Constants.BANNER_CHANNEL, new IronSourceBanner(registrar.activity(), registrar.messenger()));
    }


    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals(Constants.INIT) && call.hasArgument("appKey")) {
            initialize(call.<String>argument("appKey"));
            result.success(null);
        } else if (call.method.equals(Constants.LOAD_INTERSTITIAL)) {
            IronSource.loadInterstitial();
            result.success(null);
        } else if (call.method.equals(Constants.SHOW_INTERSTITIAL)) {
            IronSource.showInterstitial();
            result.success(null);
        } else if (call.method.equals(Constants.IS_INTERSTITIAL_READY)) {
            result.success(IronSource.isInterstitialReady());
        }  else if (call.method.equals("validateIntegration")) {
            IntegrationHelper.validateIntegration(iActivity);
            result.success(null);
        } else if (call.method.equals("onResume")) {
            IronSource.onResume(iActivity);
            result.success(null);
        } else if (call.method.equals("onPause")) {
            IronSource.onPause(iActivity);
            result.success(null);
        }   else {
            result.notImplemented();
        }
    }


    public void initialize(String appKey) {

        IronSource.setInterstitialListener(this);
        SupersonicConfig.getConfigObj().setClientSideCallbacks(true);
        IronSource.init(iActivity, appKey);

    }


    // Interstitial Listener

    @Override
    public void onInterstitialAdClicked() {
        iActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        iChannel.invokeMethod(Constants.INTERSTITIAL_CLICKED, null);
                    }
                }
        );

    }

    @Override
    public void onInterstitialAdReady() {
        iActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        iChannel.invokeMethod(Constants.INTERSTITIAL_READY, null);
                    }
                }
        );

    }

    @Override
    public void onInterstitialAdLoadFailed(final IronSourceError ironSourceError) {
        iActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        Map<String, Object> arguments = new HashMap<String, Object>();
                        arguments.put("errorCode", ironSourceError.getErrorCode());
                        arguments.put("errorMessage", ironSourceError.getErrorMessage());
                        iChannel.invokeMethod(Constants.INTERSTITIAL_LOAD_FAILED, arguments);

                    }
                }
        );
    }

    @Override
    public void onInterstitialAdOpened() {
        iActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        iChannel.invokeMethod(Constants.INTERSTITIAL_OPENED, null);

                    }
                }
        );

    }

    @Override
    public void onInterstitialAdClosed() {
        iActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...

                        iChannel.invokeMethod(Constants.INTERSTITIAL_CLOSED, null);
                    }
                }
        );


    }

    @Override
    public void onInterstitialAdShowSucceeded() {
        iActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        iChannel.invokeMethod(Constants.INTERSTITIAL_SHOW_SUCCEEDED, null);
                    }
                }
        );


    }

    @Override
    public void onInterstitialAdShowFailed(final IronSourceError ironSourceError) {
        iActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        Map<String, Object> arguments = new HashMap<String, Object>();
                        arguments.put("errorCode", ironSourceError.getErrorCode());
                        arguments.put("errorMessage", ironSourceError.getErrorMessage());
                        iChannel.invokeMethod(Constants.INTERSTITIAL_SHOW_FAILED, arguments);
                    }
                }
        );


    }



}
