import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';

class HooksModel {
  final HooksCategory ageGroup;
  final HooksCategory gender;
  final HooksCategory tenureGroup;
  final HooksCategory jobTitle;

  HooksModel({
    required this.ageGroup,
    required this.gender,
    required this.tenureGroup,
    required this.jobTitle,
  });

  factory HooksModel.fromJson(Map<String, dynamic> json) {
    return HooksModel(
      ageGroup: HooksCategory.fromJson(json['ageGroup'] ?? {}),
      gender: HooksCategory.fromJson(json['gender'] ?? {}),
      tenureGroup: HooksCategory.fromJson(json['tenureGroup'] ?? {}),
      jobTitle: HooksCategory.fromJson(json['jobTitle'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ageGroup': ageGroup.toJson(),
      'gender': gender.toJson(),
      'tenureGroup': tenureGroup.toJson(),
      'jobTitle': jobTitle.toJson(),
    };
  }
}

class HooksCategory {
  final InsightData salary;
  final InsightData turnover;

  HooksCategory({
    required this.salary,
    required this.turnover,
  });

  factory HooksCategory.fromJson(Map<String, dynamic> json) {
    return HooksCategory(
      salary: InsightData.fromJson(json['salary'] ?? [],
          type: HrInsightsTabsEnums.salaryGrowth),
      turnover: InsightData.fromJson(json['turnover'] ?? [],
          type: HrInsightsTabsEnums.turnover),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'salary': salary.toJson(),
      'turnover': turnover.toJson(),
    };
  }
}

class InsightData {
  final List<Insight> insights;

  InsightData({
    required this.insights,
  });

  factory InsightData.fromJson(
    List<dynamic> json, {
    required HrInsightsTabsEnums type,
  }) {
    return InsightData(
      insights: json.isNotEmpty
          ? json.map((e) => Insight.fromJson(e, type)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'insights': insights.map((e) => e.toJson()).toList(),
    };
  }
}

class Insight {
  final String label;
  final double value;
  final String message;
  final HrInsightsTabsEnums type;

  Insight({
    required this.label,
    required this.value,
    required this.message,
    required this.type,
  });

  factory Insight.fromJson(
      Map<String, dynamic> json, HrInsightsTabsEnums type) {
    return Insight(
      label: json['label'] ?? '',
      value: json['value']?.toDouble() ?? 0.0,
      message: json['message'] ?? '',
      type: type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
      'message': message,
    };
  }
}
