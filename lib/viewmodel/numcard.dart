import 'package:flutter/material.dart';

class NumCard extends ChangeNotifier {
  //1st
  String flower = '♠';
  String num = '0';
  Color color = Colors.black;
  String cardTemplate = 'assets/card_back.png';
  //2nd
  String flower2 = '♠';
  String num2 = '0';
  Color color2 = Colors.black;
  //3rd
  String flower3 = '♠';
  String num3 = '0';
  Color color3 = Colors.black;
  //4th
  String flower4 = '♠';
  String num4 = '0';
  Color color4 = Colors.black;
  //5th
  String flower5 = '♠';
  String num5 = '0';
  Color color5 = Colors.black;

  //dealer1st
  String flower6 = '♠';
  String num6 = '0';
  Color color6 = Colors.black;
  //dealer2nd
  String flower7 = '♠';
  String num7 = '0';
  Color color7 = Colors.black;
  //dealer3rd
  String flower8 = '♠';
  String num8 = '0';
  Color color8 = Colors.black;
  //dealer4th
  String flower9 = '♠';
  String num9 = '0';
  Color color9 = Colors.black;
  //dealer5th
  String flower10 = '♠';
  String num10 = '0';
  Color color10 = Colors.black;

  void doSomething(String flower1st, String num1st, Color color1st) {
    flower = flower1st;
    num = num1st;
    color = color1st;
    notifyListeners();
  }

  void doSomething2(String flower2nd, String num2nd, Color color2nd) {
    flower2 = flower2nd;
    num2 = num2nd;
    color2 = color2nd;
    notifyListeners();
  }

  void doSomething3(String flower3rd, String num3rd, Color color3rd) {
    flower3 = flower3rd;
    num3 = num3rd;
    color3 = color3rd;
    notifyListeners();
  }

  void doSomething4(String flower4th, String num4th, Color color4th) {
    flower4 = flower4th;
    num4 = num4th;
    color4 = color4th;
    notifyListeners();
  }

  void doSomething5(String flower5th, String num5th, Color color5th) {
    flower5 = flower5th;
    num5 = num5th;
    color5 = color5th;
    notifyListeners();
  }

  void doSomething6(String flower6th, String num6th, Color color6th) {
    flower6 = flower6th;
    num6 = num6th;
    color6 = color6th;
    notifyListeners();
  }

  void doSomething7(String flower7th, String num7th, Color color7th) {
    flower7 = flower7th;
    num7 = num7th;
    color7 = color7th;
    notifyListeners();
  }

  void doSomething8(String flower8th, String num8th, Color color8th) {
    flower8 = flower8th;
    num8 = num8th;
    color8 = color8th;
    notifyListeners();
  }

  void doSomething9(String flower9th, String num9th, Color color9th) {
    flower9 = flower9th;
    num9 = num9th;
    color9 = color9th;
    notifyListeners();
  }

  void doSomething10(String flower10th, String num10th, Color color10th) {
    flower10 = flower10th;
    num10 = num10th;
    color10 = color10th;
    notifyListeners();
  }
}
