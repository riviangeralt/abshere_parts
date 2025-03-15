class SalaryDetailsModel {
  int totalSalary;
  int avgSalary;
  double avgSalaryChangePercent;
  double totalSalaryChangePercent;
  String message;

  SalaryDetailsModel({
    required this.totalSalary,
    required this.avgSalary,
    required this.avgSalaryChangePercent,
    required this.totalSalaryChangePercent,
    required this.message,
  });

  factory SalaryDetailsModel.fromJson(Map<String, dynamic> json) {
    return SalaryDetailsModel(
      totalSalary: json['total_salary'],
      avgSalary: json['avg_salary'],
      avgSalaryChangePercent: json['avgSalaryChangePercent'],
      totalSalaryChangePercent: json['totalSalaryChangePercent'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_salary'] = totalSalary;
    data['avg_salary'] = avgSalary;
    data['avgSalaryChangePercent'] = avgSalaryChangePercent;
    data['totalSalaryChangePercent'] = totalSalaryChangePercent;
    data['message'] = message;
    return data;
  }
}
