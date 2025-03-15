import 'package:flutter/material.dart';
import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';

class StatItemModel {
  final String label;
  final double value;
  final String percChange;
  final Color color;
  final ArrowDirection arrowDir;
  final bool isPositive;

  StatItemModel({
    required this.label,
    required this.value,
    required this.percChange,
    required this.color,
    required this.arrowDir,
    required this.isPositive,
  });
}
