package com.spt.ironsource_flutter_ads;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.util.TypedValue;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

import java.util.HashMap;
import java.util.Map;

import com.ironsource.mediationsdk.ISBannerSize;
import com.ironsource.mediationsdk.IronSource;
import com.ironsource.mediationsdk.IronSourceBannerLayout;
import com.ironsource.mediationsdk.logger.IronSourceError;
import com.ironsource.mediationsdk.sdk.BannerListener;

public class IronSourceBannerView implements PlatformView, BannerListener {


    private FrameLayout bannerView;
    private final MethodChannel channel;
    private final HashMap args;
    private final Context context;
    private Activity activity;

    private IronSourceBannerLayout bannerLayout;


    IronSourceBannerView(Context context, int id, HashMap args, BinaryMessenger messenger, Activity activity) {
        this.channel = new MethodChannel(messenger,
                Constants.BANNER_CHANNEL + id);
        this.context = context;
        this.activity = activity;
        this.args = args;
        bannerView = new FrameLayout(context);
        // choose banner size
        ISBannerSize size = ISBannerSize.BANNER;
        final int height = (int) args.get("height");
        final int width = (int) args.get("height");
        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(width, height);
        // instantiate IronSourceBanner object, using the IronSource.createBanner API
        bannerLayout = IronSource.createBanner(activity, size);
        bannerLayout.setBannerListener(this);
        loadBanner();
    }


    private void loadBanner() {
        if (bannerView.getChildCount() > 0)
            bannerView.removeAllViews();
        FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT);
        bannerView.addView(
                bannerLayout,0,layoutParams
        );
        bannerView.setVisibility(View.VISIBLE);

        IronSource.loadBanner(bannerLayout);

    }





    public View getView() {
        return bannerView;
    }

    @Override
    public void dispose() {
        bannerView.setVisibility(View.INVISIBLE);
        bannerLayout.removeBannerListener();
        IronSource.destroyBanner(bannerLayout);
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onBannerAdLoaded() {

        activity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        channel.invokeMethod(Constants.BANNER_LOADED, null);
                    }
                }
        );
    }

    @Override
    public void onBannerAdLoadFailed(final IronSourceError ironSourceError) {
        activity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        Map<String, Object> arguments = new HashMap<String, Object>();
                        arguments.put("errorCode", ironSourceError.getErrorCode());
                        arguments.put("errorMessage", ironSourceError.getErrorMessage());
                        channel.invokeMethod(Constants.BANNER_LOAD_FAILED, arguments);
                    }
                }
        );

    }

    @Override
    public void onBannerAdClicked() {
        activity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        channel.invokeMethod(Constants.BANNER_CLICKED, null);
                    }
                }
        );
    }

    @Override
    public void onBannerAdScreenPresented() {
        activity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        channel.invokeMethod(Constants.BANNER_SCREEN_PRESENTED, null);

                    }
                }
        );
    }

    @Override
    public void onBannerAdScreenDismissed() {
        activity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        channel.invokeMethod(Constants.BANNER_SCREEN_DISMISSED, null);

                    }
                }
        );
    }

    @Override
    public void onBannerAdLeftApplication() {
        activity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        channel.invokeMethod(Constants.BANNER_LEFT_APPLICATION, null);
                    }
                }
        );

    }


}
