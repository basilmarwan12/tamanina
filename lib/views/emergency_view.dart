import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class EmergencyView extends StatefulWidget {
  const EmergencyView({super.key});

  @override
  _EmergencyViewState createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/video/emergency.mp4")
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.setVolume(1.0);
      }).catchError((error) {
        print("❌ Video Error: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🚑 فيديو الطوارئ"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildControlButton(
                              icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                              label: _isPlaying ? "⏸ إيقاف" : "▶️ تشغيل",
                              onPressed: () {
                                setState(() {
                                  _isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                  _isPlaying = !_isPlaying;
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            _buildControlButton(
                              icon: Icons.replay,
                              label: "🔄 إعادة",
                              onPressed: () =>
                                  _controller.seekTo(Duration.zero),
                            ),
                            const SizedBox(width: 10),
                            _buildControlButton(
                              icon: Icons.fullscreen,
                              label: "📺 ملء الشاشة",
                              onPressed: () {
                                print("📺 Fullscreen mode coming soon!");
                              },
                            ),
                          ],
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(),
            ),
            Center(
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
                        fontFamily: "Cairo",
                        fontSize: 18.sp,
                        color: Colors.black),
                    children: [
                      _buildTitle("مقدمة:"),
                      _buildText(
                          "حدوث التشنجات هو أمر شائع؛ حيث قد تحتاج يومًا ما إلى مساعدة شخص أثناء نوبة الصرع، لذلك يجب تعلُّم ما يمكن القيام به للحفاظ على المصاب آمنا حتى تتوقف النوبة من تلقاء نفسها؛ حيث تنتهي معظم النوبات في بضع دقائق."),
                      _buildText(
                          "يُصاب شخص واحد من أصل 10 أشخاص بنوبة في الجهاز العصبي أقلّهم مرة واحدة في الحياة. والنوبات العصبية هي عبارة عن اضطراب في النشاط الكهربائي الطبيعي داخل الدماغ..."),
                      _buildTitle("كيفية مساعدة الشخص المصاب بنوبة صرع:"),
                      _buildBulletPoint("إخلاء المحيط",
                          "الحرص على إبعاد الشخص عن أي أدوات أو مواقف خطيرة."),
                      _buildBulletPoint("الانخفاض",
                          "مساعدة الشخص على الجلوس أو الاستلقاء بتأنّ على الأرض."),
                      _buildBulletPoint("الإستدارة",
                          "يتحسّن تنفس المريض إذا استلقى على جانبه، ويجب توجيه فم المريض نحو الأرض."),
                      _buildBulletPoint(
                          "حماية الرأس", "سند رأس المريض كي لا يرتطم بالأرض."),
                      _buildBulletPoint(
                          "تجنّب الاختناق", "عدم وضع أي شيء في فم المريض."),
                      _buildBulletPoint(
                          "إفلات المريض", "عدم كبح المريض أو منعه من الحركة."),
                      _buildBulletPoint("مراعاة الوضع",
                          "ترك مساحة للمريض وطمأنته بعد انتهاء النوبة."),
                      _buildTitle("🚨 متى يجب الاتصال بالطوارئ؟"),
                      _buildBulletPoint(
                          "إصابة الشخص بنوبات متتالية دون أن يستعيد وعيه.", ""),
                      _buildBulletPoint("صعوبة في التنفس أو اختناق.", ""),
                      _buildBulletPoint("إصابة الشخص بجروح أثناء النوبة.", ""),
                      _buildBulletPoint(
                          "إصابة الشخص بنوبة للمرّة الأولى في حياته.", ""),
                      _buildTitle("العلاجات المتوفرة:"),
                      _buildText(
                          "تساعد الأدوية المضادة للصرع على السيطرة على النوبات... كما تشمل أساليب العلاج الجراحة، الحمية الكيتونية، وأجهزة التحكم بالنوبات."),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        textStyle: const TextStyle(fontSize: 16),
      ),
    );
  }
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
            fontWeight: FontWeight.bold, fontSize: 18.sp, fontFamily: 'Cairo'),
      ),
      TextSpan(
        text: "$description\n",
        style: TextStyle(fontSize: 18.sp, fontFamily: 'Cairo'),
      ),
    ],
  );
}
