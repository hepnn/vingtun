import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vingtun/ads/rewarded/rewarded_ad.dart';
import 'package:vingtun/settings/theme_provider.dart';
import 'package:vingtun/ui/free_coins.dart';
import 'package:vingtun/ui/history.dart';
import 'package:vingtun/ui/shop_coins.dart';
import 'package:vingtun/ui/statistics.dart';
import 'package:vingtun/widgets/game_coins.dart';

class CoinDialog extends StatefulWidget {
  CoinDialog({Key? key}) : super(key: key) {
    adManager.addAds(true);
  }

  final adManager = AdManager();

  @override
  State<CoinDialog> createState() => _CoinDialogState();
}

class _CoinDialogState extends State<CoinDialog>
    with SingleTickerProviderStateMixin {
  late TabController _coinDialogController;

  @override
  void initState() {
    _coinDialogController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GameCoins coinBank = context.watch<GameCoins>();
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        insetPadding: const EdgeInsets.all(10),
        contentPadding: const EdgeInsets.all(4),
        content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: Color.fromARGB(255, 228, 220, 220),
                        borderRadius: BorderRadius.circular(25.0)),
                    labelColor: theme ? Colors.black : Colors.white,
                    unselectedLabelColor: theme ? Colors.white : Colors.black,
                    tabs: [
                      Tab(
                        child: Text(
                          'Free',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Shop',
                        ),
                      ),
                    ],
                    controller: _coinDialogController,
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: TabBarView(
                  controller: _coinDialogController,
                  children: const [
                    FreeCoins(),
                    ShopCoins(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class HistoryDialog extends StatefulWidget {
  const HistoryDialog({Key? key}) : super(key: key);

  @override
  State<HistoryDialog> createState() => _HistoryDialogState();
}

class _HistoryDialogState extends State<HistoryDialog>
    with SingleTickerProviderStateMixin {
  late TabController _historyDialogController;

  @override
  void initState() {
    _historyDialogController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      insetPadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(4),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(25.0)),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: Color.fromARGB(255, 228, 220, 220),
                      borderRadius: BorderRadius.circular(25.0)),
                  labelColor: theme ? Colors.black : Colors.white,
                  unselectedLabelColor: theme ? Colors.white : Colors.black,
                  tabs: const [
                    Tab(
                      child: Text(
                        'History',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Statistic',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                  controller: _historyDialogController,
                ),
              ),
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: TabBarView(
                controller: _historyDialogController,
                children: const [
                  Historic(),
                  StatisticScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
