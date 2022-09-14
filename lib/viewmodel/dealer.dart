import 'package:flutter/cupertino.dart';

class Dealer extends ChangeNotifier {
  int dealerHealth = 100;
  final int maxHealth = 100;
  int dealerNum = 0;
  List<String> dealerCard = [];

  void updateDealerHealth(int num) {
    if (dealerHealth + num <= maxHealth) {
      dealerHealth += num;
    } else if (dealerHealth + num > maxHealth) {
      dealerHealth = 100;
    }
    notifyListeners();
  }

  void updateDealerNum(int uNum) {
    dealerNum += uNum;
    notifyListeners();
  }

  void updateDealerCard(String card) {
    dealerCard.add(card);
    notifyListeners();
  }

  void restartDealerStats() {
    dealerNum = 0;
    dealerCard = [];
    notifyListeners();
  }
}
