import 'package:flutter/material.dart';

class RoundEndText extends StatelessWidget {
  const RoundEndText({
    Key? key,
    required this.endingText,
    required this.counter,
  }) : super(key: key);

  final String endingText;
  final int counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: const BoxDecoration(
        color: Colors.black87,
      ),
      child: Center(
        // alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              endingText,
              style: const TextStyle(fontSize: 24.0, color: Colors.white),
            ),
            // Text(counter.toString()),
          ],
        ),
      ),
    );
  }
}
