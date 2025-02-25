class Medicine {
  String type;
  DateTime dateTime;
  String notes;

  Medicine({
    required this.type,
    required this.dateTime,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'dateTime': dateTime.toIso8601String(),
      'notes': notes,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      type: json['type'],
      dateTime: DateTime.parse(json['dateTime']),
      notes: json['notes'],
    );
  }
}
