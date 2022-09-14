import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vingtun/settings/theme_provider.dart';
import 'package:vingtun/ui/introduction/page_one.dart';
import 'package:vingtun/ui/menu_screen.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    Color themeColor = theme ? Colors.white : Colors.black;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                decoration: PageDecoration(),
                title: 'Beat the dealer',
                bodyWidget: PageOne(),
              ),
              PageViewModel(
                title: 'Title of 2nd Page',
                body: 'Body of 2nd Page',
              ),
              PageViewModel(
                title: 'Title of 3rd Page',
                body: 'Body of 3rd Page',
              ),
              PageViewModel(
                title: 'Title of 4th Page',
                body: 'Body of 4th Page',
              ),
            ],
            onDone: () async {
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
            skip: Text('Skip', style: TextStyle(color: themeColor)),
            next: Text(
              'Next',
              style: TextStyle(color: themeColor),
            ),
            done: Text("Done",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: themeColor)),
            showBackButton: false,
            showSkipButton: true,
            dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: Colors.black,
                color: Colors.black26,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0))),
          ),
        ),
      ),
    );
  }
}
