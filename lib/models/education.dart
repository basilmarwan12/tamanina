class Education {
   String? date;
   String? notes;

   Education({this.date, this.notes});

   factory Education.fromJson(Map<String, dynamic> json) {
     return Education(
       date: json['date'],
       notes: json['notes'],
     );
   }

   Map<String, dynamic> toJson() {
     return {
       'date': date,
       'notes': notes,
     };
   }
   
   factory Education.fromMap(Map<String, dynamic> map) {
     return Education(
       date: map['date'],
       notes: map['notes'],
     );
   }
}