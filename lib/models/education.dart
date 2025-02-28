class Education {
   String? date;
   String? id;
   String? notes;

   Education({this.date, this.notes,this.id});

   factory Education.fromJson(Map<String, dynamic> json) {
     return Education(
       date: json['date'],
       notes: json['notes'],
       id: json['id'],
     );
   }

   Map<String, dynamic> toJson() {
     return {
       'date': date,
       'notes': notes,
       'id': id
     };
   }
   
   factory Education.fromMap(Map<String, dynamic> map) {
     return Education(
       date: map['date'],
       notes: map['notes'],
       id: map['id'],
     );
   }
}