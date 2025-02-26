import 'package:flutter/material.dart';
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
      body: Center(
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
                        onPressed: () => _controller.seekTo(Duration.zero),
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
