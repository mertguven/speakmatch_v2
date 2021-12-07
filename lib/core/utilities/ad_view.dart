import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:speakmatch_v2/core/helper/ad_helper.dart';

class AdView {
  InterstitialAd interstitialAd;

  Future<void> loadInterstitialAd(Widget view) async {
    await InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdFailedToLoad: (LoadAdError error) {
          print('Failed to load an interstitial ad: ${error.message}');
        },
        onAdLoaded: (InterstitialAd ad) {
          this.interstitialAd = ad;

          interstitialAd.show();
          interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print("ad closed!!!!");
              interstitialAd.dispose();
              Get.to(() => view, transition: Transition.fadeIn);
            },
          );
        },
      ),
    );
  }
}
