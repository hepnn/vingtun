import 'package:flutter/material.dart';
import 'package:vingtun/utils/Round.dart';
import 'package:vingtun/utils/database.dart';
import 'package:vingtun/widgets/stats_card.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  List<Round> _rounds = [];

  @override
  void initState() {
    recebeDados();
    super.initState();
  }

  void recebeDados() async {
    _rounds = await DbSQLite.getData('historic');
  }

  GlobalKey<StatsCardState> keyStatsCard = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ElevatedButton(
        //     onPressed: () {
        //       setState(() {
        //         DbSQLite.deleteData('historic');
        //         recebeDados();
        //       });
        //     },
        //     child: Text('t')),
        StatsCard(
          key: keyStatsCard,
        ),
      ],
    );
  }
}
