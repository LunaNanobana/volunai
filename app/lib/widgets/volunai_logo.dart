import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class VolunAILogo extends StatelessWidget {
  final double size;
  const VolunAILogo({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: CustomPaint(
            painter: LogoPainter(),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'VOLUNAI',
          style: TextStyle(
            fontSize: size * 0.22,
            fontWeight: FontWeight.w900,
            color: AppColors.darkTeal,
            letterSpacing: 2,
          ),
        ),
        Text(
          'together',
          style: TextStyle(
            fontSize: size * 0.10,
            color: AppColors.textGrey,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer ring dark teal
    final ringPaint = Paint()
      ..color = AppColors.darkTeal
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06;
    canvas.drawCircle(center, radius * 0.92, ringPaint);

    // Left half teal
    final leftPaint = Paint()..color = AppColors.primaryTeal;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.80),
      1.5708, 3.1416, true, leftPaint,
    );

    // Right half orange
    final rightPaint = Paint()..color = AppColors.primaryOrange;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.80),
      -1.5708, 3.1416, true, rightPaint,
    );

    // Center divider
    final divPaint = Paint()
      ..color = AppColors.darkTeal
      ..strokeWidth = size.width * 0.04;
    canvas.drawLine(
      Offset(center.dx, center.dy - radius * 0.80),
      Offset(center.dx, center.dy + radius * 0.80),
      divPaint,
    );

    // Inner wave rings
    for (int i = 1; i <= 3; i++) {
      final wavePaint = Paint()
        ..color = Colors.white.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      canvas.drawCircle(center, radius * (0.2 + i * 0.15), wavePaint);
    }

    // Hands icon (simplified)
    final handPaint = Paint()..color = Colors.white;
    // Left hand
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(center.dx - radius*0.25, center.dy + radius*0.1), width: radius*0.25, height: radius*0.45),
        const Radius.circular(6),
      ),
      handPaint,
    );
    // Right hand
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(center.dx + radius*0.2, center.dy), width: radius*0.25, height: radius*0.4),
        const Radius.circular(6),
      ),
      handPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SmallLogo extends StatelessWidget {
  final double size;
  const SmallLogo({super.key, this.size = 36});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: LogoPainter()),
    );
  }
}
