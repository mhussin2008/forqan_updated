import 'package:flutter/material.dart';
import 'WidgetSpanWrapper.dart';
void resolveSameRow(List<GlobalKey<WidgetSpanWrapperState>> keys) {
  var middle = (keys.length / 2.0).floor();
  for (int i = 0; i < middle; i++) {
    var a = keys[i];
    var b = keys[keys.length - i - 1];
    var left = getXOffsetOf(a);
    var right = getXOffsetOf(b);
    a.currentState?.updateXOffset(right - left);
    b.currentState?.updateXOffset(left - right);
  }
}

double getYOffsetOf(GlobalKey key) {
  RenderBox? box = key.currentContext!.findRenderObject() as RenderBox;
  return box.globalToLocal(Offset.zero).dy;

  // return box!.getTransformTo(box!.parent).localToGlobal(Offset.zero).dy;
}

double getXOffsetOf(GlobalKey key) {
  RenderBox? box = key.currentContext!.findRenderObject() as RenderBox;
  return box.localToGlobal(Offset.zero).dx;
}