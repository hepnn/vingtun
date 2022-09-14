import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vingtun/style/button_style.dart';
import 'package:intl/intl.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget(
      {Key? key,
      required this.hoursRemaining,
      required this.minutesRemaining,
      required this.onEnd,
      required this.onStart})
      : super(key: key);

  final int hoursRemaining;
  final int minutesRemaining;
  final VoidCallback onEnd;
  final VoidCallback onStart;

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  static var countdownDuration1 = Duration(minutes: 1);
  Duration duration1 = Duration();
  Timer? timer;
  bool countDown = true;
  @override
  void initState() {
    countdownDuration1 = Duration(
        hours: widget.hoursRemaining, minutes: widget.minutesRemaining);
    reset1();
    // WidgetsBinding.instance.addObserver(
    //     LifecycleEventHandler(resumeCallBack: () async => _refreshContent()));

    super.initState();
  }

  @override
  void deactivate() {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      timer!.cancel();
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return buildTime1();
  }

  void _refreshContent() {
    setState(() {});
  }

  Future<bool> onWillPop() async {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      timer!.cancel();
    }
    Navigator.of(context, rootNavigator: true).pop(context);
    return true;
  }

  void reset1() {
    if (countDown) {
      setState(() {
        duration1 = countdownDuration1;
        timer?.cancel();
        widget.onEnd();
      });
    } else {
      setState(() {
        duration1 = const Duration();
      });
    }
  }

  void startTimer1() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime1());
  }

  void addTime1() {
    const addSeconds = 1;
    var now = DateTime.now();

    setState(() {
      final seconds = duration1.inSeconds - addSeconds;

      final then = now.subtract(Duration(seconds: seconds));

      if (seconds < 0) {
        reset1();
        timer?.cancel();
      } else {
        print(then);

        // print('Countdown: $seconds');
        duration1 = Duration(seconds: seconds);
      }
    });
  }

  Widget buildTime1() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration1.inHours);
    final minutes = twoDigits(duration1.inMinutes.remainder(60));
    final seconds = twoDigits(duration1.inSeconds.remainder(60));
    var isRunning = timer == null ? false : timer!.isActive;

    return Column(
      children: [
        DialogButton(
            onPressed: isRunning
                ? null
                : () {
                    startTimer1();
                    setState(() {
                      widget.onStart();
                      isRunning = true;
                    });
                  },
            text: isRunning ? '$hours:$minutes' : 'Claim'),
      ],
    );
  }
}
