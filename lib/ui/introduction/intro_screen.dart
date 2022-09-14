import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vingtun/settings/theme_provider.dart';
import 'package:vingtun/style/button_style.dart';
import 'package:vingtun/ui/menu_screen.dart';
import 'package:vingtun/ui/introduction/tutorial_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    Color themeColor = theme ? Colors.white : Colors.black;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Spacer(),
                Text('Go through a quick Blackjack tutorial',
                    style: Theme.of(context).textTheme.headline6),
                Image.asset(
                  'assets/blackjack.png',
                  width: 270,
                  height: 270,
                ),
                const Spacer(
                  flex: 4,
                ),
                SmallButton(
                  text: 'Next',
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    prefs.setBool('showHome', true);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const TutorialScreen();
                        },
                      ),
                    );
                  },
                ),
                const Spacer(
                  flex: 4,
                ),
                TextButton(
                  child: Text(
                    'Skip tutorial',
                    style: TextStyle(color: themeColor),
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return MenuScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
