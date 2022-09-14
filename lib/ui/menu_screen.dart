import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vingtun/ads/rewarded/rewarded_ad.dart';
import 'package:vingtun/settings/theme_provider.dart';
import 'package:vingtun/style/button_style.dart';
import 'package:vingtun/ui/edit_bet.dart';
import 'package:vingtun/ui/gamesc.dart';
import 'package:vingtun/widgets/dialogs.dart';
import 'package:vingtun/widgets/appbar.dart';
import 'package:vingtun/widgets/game_coins.dart';
import 'package:vingtun/widgets/stats_card.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key, this.payload}) : super(key: key);

  final String? payload;

  @override
  State<MenuScreen> createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late bool playerNoMoney = false;
  GlobalKey<StatsCardState> keyStatsCard = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showWelcomeDialog(context));
    final GameCoins coinBank = context.watch<GameCoins>();
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    Color themeColor = theme ? Colors.white : Colors.black;
    if (coinBank.currentCoins < coinBank.betCoins) {
      playerNoMoney = true;
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Spacer(),
              Row(
                children: [
                  SmallButton(
                      text: 'Edit Bet',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditBet()),
                        );
                      }),
                  const Spacer(),
                  LeaderboardButton(
                    onPressed: () {
                      setState(() {
                        keyStatsCard.currentState?.updateState();
                      });
                      showDialog(
                          context: context,
                          builder: (_) {
                            return HistoryDialog();
                          });
                    },
                    child: Icon(
                      Icons.leaderboard,
                      color: themeColor,
                    ),
                  ),
                  const Spacer(),
                  SmallButton(text: 'Placehold', onPressed: () {}),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: DealButton(
                  text: 'Deal',
                  onPressed: playerNoMoney
                      ? null
                      : () {
                          Navigator.of(context, rootNavigator: true).push(
                            PageRouteBuilder(
                              transitionDuration: Duration.zero,
                              pageBuilder: (context, animation1, animation2) =>
                                  GameScreen(),
                            ),
                          );
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final keyIsFirstLoaded = 'welcome_dialog';

  showWelcomeDialog(BuildContext context) async {
    // final GameCoins coinBank = context.watch<GameCoins>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Welcome Bonus"),
            content: const Text("500 Coins"),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Claim"),
                onPressed: () {
                  // coinBank.addBoughtCoins(500);
                  Navigator.of(context).pop();
                  prefs.setBool(keyIsFirstLoaded, false);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
