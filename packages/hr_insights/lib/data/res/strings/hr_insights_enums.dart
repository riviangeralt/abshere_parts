import 'package:flutter/material.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';

enum HrInsightsTabsEnums {
  turnover('Turnover'),
  salaryGrowth('Salary Growth');

  const HrInsightsTabsEnums(this.value);

  final String value;
}

enum HrInsightsCategoryEnums {
  jobTitle('Job Title', 'jobTitle'),
  gender('Gender', 'gender'),
  tenure('Tenure', 'tenure'),
  age('Age', 'age'),
  workExp('Work Experience', 'workexp');

  const HrInsightsCategoryEnums(this.label, this.value);

  final String label;
  final String value;
}

enum HrInsightMarketEstEnum {
  market('Market', HrInsightsColors.primaryColor),
  establishment('Establishment', HrInsightsColors.secondaryColor);

  const HrInsightMarketEstEnum(this.label, this.color);

  final String label;
  final Color color;
}

enum ArrowDirection { up, down }

enum MenuOptions {
  currentYear('Current Year Only', 'currentYear'),
  prevYear('Last 12 months', 'pastYear');

  const MenuOptions(this.label, this.value);

  final String label;
  final String value;
}
