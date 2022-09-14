import 'package:flutter/material.dart';

class Cards {
  String cardNum = '';
  String flowerVal = '';
  int cardVal = 0;
  final int maxVal = 21;
  final int minVal = 16;
  final int dealerVal = 18;
  int userVal = 0;
  late Color cardColor;

  void takeCards(int num) {
    //int cardLength, bool dealer, bool change1) {
    switch (num) {
      case 0:
        cardNum = 'A';
        flowerVal = '♠';
        cardColor = Colors.black;
        break;
      case 1:
        cardNum = 'A';
        flowerVal = '♥';
        cardColor = Colors.red;
        break;
      case 2:
        cardNum = 'A';
        flowerVal = '♣';
        cardColor = Colors.black;
        break;
      case 3:
        cardNum = 'A';
        flowerVal = '♦';
        cardColor = Colors.red;
        break;
      case 4:
        cardNum = 'K';
        flowerVal = '♠';
        cardVal = 10;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 5:
        cardNum = 'K';
        flowerVal = '♥';
        cardVal = 10;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 6:
        cardNum = 'K';
        flowerVal = '♣';
        cardVal = 10;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 7:
        cardNum = 'K';
        flowerVal = '♦';
        cardVal = 10;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 8:
        cardNum = 'Q';
        flowerVal = '♠';
        cardVal = 10;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 9:
        cardNum = 'Q';
        flowerVal = '♥';
        cardVal = 10;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 10:
        cardNum = 'Q';
        flowerVal = '♣';
        cardVal = 10;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 11:
        cardNum = 'Q';
        flowerVal = '♦';
        cardVal = 10;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 12:
        cardNum = 'J';
        flowerVal = '♠';
        cardVal = 10;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 13:
        cardNum = 'J';
        flowerVal = '♥';
        cardVal = 10;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 14:
        cardNum = 'J';
        flowerVal = '♣';
        cardVal = 10;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 15:
        cardNum = 'J';
        flowerVal = '♦';
        cardVal = 10;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 16:
        cardNum = '10';
        flowerVal = '♠';
        cardVal = 10;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 17:
        cardNum = '10';
        flowerVal = '♥';
        cardVal = 10;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 18:
        cardNum = '10';
        flowerVal = '♣';
        cardVal = 10;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 19:
        cardNum = '10';
        flowerVal = '♦';
        cardVal = 10;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 20:
        cardNum = '9';
        flowerVal = '♠';
        cardVal = 9;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 21:
        cardNum = '9';
        flowerVal = '♥';
        cardVal = 9;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 22:
        cardNum = '9';
        flowerVal = '♣';
        cardVal = 9;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 23:
        cardNum = '9';
        flowerVal = '♦';
        cardVal = 9;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 24:
        cardNum = '8';
        flowerVal = '♠';
        cardVal = 8;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 25:
        cardNum = '8';
        flowerVal = '♥';
        cardVal = 8;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 26:
        cardNum = '8';
        flowerVal = '♣';
        cardVal = 8;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 27:
        cardNum = '8';
        flowerVal = '♦';
        cardVal = 8;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 28:
        cardNum = '7';
        flowerVal = '♠';
        cardVal = 7;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 29:
        cardNum = '7';
        flowerVal = '♥';
        cardVal = 7;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 30:
        cardNum = '7';
        flowerVal = '♣';
        cardVal = 7;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 31:
        cardNum = '7';
        flowerVal = '♦';
        cardVal = 7;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 32:
        cardNum = '6';
        flowerVal = '♠';
        cardVal = 6;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 33:
        cardNum = '6';
        flowerVal = '♥';
        cardVal = 6;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 34:
        cardNum = '6';
        flowerVal = '♣';
        cardVal = 6;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 35:
        cardNum = '6';
        flowerVal = '♦';
        cardVal = 6;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 36:
        cardNum = '5';
        flowerVal = '♠';
        cardVal = 5;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 37:
        cardNum = '5';
        flowerVal = '♥';
        cardVal = 5;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 38:
        cardNum = '5';
        flowerVal = '♣';
        cardVal = 5;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 39:
        cardNum = '5';
        flowerVal = '♦';
        cardVal = 5;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 40:
        cardNum = '4';
        flowerVal = '♠';
        cardVal = 4;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 41:
        cardNum = '4';
        flowerVal = '♥';
        cardVal = 4;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 42:
        cardNum = '4';
        flowerVal = '♣';
        cardVal = 4;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 43:
        cardNum = '4';
        flowerVal = '♦';
        cardVal = 4;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 44:
        cardNum = '3';
        flowerVal = '♠';
        cardVal = 3;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 45:
        cardNum = '3';
        flowerVal = '♥';
        cardVal = 3;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 46:
        cardNum = '3';
        flowerVal = '♣';
        cardVal = 3;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 47:
        cardNum = '3';
        flowerVal = '♦';
        cardVal = 3;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 48:
        cardNum = '2';
        flowerVal = '♠';
        cardVal = 2;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 49:
        cardNum = '2';
        flowerVal = '♥';
        cardVal = 2;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
      case 50:
        cardNum = '2';
        flowerVal = '♣';
        cardVal = 2;
        cardColor = Colors.black;
        userVal += cardVal;
        break;
      case 51:
        cardNum = '2';
        flowerVal = '♦';
        cardVal = 2;
        cardColor = Colors.red;
        userVal += cardVal;
        break;
    }
  }
}
