import 'package:flutter/material.dart';
import 'package:vingtun/utils/database.dart';
import 'package:vingtun/widgets/round_card.dart';

import '../utils/Round.dart';

class Historic extends StatefulWidget {
  const Historic({Key? key}) : super(key: key);

  @override
  State<Historic> createState() => _HistoricState();
}

class _HistoricState extends State<Historic> {
  List<Round> _rounds = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      receiveData();
      print(_rounds);
    });
  }

  void receiveData() async {
    _rounds = await DbSQLite.getData('historic');
  }

  String? winLoseTie(String s) {
    if (s == "-1") {
      return "defeat";
    } else if (s == '0') {
      return "tie";
    } else if (s == '1') {
      return "victory";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        // appBar: AppBar(
        //   iconTheme:
        //       IconThemeData(color: Theme.of(context).colorScheme.secondary),
        //   backgroundColor: Theme.of(context).backgroundColor,
        //   elevation: 0,
        //   title: Text(
        //     "Historic",
        //     style: Theme.of(context).textTheme.headline6,
        //   ),
        //   actions: <Widget>[
        //     Padding(
        //       padding: const EdgeInsets.all(10.0),
        //       child: IconButton(
        //         icon: const Icon(Icons.delete_outline),
        //         color: Theme.of(context).colorScheme.secondary,
        //         onPressed: () {
        //           setState(() {
        //             DbSQLite.deleteData('historic');
        //             recebeDados();
        //           });
        //         },
        //       ),
        //     )
        //   ],
        // ),
        Center(
      child: FutureBuilder(
        future: DbSQLite.getData('historic'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (_rounds.isEmpty) {
              return const Center(child: Text("Play one round!"));
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.transparent,
                  height: 10,
                ),
                padding: const EdgeInsets.all(8),
                itemCount: _rounds.length,
                itemBuilder: (context, index) {
                  return RoundCard(
                    _rounds[_rounds.length - 1 - index].state,
                    _rounds[_rounds.length - 1 - index].playerCards,
                    _rounds[_rounds.length - 1 - index].playerPoints,
                    _rounds[_rounds.length - 1 - index].dealerPoints,
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
