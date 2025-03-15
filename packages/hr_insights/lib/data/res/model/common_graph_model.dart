class CommonGraphModel {
  int value;
  String label;

  CommonGraphModel({required this.value, required this.label});

  factory CommonGraphModel.fromJson(Map<String, dynamic> json) {
    return CommonGraphModel(
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
