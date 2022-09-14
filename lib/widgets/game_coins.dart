import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameCoins extends ChangeNotifier {
  int betCoins = 0;
  int currentCoins = 0;

  static Future<GameCoins> fromPreferences() async {
    final GameCoins coinBank = GameCoins();
    // Must be included if using the FutureBuilder
    // await Future<void>.delayed(Duration.zero, () {});
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int currentCoins = prefs.getInt('currentCoinsValue') ?? 0;
    coinBank.currentCoins = currentCoins;
    final int betCoins = prefs.getInt('betCoinsValue') ?? 0;
    coinBank.betCoins = betCoins;
    return coinBank;
  }

  Future<void> _updatePreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('betCoinsValue', betCoins);
    await prefs.setInt('currentCoinsValue', currentCoins);
  }

  Future<void> _clearPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getInt('betCoinsValue');
    await prefs.remove('betCoinsValue');
  }

  void incrementBetAmount() {
    betCoins++;
    notifyListeners();
    _updatePreferences();
  }

  void confirmBetAmount() {
    notifyListeners();
    _updatePreferences();
  }

  void clearBetAmount() {
    betCoins = 0;
    notifyListeners();
    _clearPreferences();
  }

  void decrement() {
    betCoins--;
    notifyListeners();
    _updatePreferences();
  }

  void winCoins() {
    currentCoins = currentCoins + betCoins;
    notifyListeners();
    _updatePreferences();
  }

  void addBoughtCoins(int amount) {
    currentCoins = currentCoins + amount;
    notifyListeners();
    _updatePreferences();
  }

  void loseCoins() {
    currentCoins = currentCoins - betCoins;
    notifyListeners();
    _updatePreferences();
  }
}
