import 'package:flutter/material.dart';
import 'package:vingtun/models/cardback.dart';

class PlayerChangeAButton extends StatelessWidget {
  const PlayerChangeAButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CardBack(),
        Visibility(
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          visible: false,
          child: IconButton(
            icon: Icon(Icons.cached),
            onPressed: null,
          ),
        ),
      ],
    );
  }
}
