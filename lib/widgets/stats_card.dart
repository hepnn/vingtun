// How to comunicate with global keys
//https://medium.com/flutter-community/flutter-communication-between-widgets-f5590230df1e

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vingtun/utils/Round.dart';
import 'package:vingtun/utils/database.dart';

class StatsCard extends StatefulWidget {
  const StatsCard({Key? key}) : super(key: key);

  @override
  StatsCardState createState() => StatsCardState();
}

class StatsCardState extends State<StatsCard> {
  late double victorys;
  late double defeats;
  late double ties;
  late int roundsNum;
  late List<Round> _rounds = [];
  static const _gap = SizedBox(height: 10);

  @override
  void initState() {
    super.initState();
    setState(() {
      getDataRounds();
    });
  }

  void updateState() {
    setState(() {
      print("Stats updated");
      getDataRounds();
    });
  }

  void getDataRounds() async {
    _rounds = await DbSQLite.getData('historic');
    roundsNum = _rounds.length;
    print("aqui $_rounds");
    print("aqui lenght ${_rounds.length} ou $roundsNum");
    victorys = victoryStats(_rounds);
    defeats = defeatStats(_rounds);
    ties = tieStats(_rounds);
  }

  double victoryStats(List<Round> list) {
    var size = list.length;
    var count = 0;
    for (Round i in list) {
      if (i.state == 1) {
        count++;
      }
    }
    print("Size: $size");
    print("Count: $count");
    var result = (count / size);
    if (result.isNaN) return 0.0;
    if (!result.isNaN) print("Esse NÃO é NAN $result");
    print("Result VICTORYS: $result");
    return result;
  }

  double defeatStats(List list) {
    int size = list.length;
    int count = 0;
    for (Round i in list) {
      if (i.state == -1) {
        count++;
      }
    }
    var result = (count / size);
    print("Result DEFEATS: $result");
    if (result.isNaN) return 0.0;

    return result;
  }

  double tieStats(List list) {
    int size = list.length;
    int count = 0;
    for (Round i in list) {
      if (i.state == 0) {
        count++;
      }
    }
    var result = (count / size);
    print("Result TIES: $result");
    if (result.isNaN) return 0.0;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: DbSQLite.getData('historic'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Wins'),
                    PercentIndicator("Victorys", victorys, Colors.green),
                    _gap,
                    Text('Defeats'),
                    PercentIndicator("Defeats", defeats, Colors.red),
                    _gap,
                    Text('Ties'),
                    PercentIndicator("Ties", ties, Colors.blue),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class PercentIndicator extends StatelessWidget {
  final double percent;
  final String name;
  final Color color;

  const PercentIndicator(this.name, this.percent, this.color, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      barRadius: Radius.circular(20.0),
      width: 200,
      lineHeight: 14.0,
      linearStrokeCap: LinearStrokeCap.roundAll,
      // radius: (MediaQuery.of(context).size.width - 18) / 5,
      // lineWidth: 8.0,
      animation: true,
      percent: percent,
      center: Text(
        percent == 0.0 ? "0.0%" : "${(percent * 100).toStringAsFixed(1)}%",
        // : "${(percent * 100.0).toStringAsFixed(1)}%",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
      // footer: Text(
      //   name,
      //   style: const TextStyle(fontSize: 14.0),
      // ),
      // circularStrokeCap: CircularStrokeCap.round,
      progressColor: color,
    );
  }
}
