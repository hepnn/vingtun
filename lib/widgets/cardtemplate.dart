import 'dart:math';
import 'package:flutter/material.dart';

class CardTemplate extends StatelessWidget {
  final flower;
  final num;
  final color;

  const CardTemplate({Key? key, this.flower, this.num, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: 120.0,
      width: 75.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(num,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: color)),
                ],
              ),
              Text(flower,
                  style: const TextStyle(
                    fontSize: 25.0,
                  )),
              Transform.rotate(
                angle: pi,
                child: Row(
                  children: [
                    Text(num.toString(),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: color)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
