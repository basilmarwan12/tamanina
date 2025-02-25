import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SomeInformationScreen extends StatelessWidget {
  const SomeInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: false,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 50.w,
            height: 50.h,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.sp,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "معلومات تثقيفية",
          style: TextStyle(
            fontFamily: "Cairo",
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25.sp,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/tyyt.png",
              width: 30.w,
              height: 30.h,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(border:Border.all(color: Colors.black,width: 1) ,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(2, 4),
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                style: TextStyle(fontFamily: "Cairo", fontSize: 18.sp, color: Colors.black),
                children: [
                  _buildTitle("مقدمة:"),
                  _buildText(
                      "حدوث التشنجات هو أمر شائع؛ حيث قد تحتاج يومًا ما إلى مساعدة شخص أثناء نوبة الصرع، لذلك يجب تعلُّم ما يمكن القيام به للحفاظ على المصاب آمنا حتى تتوقف النوبة من تلقاء نفسها؛ حيث تنتهي معظم النوبات في بضع دقائق."),
                  _buildText(
                      "يُصاب شخص واحد من أصل 10 أشخاص بنوبة في الجهاز العصبي أقلّهم مرة واحدة في الحياة. والنوبات العصبية هي عبارة عن اضطراب في النشاط الكهربائي الطبيعي داخل الدماغ..."),

                  _buildTitle("كيفية مساعدة الشخص المصاب بنوبة صرع:"),
                  _buildBulletPoint("إخلاء المحيط", "الحرص على إبعاد الشخص عن أي أدوات أو مواقف خطيرة."),
                  _buildBulletPoint("الانخفاض", "مساعدة الشخص على الجلوس أو الاستلقاء بتأنّ على الأرض."),
                  _buildBulletPoint("الإستدارة", "يتحسّن تنفس المريض إذا استلقى على جانبه، ويجب توجيه فم المريض نحو الأرض."),
                  _buildBulletPoint("حماية الرأس", "سند رأس المريض كي لا يرتطم بالأرض."),
                  _buildBulletPoint("تجنّب الاختناق", "عدم وضع أي شيء في فم المريض."),
                  _buildBulletPoint("إفلات المريض", "عدم كبح المريض أو منعه من الحركة."),
                  _buildBulletPoint("مراعاة الوضع", "ترك مساحة للمريض وطمأنته بعد انتهاء النوبة."),

                  _buildTitle("🚨 متى يجب الاتصال بالطوارئ؟"),
                  _buildBulletPoint("إصابة الشخص بنوبات متتالية دون أن يستعيد وعيه.", ""),
                  _buildBulletPoint("صعوبة في التنفس أو اختناق.", ""),
                  _buildBulletPoint("إصابة الشخص بجروح أثناء النوبة.", ""),
                  _buildBulletPoint("إصابة الشخص بنوبة للمرّة الأولى في حياته.", ""),

                  _buildTitle("العلاجات المتوفرة:"),
                  _buildText(
                      "تساعد الأدوية المضادة للصرع على السيطرة على النوبات... كما تشمل أساليب العلاج الجراحة، الحمية الكيتونية، وأجهزة التحكم بالنوبات."),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper function for bold section titles
  TextSpan _buildTitle(String title) {
    return TextSpan(
      text: "\n$title\n",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp,fontFamily: "Cairo"),
    );
  }

  // Helper function for normal paragraph text
  TextSpan _buildText(String text) {
    return TextSpan(
      text: "\n$text\n",
      style: TextStyle(fontSize: 18.sp,fontFamily: 'Cairo'),
    );
  }

  // Helper function for bullet points
  TextSpan _buildBulletPoint(String title, String description) {
    return TextSpan(
      children: [
        TextSpan(
          text: "🔹 $title: ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp,fontFamily: 'Cairo'),
        ),
        TextSpan(
          text: "$description\n",
          style: TextStyle(fontSize: 18.sp,fontFamily: 'Cairo'),
        ),
      ],
    );
  }
}
