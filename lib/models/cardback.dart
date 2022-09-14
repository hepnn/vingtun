import 'package:flutter/material.dart';

class CardBack extends StatelessWidget {
  const CardBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: 120.0,
      width: 75.0,
      child: ClipRRect(
        child: Image.asset(
          'assets/card_back.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
