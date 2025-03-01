import 'package:flutter/material.dart';
import 'package:tamanina/models/medicine.dart';

class MedicineDetailScreen extends StatelessWidget {
  final Medicine medicine;

  const MedicineDetailScreen({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("تفاصيل الدواء"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoRow("📌 الاسم", medicine.name),
            _buildInfoRow(
                "📅 التاريخ", medicine.dateTime.toString().substring(0, 10)),
            _buildInfoRow("📝 الملاحظات",
                medicine.notes.isEmpty ? "لا توجد ملاحظات" : medicine.notes),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: RichText(
        textDirection: TextDirection.rtl,
        text: TextSpan(
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.w900),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
