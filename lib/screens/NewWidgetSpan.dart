import 'package:flutter/material.dart';

class NewWidgetSpan extends StatelessWidget {
  final Color color;
  final int order;

  const NewWidgetSpan({Key? key, required this.color, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
        radius: 14,
        child: Text(
          '$order',
          textAlign: TextAlign.center,
          textScaler: TextScaler.linear(order.toString().length <= 2 ? 1 : .8),
          )
    );
  }
}