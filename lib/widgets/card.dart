import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings/theme_provider.dart';

class DialogCard extends StatelessWidget {
  const DialogCard(
      {Key? key,
      required this.icon,
      required this.textAmount,
      required this.textInfo,
      required this.child})
      : super(key: key);

  final IconData icon;
  final String textAmount;
  final String textInfo;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width - 130,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(textAmount),
              Text(textInfo),
            ],
          ),
          const Spacer(
            flex: 2,
          ),
          child,
        ],
      ),
    );
  }
}
