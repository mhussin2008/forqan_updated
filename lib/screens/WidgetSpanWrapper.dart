
import 'package:flutter/material.dart';

class WidgetSpanWrapper extends StatefulWidget {
  // const WidgetSpanWrapper({Key? key, required this.child}) : super(key: key);
  const WidgetSpanWrapper({super.key, required this.child});

  final Widget child;

  @override
  WidgetSpanWrapperState createState() => WidgetSpanWrapperState();
}

class WidgetSpanWrapperState extends State<WidgetSpanWrapper> {
  Offset offset = Offset.zero;

  void updateXOffset(double xOffset) {
    setState(() {
      offset = Offset(xOffset, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: widget.child,
    );
  }
}