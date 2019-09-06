import 'package:flutter/material.dart';
import 'constants.dart';

class IconCardContent extends StatelessWidget {
  IconCardContent({this.icon, this.copy});

  final IconData icon;
  final String copy;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          copy,
          style: labelTextStyle,
        ),
      ],
    );
  }
}

class ReussableCard extends StatelessWidget {
  ReussableCard({this.colour, this.cardChild, this.gesture});

  final Color colour;
  final Widget cardChild;
  final Function gesture;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gesture,
      child: Container(
        margin: EdgeInsets.all(15.0),
        child: cardChild,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: colour,
        ),
      ),
    );
  }
}
