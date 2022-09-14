import 'package:flutter/cupertino.dart';

class Player extends ChangeNotifier {
  int playerHealth = 100;
  final int maxHealth = 100;
  int playerNum = 0;
  List<String> playerCard = [];
  bool changeA1 = false;
  bool changeA2 = false;
  bool changeA3 = false;
  bool changeA4 = false;
  bool changeA5 = false;

  void updateHealth(int num) {
    if (playerHealth + num <= maxHealth) {
      playerHealth += num;
    } else if (playerHealth + num > maxHealth) {
      playerHealth = 100;
    }
    notifyListeners();
  }

  void updatePlayerNum(int uNum) {
    playerNum += uNum;
    notifyListeners();
  }

  void updatePlayerCard(String card) {
    playerCard.add(card);
    notifyListeners();
  }

  void restartStats() {
    playerNum = 0;
    playerCard = [];
    notifyListeners();
  }

  void modifyA1Val() {
    changeA1 ? playerNum += 9 : playerNum -= 9;
    notifyListeners();
  }

  void modifyA2Val() {
    changeA2 ? playerNum += 9 : playerNum -= 9;
    notifyListeners();
  }

  void modifyA3Val() {
    changeA3 ? playerNum += 9 : playerNum -= 9;
    notifyListeners();
  }

  void modifyA4Val() {
    changeA4 ? playerNum += 9 : playerNum -= 9;
    notifyListeners();
  }

  void modifyA5Val() {
    changeA5 ? playerNum += 9 : playerNum -= 9;
    notifyListeners();
  }
}
