import 'package:flutter/material.dart';

class Dimensions {
  final BuildContext context;

  Dimensions(this.context);

  double get screenheight => MediaQuery.of(context).size.height;
  double get screenwidth => MediaQuery.of(context).size.width;

  double get height950 => screenheight / 0.93;
  double get height900 => screenheight / 0.98;
}
