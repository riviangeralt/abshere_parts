class EstablistmentGraphModel {
  int value;
  String label;

  EstablistmentGraphModel({required this.value, required this.label});

  factory EstablistmentGraphModel.fromJson(Map<String, dynamic> json) {
    return EstablistmentGraphModel(
      value: json['value'] ?? '',
      label: json['label'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['label'] = label;
    return data;
  }
}
