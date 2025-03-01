import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SomeInformationScreen extends StatelessWidget {
  const SomeInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: false,
        backgroundColor: Colors.white,
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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
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
                style: TextStyle(
                    fontFamily: "Cairo", fontSize: 18.sp, color: Colors.black),
                children: [
                  _buildText(
                      "الإجهاد الدراسي والتوتر وقلة النوم من العوامل التي قد تزيد من احتمالية حدوث نوبات الصرع. لذلك، من الضروري اتباع استراتيجيات تساعد على إدارة هذه العوامل بفعالية للحفاظ على استقرار الحالة الصحية."),
                  _buildTitle("1. تأثير الإجهاد الدراسي على مريض الصرع"),
                  _buildBulletPoint(
                      "قد يؤدي الضغط الدراسي إلى زيادة القلق والتوتر، مما قد يكون محفزًا للنوبات.",
                      ""),
                  _buildBulletPoint(
                      "السهر والدراسة لساعات طويلة دون راحة قد يسبب إرهاقًا للجهاز العصبي ويزيد من خطر حدوث النوبات.",
                      ""),
                  _buildBulletPoint(
                      "ضعف التركيز الناتج عن التعب قد يؤدي إلى انخفاض الأداء الدراسي، مما يزيد من الشعور بالتوتر.",
                      ""),
                  _buildTitle("كيفية التعامل مع الإجهاد الدراسي"),
                  _buildBulletPoint("✅ تنظيم الوقت والدراسة بذكاء",
                      "إنشاء جدول دراسي متوازن يمنع التراكم والضغط في اللحظات الأخيرة."),
                  _buildBulletPoint("استخدام تقنية \"البومودورو\" ",
                      "(الدراسة لمدة 25-50 دقيقة ثم أخذ استراحة قصيرة)."),
                  _buildBulletPoint(
                      "التركيز على المواد الأكثر صعوبة عندما يكون العقل في حالة نشطة.",
                      ""),
                  _buildBulletPoint("✅ أخذ فترات راحة منتظمة",
                      "تجنب الدراسة لساعات طويلة متواصلة، وخذ فترات راحة للحركة والاسترخاء."),
                  _buildBulletPoint(
                      "ممارسة تمارين خفيفة أو المشي لمدة 5-10 دقائق خلال الاستراحات.",
                      ""),
                  _buildTitle("2. تأثير التوتر على مريض الصرع"),
                  _buildBulletPoint(
                      "التوتر يزيد من نشاط الجهاز العصبي، مما قد يكون محفزًا للنوبات.",
                      ""),
                  _buildBulletPoint(
                      "يؤدي إلى ارتفاع هرمونات التوتر مثل الكورتيزول، مما قد يضعف استقرار الحالة العصبية.",
                      ""),
                  _buildBulletPoint(
                      "الشعور بالقلق المستمر قد يؤثر على النوم، مما يزيد من احتمالية حدوث النوبات.",
                      ""),
                  _buildTitle("كيفية التعامل مع التوتر"),
                  _buildBulletPoint("✅ ممارسة تقنيات الاسترخاء",
                      "تمارين التنفس العميق: استنشاق الهواء ببطء، ثم زفيره ببطء للمساعدة في تهدئة الجهاز العصبي."),
                  _buildBulletPoint("التأمل واليوغا",
                      "يساعدان في تقليل القلق وتحسين التركيز الذهني."),
                  _buildBulletPoint(
                      "الاستماع إلى الموسيقى الهادئة أو ممارسة الهوايات المفضلة.",
                      ""),
                  _buildBulletPoint("✅ طلب الدعم عند الحاجة",
                      "التحدث مع العائلة أو الأصدقاء عن الضغوط الدراسية يمكن أن يخفف من التوتر."),
                  _buildBulletPoint(
                      "استشارة طبيب أو أخصائي نفسي عند الشعور بقلق مفرط يؤثر على الأداء اليومي.",
                      ""),
                  _buildTitle("3. تأثير قلة النوم على مريض الصرع"),
                  _buildBulletPoint(
                      "قلة النوم من أهم محفزات نوبات الصرع، حيث تؤدي إلى اضطراب نشاط الدماغ وزيادة الحساسية للنوبات.",
                      ""),
                  _buildBulletPoint(
                      "النوم المتقطع أو غير المنتظم قد يؤثر على الذاكرة والتركيز، مما يزيد من صعوبة الدراسة.",
                      ""),
                  _buildBulletPoint(
                      "الإرهاق الناتج عن السهر قد يضعف الجهاز المناعي ويؤدي إلى زيادة التوتر.",
                      ""),
                  _buildTitle("كيفية تحسين جودة النوم"),
                  _buildBulletPoint("✅ الالتزام بروتين نوم منتظم",
                      "النوم والاستيقاظ في نفس التوقيت يوميًا، حتى في عطلات نهاية الأسبوع."),
                  _buildBulletPoint("تجنب القيلولة الطويلة ",
                      "(لا تزيد عن 20-30 دقيقة خلال النهار)."),
                  _buildBulletPoint("✅ خلق بيئة نوم مريحة",
                      "النوم في غرفة مظلمة وهادئة وذات درجة حرارة مناسبة."),
                  _buildBulletPoint("تجنب استخدام الشاشات ",
                      "(الهاتف، الكمبيوتر) قبل النوم بساعة على الأقل."),
                  _buildBulletPoint("✅ تجنب المنبهات قبل النوم",
                      "تجنب الكافيين (الشاي، القهوة، المشروبات الغازية) خاصة في المساء."),
                  _buildBulletPoint(
                      "تناول وجبة خفيفة قبل النوم، والابتعاد عن الأطعمة الدسمة أو الثقيلة.",
                      ""),
                  _buildTitle("خلاصة"),
                  _buildBulletPoint("الإجهاد الدراسي",
                      "يمكن التحكم فيه من خلال تنظيم الوقت وأخذ فترات راحة."),
                  _buildBulletPoint("التوتر",
                      "يمكن تخفيفه بممارسة الاسترخاء وطلب الدعم عند الحاجة."),
                  _buildBulletPoint("قلة النوم",
                      "تؤثر بشكل مباشر على استقرار الحالة الصحية، لذا من الضروري الالتزام بنظام نوم منتظم."),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextSpan _buildTitle(String title) {
    return TextSpan(
      text: "\n$title\n",
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 22.sp, fontFamily: "Cairo"),
    );
  }

  TextSpan _buildText(String text) {
    return TextSpan(
      text: "\n$text\n",
      style: TextStyle(fontSize: 18.sp, fontFamily: 'Cairo'),
    );
  }

  TextSpan _buildBulletPoint(String title, String description) {
    return TextSpan(
      children: [
        TextSpan(
          text: "🔹 $title: ",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              fontFamily: 'Cairo'),
        ),
        TextSpan(
          text: "$description\n",
          style: TextStyle(fontSize: 18.sp, fontFamily: 'Cairo'),
        ),
      ],
    );
  }
}
