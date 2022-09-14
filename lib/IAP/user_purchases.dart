import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:vingtun/IAP/model/purchasable_product.dart';
import 'package:vingtun/IAP/model/store_state.dart';
import 'package:vingtun/constants.dart';
import 'package:vingtun/main.dart';
import 'package:vingtun/widgets/game_coins.dart';

class UserPurchases extends ChangeNotifier {
  GameCoins coinBank;

  StoreState storeState = StoreState.loading;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<PurchasableProduct> products = [];

  bool get beautifiedDash => _beautifiedDashUpgrade;
  final bool _beautifiedDashUpgrade = false;
  final iapConnection = IAPConnection.instance;

  UserPurchases(this.coinBank) {
    final purchaseUpdated = iapConnection.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );

    loadPurchases();
  }

  Future<void> loadPurchases() async {
    final available = await iapConnection.isAvailable();
    if (!available) {
      storeState = StoreState.notAvailable;
      notifyListeners();
      return;
    }

    try {} catch (e) {
      storeState = StoreState.notAvailable;
      notifyListeners();
      return;
    }

    const ids = <String>{
      storeKeyCoins500,
      storeKeyCoins1500,
      storeKeyCoins3000,
    };
    final response = await iapConnection.queryProductDetails(ids);
    products =
        response.productDetails.map((e) => PurchasableProduct(e)).toList();
    storeState = StoreState.available;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> buy(PurchasableProduct product) async {
    final purchaseParam = PurchaseParam(productDetails: product.productDetails);
    switch (product.id) {
      case storeKeyCoins3000:
      case storeKeyCoins1500:
      case storeKeyCoins500:
        await iapConnection.buyConsumable(purchaseParam: purchaseParam);
        break;
      default:
        throw ArgumentError.value(
            product.productDetails, '${product.id} is not a known product');
    }
  }

  Future<void> _onPurchaseUpdate(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }
    notifyListeners();
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      // Send to server

      // Apply changes locally
      switch (purchaseDetails.productID) {
        case storeKeyCoins3000:
          coinBank.addBoughtCoins(3000);
          break;
        case storeKeyCoins500:
          coinBank.addBoughtCoins(500);
          break;
        case storeKeyCoins1500:
          coinBank.addBoughtCoins(1500);
          break;
      }
    }

    if (purchaseDetails.pendingCompletePurchase) {
      await iapConnection.completePurchase(purchaseDetails);
    }
  }

  // Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
  //   var functions = await firebaseNotifier.functions;
  //   final callable = functions.httpsCallable('verifyPurchase');
  //   final results = await callable({
  //     'source': purchaseDetails.verificationData.source,
  //     'verificationData':
  //         purchaseDetails.verificationData.serverVerificationData,
  //     'productId': purchaseDetails.productID,
  //   });
  //   return results.data as bool;
  // }

  void _updateStreamOnDone() {
    _subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    // ignore: avoid_print
    print(error);
  }

  // void purchasesUpdate() {
  //   var subscriptions = <PurchasableProduct>[];
  //   var upgrades = <PurchasableProduct>[];
  //   // Get a list of purchasable products for the subscription and upgrade.
  //   // This should be 1 per type.
  //   if (products.isNotEmpty) {
  //     subscriptions = products
  //         .where((element) => element.productDetails.id == storeKeyCoins3000)
  //         .toList();
  //     upgrades = products
  //         .where((element) => element.productDetails.id == storeKeyCoins1500)
  //         .toList();
  //   }

  // Set the subscription in the counter logic and show/hide purchased on the
  // purchases page.
  // if (iapRepo.hasActiveSubscription) {
  //   counter.applyPaidMultiplier();
  //   for (final element in subscriptions) {
  //     _updateStatus(element, ProductStatus.purchased);
  //   }
  // } else {
  //   counter.removePaidMultiplier();
  //   for (final element in subscriptions) {
  //     _updateStatus(element, ProductStatus.purchasable);
  //   }
  // }

  // Set the dash beautifier and show/hide purchased on
  // the purchases page.
  // if (iapRepo.hasUpgrade != _beautifiedDashUpgrade) {
  //   _beautifiedDashUpgrade = iapRepo.hasUpgrade;
  //   for (final element in upgrades) {
  //     _updateStatus(
  //         element,
  //         _beautifiedDashUpgrade
  //             ? ProductStatus.purchased
  //             : ProductStatus.purchasable);
  //   }
  //   notifyListeners();
  // }
}

  // void _updateStatus(PurchasableProduct product, ProductStatus status) {
  //   if (product.status != status) {
  //     product.status = status;
  //     notifyListeners();
  //   }
  // }
// }
