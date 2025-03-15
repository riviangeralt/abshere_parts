class EstablishmentDetailsModel {
  int unifiedIdFormatted;
  int mlsdOfficeId;
  int mlsdUnifiedId;
  String ministrySegment;
  String estName;
  String city;

  EstablishmentDetailsModel({
    required this.unifiedIdFormatted,
    required this.mlsdOfficeId,
    required this.mlsdUnifiedId,
    required this.ministrySegment,
    required this.estName,
    required this.city,
  });

  factory EstablishmentDetailsModel.fromJson(Map<String, dynamic> json) {
    return EstablishmentDetailsModel(
      unifiedIdFormatted:
          json['unifiedIdFormatted'] ?? 0, // Default to 0 for integers
      mlsdOfficeId: json['mlsdOfficeId'] ?? 0, // Default to 0 for integers
      mlsdUnifiedId: json['mlsdUnifiedId'] ?? 0, // Default to 0 for integers
      ministrySegment: json['ministrySegment'] ?? '', // Default to empty string
      estName: json['estName'] ?? '', // Default to empty string
      city: json['city'] ?? '', // Default to empty string
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unifiedIdFormatted'] = unifiedIdFormatted;
    data['mlsdOfficeId'] = mlsdOfficeId;
    data['mlsdUnifiedId'] = mlsdUnifiedId;
    data['ministrySegment'] = ministrySegment;
    data['estName'] = estName;
    data['city'] = city;
    return data;
  }
}
