import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vingtun/IAP/model/purchasable_product.dart';
import 'package:vingtun/IAP/model/store_state.dart';
import 'package:vingtun/style/button_style.dart';
import 'package:vingtun/widgets/card.dart';
import '../IAP/user_purchases.dart';

class ShopCoins extends StatefulWidget {
  const ShopCoins({Key? key}) : super(key: key);

  @override
  State<ShopCoins> createState() => _ShopCoinsState();
}

class _ShopCoinsState extends State<ShopCoins> {
  @override
  Widget build(BuildContext context) {
    var upgrades = context.watch<UserPurchases>();

    Widget storeWidget;
    switch (upgrades.storeState) {
      case StoreState.loading:
        storeWidget = _PurchasesLoading();
        break;
      case StoreState.available:
        storeWidget = _PurchaseList();
        break;
      case StoreState.notAvailable:
        storeWidget = _PurchasesNotAvailable();
        break;
    }

    return Column(
      children: [
        storeWidget,
      ],
    );
  }
}

class _PurchasesLoading extends StatelessWidget {
  const _PurchasesLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Loading'),
    );
  }
}

class _PurchasesNotAvailable extends StatelessWidget {
  const _PurchasesNotAvailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Store not available'),
    );
  }
}

class _PurchaseList extends StatelessWidget {
  const _PurchaseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var purchases = context.watch<UserPurchases>();
    var products = purchases.products;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 15,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final product = products[index];
              return _PurchaseWidget(
                product: product,
                onPressed: () {
                  purchases.buy(product);
                },
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 20),
            itemCount: products.length,
          ),
        ],
      ),
    );
  }
}

class _PurchaseWidget extends StatelessWidget {
  final PurchasableProduct product;
  final VoidCallback onPressed;

  const _PurchaseWidget({
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var title = product.title;
    if (product.status == ProductStatus.purchased) {
      title += ' (purchased)';
    }
    return DialogCard(
      textAmount: 'title',
      textInfo: product.description,
      icon: Icons.shop,
      child: DialogButton(
        text: _trailing(),
        onPressed: onPressed,
      ),
    );
  }

  String _trailing() {
    switch (product.status) {
      case ProductStatus.purchasable:
        return product.price;
      case ProductStatus.purchased:
        return 'purchased';
      case ProductStatus.pending:
        return 'buying...';
    }
  }
}

// class PastPurchasesWidget extends StatelessWidget {
//   const PastPurchasesWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var purchases = context.watch<IAPRepo>().purchases;
//     return ListView.separated(
//       shrinkWrap: true,
//       itemCount: purchases.length,
//       itemBuilder: (context, index) => ListTile(
//         title: Text(purchases[index].title),
//         subtitle: Text(purchases[index].status.toString()),
//       ),
//       separatorBuilder: (context, index) => const Divider(),
//     );
//   }
// }
