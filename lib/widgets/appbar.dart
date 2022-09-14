import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vingtun/settings/theme_provider.dart';
import 'package:vingtun/ui/settings_screen.dart';
import 'package:vingtun/widgets/dialogs.dart';
import 'package:vingtun/widgets/game_coins.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize; // default is 56.0
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final Future<SharedPreferences> pref = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    final GameCoins coinBank = context.watch<GameCoins>();
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    Color themeColor = theme ? Colors.white : Colors.black;
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
                transitionDuration: Duration.zero,
                pageBuilder: (context, animation1, animation2) =>
                    const SettingsScreen()));
          },
          icon: Icon(Icons.settings)),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return CoinDialog();
                        });
                  },
                  child: Text(
                    '${coinBank.currentCoins}',
                    style: TextStyle(fontSize: 24, color: themeColor),
                  ),
                ),
                SvgPicture.asset(
                  "assets/images/casino_coin.svg",
                  width: 24,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // final GlobalKey _dialogKey = GlobalKey();

  // // Text for update in dialog
  // String _loadingText = "Start";

  // void getCoinsDialog() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //           insetPadding: const EdgeInsets.all(10),
  //           contentPadding: EdgeInsets.all(4),
  //           // Aligns the container to center
  //           content: StatefulBuilder(
  //               key: _dialogKey,
  //               builder: (context, setState) {
  //                 CountdownController countdownController = CountdownController(
  //                     duration: Duration(seconds: 30),
  //                     onEnd: () {
  //                       print('onEnd');
  //                     });

  //                 bool isRunning = false;

  //                 void onEnd() {
  //                   print('onEnd');
  //                 }

  //                 final GameCoins coinBank = context.watch<GameCoins>();

  //                 return SizedBox(
  //                   height: 330,
  //                   width: 300,
  //                   child: Column(
  //                     children: [
  //                       Align(
  //                         alignment: Alignment.topRight,
  //                         child: IconButton(
  //                           icon: Icon(Icons.close),
  //                           onPressed: () {},
  //                         ),
  //                       ),
  //                       const Text(
  //                         'Get Chips',
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, fontSize: 18),
  //                       ),
  //                       SizedBox(
  //                         height: 80,
  //                         width: 250,
  //                         child: Card(
  //                           color: Color.fromARGB(31, 55, 51, 51),
  //                           child: Column(children: []),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 80,
  //                         width: 250,
  //                         child: Card(
  //                           color: Color.fromARGB(31, 55, 51, 51),
  //                           child: Row(children: [
  //                             Icon(Icons.album),
  //                             Spacer(),
  //                             Column(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Text('100'),
  //                                 Text('Daily reward'),
  //                               ],
  //                             ),
  //                             ElevatedButton(
  //                               onPressed: () {
  //                                 if (!countdownController.isRunning) {
  //                                   countdownController.start();
  //                                   setState(() {
  //                                     isRunning = true;
  //                                   });
  //                                 } else {
  //                                   countdownController.stop();
  //                                   setState(() {
  //                                     isRunning = false;
  //                                   });
  //                                 }
  //                               },
  //                               child: Countdown(
  //                                 countdownController: countdownController,
  //                                 builder: (_, Duration time) {
  //                                   return Text(isRunning
  //                                       ? 'Claim'
  //                                       : '${time.inSeconds % 60}');
  //                                 },
  //                               ),
  //                             ),
  //                             // ElevatedButton(
  //                             //     onPressed: isTimerStarted
  //                             //         ? null
  //                             //         : () {
  //                             //             setState(() {
  //                             //               isTimerStarted = true;
  //                             //             });
  //                             //           },
  //                             //     child:
  //                             //         Text(isTimerStarted ? "Timer" : "Get")),
  //                             const Spacer(
  //                               flex: 2,
  //                             ),
  //                           ]),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 80,
  //                         width: 250,
  //                         child: Card(
  //                           color: Color.fromARGB(31, 55, 51, 51),
  //                           child: Column(children: []),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               }),
  //         );
  //       });
  // }
}
