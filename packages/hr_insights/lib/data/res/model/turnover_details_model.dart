class TurnoverDetailsModel {
  final Turnover turnover;
  final TotalEmployeeResponse totalEmployeeResponse;
  final TurnoverMessage turnoverMessage;

  TurnoverDetailsModel({
    required this.turnover,
    required this.totalEmployeeResponse,
    required this.turnoverMessage,
  });

  factory TurnoverDetailsModel.fromJson(Map<String, dynamic> json) {
    return TurnoverDetailsModel(
      turnover: Turnover.fromJson(json['turnover'] ?? {}),
      totalEmployeeResponse:
          TotalEmployeeResponse.fromJson(json['totalEmployeeResponse'] ?? {}),
      turnoverMessage: TurnoverMessage.fromJson(json['turnoverMessage'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'turnover': turnover.toJson(),
      'totalEmployeeResponse': totalEmployeeResponse.toJson(),
      'turnoverMessage': turnoverMessage.toJson(),
    };
  }
}

class Turnover {
  final double turnoverRate;
  final int totalTurnover;
  final double turnoverRatePerChange;

  Turnover({
    required this.turnoverRate,
    required this.totalTurnover,
    required this.turnoverRatePerChange,
  });

  factory Turnover.fromJson(Map<String, dynamic> json) {
    return Turnover(
      turnoverRate: (json['turnover_rate'] ?? 0.0).toDouble(),
      totalTurnover: json['total_turnover'] ?? 0,
      turnoverRatePerChange:
          (json['turnover_rate_perChange'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'turnover_rate': turnoverRate,
      'total_turnover': totalTurnover,
      'turnover_rate_perChange': turnoverRatePerChange,
    };
  }
}

class TotalEmployeeResponse {
  final int totalEmployee;
  final int totalLeavers;
  final double employeePerChange;
  final double leaverPercChange;

  TotalEmployeeResponse({
    required this.totalEmployee,
    required this.totalLeavers,
    required this.employeePerChange,
    required this.leaverPercChange,
  });

  factory TotalEmployeeResponse.fromJson(Map<String, dynamic> json) {
    return TotalEmployeeResponse(
      totalEmployee: json['TotalEmployee'] ?? 0,
      totalLeavers: json['TotalLeavers'] ?? 0,
      employeePerChange: (json['employeePerChange'] ?? 0.0).toDouble(),
      leaverPercChange: (json['leaverPercChange'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TotalEmployee': totalEmployee,
      'TotalLeavers': totalLeavers,
      'employeePerChange': employeePerChange,
      'leaverPercChange': leaverPercChange,
    };
  }
}

class TurnoverMessage {
  final String message;

  TurnoverMessage({required this.message});

  factory TurnoverMessage.fromJson(Map<String, dynamic> json) {
    return TurnoverMessage(
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
