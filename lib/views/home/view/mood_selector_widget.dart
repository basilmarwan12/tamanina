import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MoodSelectorController extends GetxController {
  final RxInt moodValue = 3.obs;
  final RxBool notificationsEnabled = true.obs;

  void updateMoodValue(int value) {
    moodValue.value = value;
  }

  void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;
  }

  void saveMood() {
    Get.snackbar(
      'Success',
      'Your mood has been saved',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}

class MoodSelector extends StatelessWidget {
  MoodSelector({super.key});

  final MoodSelectorController controller = Get.put(MoodSelectorController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("كيف حالك الان ؟",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp)),
        SizedBox(height: 20.h),
        Obx(
          () => AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Stack(
              key: ValueKey<int>(controller.moodValue.value),
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200.w,
                  height: 200.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ),
                _buildMoodEmoji(),
                CustomPaint(
                  size: Size(200.w, 200.w),
                  painter: CircularSliderPainter(
                    value: controller.moodValue.value,
                    onChanged: (value) {
                      controller.updateMoodValue(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Obx(() => Text(
              "${controller.moodValue.value}",
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: _colorState(controller.moodValue.value),
              ),
            )),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "10",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey,
              ),
            ),
            Spacer(),
            Text(
              "0",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Color _colorState(int value) {
    if (value <= 3) {
      return Colors.red;
    } else if (value <= 7) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  Widget _buildMoodEmoji() {
    return Obx(() {
      int value = controller.moodValue.value;
      Color emojiColor =
          value <= 3 ? Colors.red : (value <= 7 ? Colors.orange : Colors.green);

      IconData emojiIcon;
      if (value <= 3) {
        emojiIcon = Icons.sentiment_very_dissatisfied;
      } else if (value <= 7) {
        emojiIcon = Icons.sentiment_neutral;
      } else {
        emojiIcon = Icons.sentiment_very_satisfied;
      }

      return Icon(
        emojiIcon,
        size: 80.sp,
        color: emojiColor,
      );
    });
  }
}

class CircularSliderPainter extends CustomPainter {
  final int value;
  final Function(int) onChanged;
  final double startAngle = 180;
  final double endAngle = 360;

  CircularSliderPainter({required this.value, required this.onChanged});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    final trackPaint = Paint()
      ..color = Colors.purple.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      _degreesToRadians(startAngle),
      _degreesToRadians(endAngle - startAngle),
      false,
      trackPaint,
    );

    Color progressColor;
    if (value <= 3) {
      progressColor = Colors.red;
    } else if (value <= 7) {
      progressColor = Colors.amber;
    } else {
      progressColor = Colors.green;
    }

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;

    final progressAngle = (value / 10) * (endAngle - startAngle);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      _degreesToRadians(startAngle),
      _degreesToRadians(progressAngle),
      false,
      progressPaint,
    );

    final thumbPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.fill;

    final thumbAngle = startAngle + progressAngle;
    final thumbX = center.dx + radius * math.cos(_degreesToRadians(thumbAngle));
    final thumbY = center.dy + radius * math.sin(_degreesToRadians(thumbAngle));

    canvas.drawCircle(Offset(thumbX, thumbY), 12, thumbPaint);
  }

  double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool hitTest(Offset position) {
    final center = Offset(100, 100);
    final radius = 90;

    final dx = position.dx - center.dx;
    final dy = position.dy - center.dy;
    final distance = math.sqrt(dx * dx + dy * dy);

    if (distance >= radius - 20 && distance <= radius + 20) {
      final angle = math.atan2(dy, dx) * (180 / math.pi);
      final normalizedAngle = angle < 0 ? angle + 360 : angle;

      if (normalizedAngle >= startAngle && normalizedAngle <= endAngle) {
        final percentage =
            (normalizedAngle - startAngle) / (endAngle - startAngle);
        final newValue = (percentage * 10).round();
        onChanged(newValue);
        return true;
      }
    }

    return false;
  }
}
