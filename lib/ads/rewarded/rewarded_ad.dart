import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logging/logging.dart';

class AdManager {
  static final _log = Logger('RewardAd');

  RewardedAd? _rewardedAd;

  void loadRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isIOS
            ? "ca-app-pub-3940256099942544/1712485313"
            : "ca-app-pub-3940256099942544/5224354917",
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          _log.info(() => 'Ad loaded: ${_rewardedAd.hashCode}');

          _rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          _log.warning('Rewarded ad failed to load: $error');

          _rewardedAd = null;
        }));
  }

  void addAds(bool rewardedAd) {
    if (rewardedAd) {
      loadRewardedAd();
    }
  }

  void showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (RewardedAd ad) {
        _log.info('Ad showing on fullscreen');
      }, onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        loadRewardedAd();
      }, onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        _log.warning('Ad failed to show: $error');
        ad.dispose();
        loadRewardedAd();
      });
      _rewardedAd!.setImmersiveMode(true);
      _rewardedAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        _log.info('User rewarded: ${reward.amount} ${reward.type}');
      });
    }
  }

  void disposeAds() {
    _rewardedAd?.dispose();
  }
}
