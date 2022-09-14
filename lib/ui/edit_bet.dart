import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vingtun/settings/theme_provider.dart';
import 'package:vingtun/style/button_style.dart';
import 'package:vingtun/ui/menu_screen.dart';
import 'package:vingtun/widgets/appbar.dart';
import 'package:vingtun/widgets/game_coins.dart';

class EditBet extends StatefulWidget {
  const EditBet({Key? key}) : super(key: key);

  @override
  State<EditBet> createState() => _EditBetState();
}

class _EditBetState extends State<EditBet> {
  List<int> betAmount = [
    5,
    10,
    25,
    100,
    500,
  ];

  void buttonTapped() {}

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat("0000");
    final GameCoins coinBank = context.watch<GameCoins>();
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: formatter.format(coinBank.betCoins),
                          hintStyle: TextStyle(
                              fontSize: 34,
                              color: coinBank.betCoins == 0
                                  ? Colors.grey
                                  : theme
                                      ? Colors.white
                                      : Colors.black)),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      coinBank.clearBetAmount();
                    },
                    icon: const Icon(Icons.remove),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  // disable bet button if not enough money
                  itemBuilder: (context, index) {
                    return BetAmountButton(
                        text: betAmount[index].toString(),
                        onTap: coinBank.currentCoins < betAmount[index]
                            ? null
                            : () {
                                setState(() {
                                  coinBank.betCoins =
                                      betAmount[index] + coinBank.betCoins;
                                });
                              });
                  },
                  itemCount: betAmount.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const Divider(
                height: 20,
              ),
              Row(
                children: [
                  // ElevatedButton(
                  //   style: smallButtonStyle,
                  //   child: Text('Cancel'),
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                  SmallButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Cancel',
                  ),
                  const Spacer(),
                  SmallButton(
                      text: 'Confirm',
                      onPressed: coinBank.betCoins > coinBank.currentCoins
                          ? null
                          : () {
                              () {
                                coinBank.confirmBetAmount();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MenuScreen()),
                                );
                              };
                            }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getCoinsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(
            vertical: 200,
          ),
          content: Scaffold(
            body: Column(
              children: [
                Row(
                  children: [
                    Text('Free coins'),
                    TextButton(onPressed: () {}, child: Text('500')),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
