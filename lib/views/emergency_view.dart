import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamanina/views/full_video.dart';
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
                                if (_controller.value.isInitialized) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FullScreenVideoPlayer(
                                              controller: _controller),
                                    ),
                                  );
                                }
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
                          "إذا رأيت شخصًا ما يعاني من نوبة مرضية، فهناك بعض الأشياء البسيطة التي يمكنك القيام بها لمساعدته، استفد من هذه المقالة لمعرفة الإسعافات الأولية لنوبات الصرع التي عليك فعله ."),
                      _buildText(
                          "تهدف الإسعافات الأولية لنوبات الصرع إلى الحفاظ على سلامة الشخص حتى تتوقف النوبة من تلقاء نفسها، إذ تستمر معظم نوبات الصرع من 30 ثانية إلى دقيقتين ."),
                      _buildBulletPoint(
                          "نظف المنطقة المحيطة بالشخص، وقم بإزالة الأشياء الصلبة أو الحادة",
                          "مثل: النظارات، والأثاث."),
                      _buildBulletPoint("ضع وسادة تحت رأسه إن امكن.", ""),
                      _buildBulletPoint("قم بفك أي شيء حول رقبته،",
                          "مثل: الملابس، وأربطة العنق، والمجوهرات لمساعدتهم على التنفس."),
                      _buildBulletPoint(
                          "لا تحاول الضغط على الشخص أو تقييد حركته",
                          "فهذا يمكن أن يؤدي إلى الإصابة."),
                      _buildBulletPoint("لا تضع أي شيء في فم الشخص،",
                          "بما في ذلك أصابعك، ولا تحاول أن تمسك لسانه أو تجبره على فتح فمه لمنع حدوث أي إصابة."),
                      _buildBulletPoint("طمئن المارة الذين قد يشعرون بالذعر",
                          "واطلب منهم إعطاء الشخص مساحة."),
                      _buildBulletPoint("لاحظ وقت بدء النوبة وانتهائها.", ""),
                      _buildBulletPoint(
                          "قم بجعل الشخص يستلقي على جانبه عندما تتوقف التشنجات",
                          "لتسهيل التنفس وإبقاء مجرى الهواء مفتوحًا."),
                      _buildBulletPoint("لا تترك الشخص بمفرده بعد النوبة",
                          "فقد يصاب بالارتباك وابقى معه وتحدث إليه بهدوء وحاول أن تجعل الحوار مريحًا له حتى يتعافى."),
                      _buildBulletPoint(
                          "لا تعطيه أي شيء ليشربه أو يأكله حتى يتعافى تمام.",
                          ""),
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
    return SizedBox(
      width: 120,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          textStyle: const TextStyle(fontSize: 15),
        ),
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
