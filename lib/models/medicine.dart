class Medicine {
  String userId;
  String id;
  String name;
  String dateTime;
  String notes;

  Medicine({
    required this.dateTime,
    required this.notes,
    required this.userId,
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime,
      'notes': notes,
    };
  }

  factory Medicine.fromMap(String docId, Map<String, dynamic> data) {
    print(data);
    return Medicine(
      id: docId,
      userId: data['userId'] ?? '',
      dateTime: data['date'] ?? '',
      name: data['name'] ?? '',
      notes: data['notes'] ?? '',
    );
  }
}
