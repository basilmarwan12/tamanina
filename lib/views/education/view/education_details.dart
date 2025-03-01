import 'package:flutter/material.dart';
import 'package:tamanina/models/education.dart';
import 'package:tamanina/views/education/view/education_view.dart';

class EducationDetailScreen extends StatelessWidget {
  final Education education;

  const EducationDetailScreen({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("تفاصيل التعليم"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow("📅 التاريخ", formatDateTime(education.date ?? "")),
            _buildInfoRow(
                "📝 الملاحظات",
                education.notes?.isEmpty ?? true
                    ? "لا توجد ملاحظات"
                    : education.notes!),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
