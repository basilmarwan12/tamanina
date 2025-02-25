class Nawpat {
  final String id;
  final String userId;
  final String name;
  final String date;
  final String day;
  final String symptoms;

  Nawpat({
    required this.id,
    required this.userId,
    required this.name,
    required this.date,
    required this.day,
    required this.symptoms,
  });

  factory Nawpat.fromMap(String docId, Map<String, dynamic> data) {
    return Nawpat(
      id: docId,
      userId: data['userId'] ?? '',
      date: data['التاريخ'] ?? '',
      name: data['الاسم'] ?? '',
      day: data['اليوم'] ?? '',
      symptoms: data['الاعراض'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'التاريخ': date,
      'اليوم': day,
      'الاعراض': symptoms,
    };
  }
}
