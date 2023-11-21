


import 'package:flutter/material.dart';

class TestWidgetSpan extends StatelessWidget {
  final Color color;
  final int order;

  const TestWidgetSpan({Key? key, required this.color, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 14,
        child: Text(
          '$order',
          textAlign: TextAlign.center,
          textScaler: TextScaler.linear(order.toString().length <= 2 ? 1 : .8),
          // textScaleFactor:i.toString().length <= 2 ? 1 : .8 ,

        ));


    // return Container(
    //   color: color.withOpacity(0.5),
    //   width: 40,
    //   child: Center(child: Text(order.toString())),
    // );
  }
}