class Nawpat {
  final String id;
  final String userId;
  final String name;
  final String date;
  final String day;
  final String symptoms;
  final String type;
  final String selection;
  final String duration;
  final String location;

  Nawpat({
    required this.id,
    required this.userId,
    required this.name,
    required this.date,
    required this.day,
    required this.symptoms,
    required this.type,
    required this.selection,
    required this.duration,
    required this.location,
  });

  factory Nawpat.fromMap(String docId, Map<String, dynamic> data) {
    return Nawpat(
      id: docId,
      userId: data['userId'] ?? '',
      name: data['الاسم'] ?? '',
      date: data['التاريخ'] ?? '',
      day: data['اليوم'] ?? '',
      symptoms: data['الاعراض'] ?? '',
      type: data['النوع'] ?? '',
      selection: data['هل شعرت بها عند الحدوث؟'] ?? '',
      duration: data['المدة'] ?? '',
      location: data['أماكن الحدوث'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'الاسم': name,
      'التاريخ': date,
      'اليوم': day,
      'الاعراض': symptoms,
      'النوع': type,
      'هل شعرت بها عند الحدوث؟': selection,
      'المدة': duration,
      'أماكن الحدوث': location,
    };
  }
}
