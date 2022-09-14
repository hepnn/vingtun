import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:vingtun/ads/rewarded/adunit.dart';
import 'package:vingtun/style/button_style.dart';
import 'package:vingtun/widgets/card.dart';
import 'package:vingtun/widgets/countdown.dart';
import 'package:vingtun/widgets/game_coins.dart';

class FreeCoins extends StatefulWidget {
  const FreeCoins({Key? key}) : super(key: key);

  @override
  State<FreeCoins> createState() => _FreeCoinsState();
}

class _FreeCoinsState extends State<FreeCoins> {
  RewardedAd? _rewardedAd;
  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    final GameCoins coinBank = context.watch<GameCoins>();
    return Column(
      children: [
        SizedBox(height: 30),
        DialogCard(
          icon: Icons.album,
          textAmount: '100',
          textInfo: 'Bonus reward',
          child: CountDownWidget(
            hoursRemaining: 3,
            minutesRemaining: 0,
            onEnd: () {
              print('on end');
            },
            onStart: () {
              coinBank.addBoughtCoins(100);
            },
          ),
        ),
        SizedBox(height: 20),
        DialogCard(
          icon: Icons.album,
          textAmount: '300',
          textInfo: 'Daily reward',
          child: CountDownWidget(
            hoursRemaining: 24,
            minutesRemaining: 0,
            onEnd: () {
              print('on end');
            },
            onStart: () {
              print('start');
            },
          ),
        ),
        SizedBox(height: 20),
        DialogCard(
          icon: Icons.video_camera_front,
          textAmount: '200',
          textInfo: 'Watch Ad',
          child: DialogButton(
            onPressed: _rewardedAd != null
                ? () {
                    _rewardedAd!.show(onUserEarnedReward: (_, reward) {
                      print('got reward');
                    });
                  }
                : null,
            text: 'Claim',
          ),
        ),
      ],
    );
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                _rewardedAd = null;
              });
              _loadRewardedAd();
            },
          );
          setState(() {
            _rewardedAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();

    super.dispose();
  }
}
