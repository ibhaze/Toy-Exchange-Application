import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StarWidget extends StatefulWidget {
  final int rating;
  const StarWidget({super.key, this.rating = 0});

  @override
  State<StarWidget> createState() => _StarWidgetState();
}

class _StarWidgetState extends State<StarWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
