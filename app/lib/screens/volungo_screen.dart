import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/volunai_logo.dart';

class VolunGoScreen extends StatelessWidget {
  const VolunGoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const SmallLogo(),
                  const Expanded(
                    child: Text('VolunGo', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryOrange))),
                  const Icon(Icons.account_balance_outlined, size: 22),
                  const SizedBox(width: 8),
                  const Icon(Icons.chat_bubble_outline_rounded, size: 22),
                  const SizedBox(width: 8),
                  const Icon(Icons.notifications_outlined, size: 22),
                ],
              ),
            ),
            // Map area
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(0),
                child: Stack(
                  children: [
                    // Map background
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F5E9),
                      ),
                      child: CustomPaint(
                        painter: _MapPainter(),
                        child: const SizedBox.expand(),
                      ),
                    ),
                    // Map pins
                    Positioned(top: 80, left: 80,
                      child: _MapPin(color: Colors.red, icon: Icons.favorite)),
                    Positioned(top: 120, left: 160,
                      child: _MapPin(color: Colors.red, icon: Icons.location_on)),
                    Positioned(top: 200, right: 80,
                      child: _MapPin(color: Colors.orange, icon: Icons.emoji_events)),
                    Positioned(top: 150, right: 130,
                      child: _MapPin(color: Colors.orange, icon: Icons.park)),
                    // User pin
                    Positioned(bottom: 80, left: 100,
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          color: AppColors.primaryOrange,
                        ),
                        child: const Icon(Icons.person, color: Colors.white, size: 20),
                      )),
                  ],
                ),
              ),
            ),
            // Task card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -4))],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.location_on, color: AppColors.primaryOrange),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Задание:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                      Text('Собери мусор в парке и заработай
20 пойнов',
                        style: TextStyle(fontSize: 13, color: AppColors.textGrey)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPin extends StatelessWidget {
  final Color color;
  final IconData icon;
  const _MapPin({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44, height: 44,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 8)],
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw roads
    final roadPaint = Paint()
      ..color = const Color(0xFFCFD8DC)
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;
    
    canvas.drawLine(Offset(0, size.height * 0.4), Offset(size.width, size.height * 0.5), roadPaint);
    canvas.drawLine(Offset(size.width * 0.4, 0), Offset(size.width * 0.35, size.height), roadPaint);
    
    // Draw water/river
    final waterPaint = Paint()..color = const Color(0xFF81D4FA);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.3, 0, size.width * 0.08, size.height * 0.45), waterPaint);
    
    // Draw park
    final parkPaint = Paint()..color = const Color(0xFFA5D6A7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.55, size.height * 0.2, size.width * 0.35, size.height * 0.35),
        const Radius.circular(12)),
      parkPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
