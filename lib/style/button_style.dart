import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vingtun/settings/theme_provider.dart';

final ButtonStyle replayButtonStyle = TextButton.styleFrom(
  minimumSize: const Size(160, 50),
  padding: EdgeInsets.zero,
  side: const BorderSide(width: 1, color: Colors.white),
);

final ButtonStyle circleButtonStyle = TextButton.styleFrom(
  primary: Colors.white,
  padding: EdgeInsets.zero,
  minimumSize: const Size(50, 50),
  // padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const CircleBorder(),
  backgroundColor: Colors.black26,
);

class SmallButton extends StatelessWidget {
  const SmallButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: theme ? Colors.black12 : Colors.white70,
        minimumSize: const Size(140, 50),
        primary: theme ? Colors.white : Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
      ),
    );
  }
}

class DialogButton extends StatelessWidget {
  const DialogButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: theme ? Colors.black12 : Colors.white70,
        minimumSize: const Size(70, 50),
        primary: theme ? Colors.white : Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
      ),
    );
  }
}

class DealButton extends StatelessWidget {
  const DealButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    return TextButton(
      style: TextButton.styleFrom(
        primary: theme ? Colors.white : Colors.black,
        backgroundColor: theme ? Colors.black12 : Colors.white,
        minimumSize: const Size(400, 60),
        // padding: EdgeInsets.symmetric(horizontal: 16.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}

class LeaderboardButton extends StatelessWidget {
  const LeaderboardButton(
      {Key? key, required this.child, required this.onPressed})
      : super(key: key);

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;

    return TextButton(
      style: TextButton.styleFrom(
        side: BorderSide(width: 2, color: theme ? Colors.white : Colors.black),
        primary: Colors.white,
        padding: EdgeInsets.zero,
        minimumSize: const Size(50, 50),
        // padding: EdgeInsets.symmetric(horizontal: 16.0),
        shape: const CircleBorder(),
        backgroundColor: theme ? Colors.black12 : Colors.white,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

class ButtonBlackjack extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const ButtonBlackjack({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.white,
        minimumSize: const Size(130, 50),
        padding: EdgeInsets.zero,

        // padding: EdgeInsets.symmetric(horizontal: 16.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class CircleButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CircleButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;

    return TextButton(
      style: TextButton.styleFrom(
        primary: theme ? Colors.white : Colors.black,
        padding: EdgeInsets.zero,
        minimumSize: const Size(50, 50),
        // padding: EdgeInsets.symmetric(horizontal: 16.0),
        shape: const CircleBorder(),
        backgroundColor: theme ? Colors.black12 : Colors.white,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class BetAmountButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const BetAmountButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    var buttonColor = theme ? Colors.black12 : Colors.white;
    var textColor = theme ? Colors.white : Colors.black;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(width: 2, color: textColor),
          primary: buttonColor,
          fixedSize: const Size(40, 40),
          shape: const CircleBorder(),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
