import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ─── SHELTER QR SCREEN ───────────────────────────────────────────────────────

class ShelterQRScreen extends StatefulWidget {
  const ShelterQRScreen({super.key});

  @override
  State<ShelterQRScreen> createState() => _ShelterQRScreenState();
}

class _ShelterQRScreenState extends State<ShelterQRScreen> {
  bool _generated = false;
  String _code = '';

  void _generate() {
    final rand = Random();
    final chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final suffix =
        List.generate(8, (_) => chars[rand.nextInt(chars.length)]).join();
    setState(() {
      _code = 'SF-$suffix';
      _generated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7C3AED), Color(0xFFDB2777)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 20),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Баспана кіру коды',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        Text('Shelter Entry QR',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Info alert
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F3FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFDDD6FE)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline,
                            color: Color(0xFF7C3AED), size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Қауіпсіз кіру / Secure Entry:',
                                  style: TextStyle(
                                      color: Color(0xFF6D28D9),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              SizedBox(height: 4),
                              Text(
                                  'Generate a QR code for quick and discreet entry to any SafeSpace partner shelter. Show this code at the entrance.',
                                  style: TextStyle(
                                      color: Color(0xFF7C3AED), fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (!_generated) ...[
                    AppCard(
                      child: Column(
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEDE9FE),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.qr_code_2,
                                size: 48, color: Color(0xFF7C3AED)),
                          ),
                          const SizedBox(height: 16),
                          const Text('Generate Entry Code',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF111827))),
                          const SizedBox(height: 6),
                          const Text(
                              'Create a secure QR code for immediate shelter access',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF6B7280), fontSize: 13)),
                          const SizedBox(height: 20),
                          GradientButton(
                              text: 'Generate QR Code',
                              onPressed: _generate),
                        ],
                      ),
                    ),
                  ] else ...[
                    AppCard(
                      child: Column(
                        children: [
                          // Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF16A34A),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle,
                                    color: Colors.white, size: 16),
                                SizedBox(width: 4),
                                Text('Active Entry Code',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text('Your Entry Code is Ready',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF111827))),
                          const Text('Valid for 24 hours',
                              style: TextStyle(
                                  color: Color(0xFF6B7280), fontSize: 13)),
                          const SizedBox(height: 16),
                          // QR code
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xFFDDD6FE), width: 4),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: CustomPaint(
                              size: const Size(180, 180),
                              painter: _QRPainter(),
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Code display
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F3FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                const Text('Entry Code',
                                    style: TextStyle(
                                        color: Color(0xFF7C3AED),
                                        fontSize: 12)),
                                const SizedBox(height: 4),
                                Text(_code,
                                    style: const TextStyle(
                                        color: Color(0xFF4C1D95),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 2)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.access_time,
                                  color: Color(0xFF6B7280), size: 16),
                              SizedBox(width: 4),
                              Text('Expires in 23:45:12',
                                  style: TextStyle(
                                      color: Color(0xFF6B7280), fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // How to use
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.info_outline,
                                  color: Color(0xFF7C3AED), size: 20),
                              SizedBox(width: 8),
                              Text('Қалай пайдалану / How to Use',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF111827),
                                      fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 14),
                          ...List.generate(
                            4,
                            (i) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF7C3AED),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text('${i + 1}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      [
                                        'Arrive at any SafeSpace partner shelter',
                                        'Show this QR code at the entrance scanner',
                                        'Entry will be granted immediately - no questions asked',
                                        'If no scanner available, show the code number to staff',
                                      ][i],
                                      style: const TextStyle(
                                          color: Color(0xFF374151),
                                          fontSize: 13,
                                          height: 1.4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    OutlinedButton.icon(
                      onPressed: _generate,
                      icon: const Icon(Icons.qr_code_2_outlined),
                      label: const Text('Generate New Code'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),
                  // Emergency
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFCA5A5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            'Жедел жағдайда / If you need immediate help:',
                            style: TextStyle(
                                color: Color(0xFF991B1B),
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.phone, color: Colors.white, size: 16),
                          label: const Text('Call Emergency Hotline 150',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFDC2626),
                            minimumSize: const Size(double.infinity, 44),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QRPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.black;
    final s = size.width / 20;

    // Corner markers
    void corner(double x, double y) {
      canvas.drawRect(Rect.fromLTWH(x, y, s * 5, s * 5), Paint()..color = Colors.white);
      canvas.drawRect(Rect.fromLTWH(x, y, s * 5, s * 5),
          Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = s * 0.8);
      canvas.drawRect(Rect.fromLTWH(x + s, y + s, s * 3, s * 3), p);
    }

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = Colors.white);
    corner(s, s);
    corner(size.width - s * 6, s);
    corner(s, size.height - s * 6);

    // Random data dots
    final rng = Random(42);
    for (int row = 0; row < 20; row++) {
      for (int col = 7; col < 20; col++) {
        if (row < 7 && col > 13) continue;
        if (row > 13 && col < 7) continue;
        if (rng.nextBool()) {
          canvas.drawRect(
            Rect.fromLTWH(col * s + 1, row * s + 1, s - 1, s - 1),
            p,
          );
        }
      }
    }
    for (int row = 7; row < 20; row++) {
      for (int col = 0; col < 7; col++) {
        if (row < 14) continue;
        if (rng.nextBool()) {
          canvas.drawRect(
            Rect.fromLTWH(col * s + 1, row * s + 1, s - 1, s - 1),
            p,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─── SAFETY PLAN SCREEN ──────────────────────────────────────────────────────

class SafetyPlanScreen extends StatefulWidget {
  const SafetyPlanScreen({super.key});

  @override
  State<SafetyPlanScreen> createState() => _SafetyPlanScreenState();
}

class _CheckItem {
  final int id;
  final String text;
  bool completed;

  _CheckItem(this.id, this.text, this.completed);
}

class _SafetyPlanScreenState extends State<SafetyPlanScreen> {
  final _items = [
    _CheckItem(1, 'Pack emergency bag with essentials', false),
    _CheckItem(2, 'Save copies of important documents', true),
    _CheckItem(3, 'Identify safe places to go', false),
    _CheckItem(4, 'Tell trusted friend about situation', false),
    _CheckItem(5, 'Memorize emergency contact numbers', false),
    _CheckItem(6, 'Open separate bank account', false),
  ];

  int get _completed => _items.where((i) => i.completed).length;
  double get _progress => _completed / _items.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFEA580C), Color(0xFFD97706)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 20),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Қауіпсіздік жоспары',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            Text('Safety Plan',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(14),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.25)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Plan Completion',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14)),
                              Text(
                                  '${(_progress * 100).round()}%',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: _progress,
                              backgroundColor: Colors.white.withOpacity(0.25),
                              valueColor: const AlwaysStoppedAnimation(Colors.white),
                              minHeight: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AI suggestions
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F3FF),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFDDD6FE)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.auto_awesome,
                                color: Color(0xFF7C3AED), size: 18),
                            SizedBox(width: 8),
                            Text('AI Жеке кеңестер / AI Suggestions',
                                style: TextStyle(
                                    color: Color(0xFF4C1D95),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ...[
                          'Based on your situation, consider having cash saved separately',
                          'Remember to clear browser history after using this app',
                          'In Kazakh culture, trusted elder women can be powerful allies',
                        ].map((s) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.only(top: 6),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF7C3AED),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(s,
                                        style: const TextStyle(
                                            color: Color(0xFF6D28D9),
                                            fontSize: 13,
                                            height: 1.4)),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Checklist
                  const Text('Тексеру тізімі / Safety Checklist',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF111827))),
                  const SizedBox(height: 12),
                  AppCard(
                    child: Column(
                      children: [
                        ..._items.map((item) => GestureDetector(
                              onTap: () => setState(() =>
                                  item.completed = !item.completed),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: item.completed
                                            ? const Color(0xFF16A34A)
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: item.completed
                                              ? const Color(0xFF16A34A)
                                              : const Color(0xFFD1D5DB),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: item.completed
                                          ? const Icon(Icons.check,
                                              color: Colors.white, size: 14)
                                          : null,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        item.text,
                                        style: TextStyle(
                                          color: item.completed
                                              ? const Color(0xFF9CA3AF)
                                              : const Color(0xFF111827),
                                          decoration: item.completed
                                              ? TextDecoration.lineThrough
                                              : null,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        const Divider(height: 20),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add, size: 16),
                          label: const Text('Add Custom Item'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 44),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Emergency bag
                  const Text('Жедел сөмке / Emergency Bag',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF111827))),
                  const SizedBox(height: 12),
                  AppCard(
                    child: Column(
                      children: [
                        GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 4,
                          children: [
                            'Documents',
                            'Medicines',
                            'Money',
                            'Phone charger',
                            'Clothes',
                            'Keys',
                            'Photos',
                            'Jewelry',
                          ]
                              .map((item) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF7ED),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFEA580C),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(item,
                                            style: const TextStyle(
                                                color: Color(0xFF374151),
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF7ED),
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: const Color(0xFFFED7AA)),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.shield_outlined,
                                  color: Color(0xFFEA580C), size: 16),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                    'Keep this bag hidden in a safe, accessible place',
                                    style: TextStyle(
                                        color: Color(0xFF92400E),
                                        fontSize: 12)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Cultural notes
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF5F3FF), Color(0xFFFDF2F8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.favorite,
                                color: Color(0xFF7C3AED), size: 18),
                            SizedBox(width: 8),
                            Text('Мәдени ерекшеліктер / Cultural Notes',
                                style: TextStyle(
                                    color: Color(0xFF4C1D95),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ...[
                          'In Kazakh culture, extended family can be both support and challenge',
                          'Consider trusted elder women (апалар) who understand your situation',
                          'Know that choosing safety doesn\'t mean dishonoring your culture',
                          '"Өз жаныңды құтқар" - Save yourself first',
                        ].map((s) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text('• $s',
                                  style: const TextStyle(
                                      color: Color(0xFF6D28D9),
                                      fontSize: 13,
                                      height: 1.5)),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── PRIVACY SETTINGS SCREEN ─────────────────────────────────────────────────

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacySetting {
  final String id;
  final IconData icon;
  final String titleKz;
  final String titleEn;
  final String description;
  final Color color;
  final Color bg;

  const _PrivacySetting({
    required this.id,
    required this.icon,
    required this.titleKz,
    required this.titleEn,
    required this.description,
    required this.color,
    required this.bg,
  });
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  final Map<String, bool> _settings = {
    'quickExit': true,
    'disguiseMode': false,
    'biometricLock': true,
    'autoDeleteHistory': true,
    'anonymousMode': true,
  };

  final _features = const [
    _PrivacySetting(
      id: 'quickExit',
      icon: Icons.warning_amber_rounded,
      titleKz: 'Жедел шығу',
      titleEn: 'Quick Exit',
      description: 'Shake phone 3 times to exit app and clear recent apps',
      color: Color(0xFFDC2626),
      bg: Color(0xFFFEE2E2),
    ),
    _PrivacySetting(
      id: 'disguiseMode',
      icon: Icons.remove_red_eye_outlined,
      titleKz: 'Жасыру режимі',
      titleEn: 'Disguise Mode',
      description: 'App appears as calculator or weather app',
      color: Color(0xFF7C3AED),
      bg: Color(0xFFEDE9FE),
    ),
    _PrivacySetting(
      id: 'biometricLock',
      icon: Icons.lock_outlined,
      titleKz: 'Биометриялық құлып',
      titleEn: 'Biometric Lock',
      description: 'Require fingerprint or face ID to open app',
      color: Color(0xFF2563EB),
      bg: Color(0xFFDBEAFE),
    ),
    _PrivacySetting(
      id: 'autoDeleteHistory',
      icon: Icons.delete_outline,
      titleKz: 'Тарихты жою',
      titleEn: 'Auto-Delete History',
      description: 'Automatically clear chat and browsing history after 24 hours',
      color: Color(0xFFEA580C),
      bg: Color(0xFFFFEDD5),
    ),
    _PrivacySetting(
      id: 'anonymousMode',
      icon: Icons.shield_outlined,
      titleKz: 'Анонимді режим',
      titleEn: 'Anonymous Mode',
      description: 'Hide your identity in community posts',
      color: Color(0xFF16A34A),
      bg: Color(0xFFDCFCE7),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7C3AED), Color(0xFF2563EB)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 20),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Құпиялылық',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        Text('Privacy & Security',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Safety tip
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFEF2F2), Color(0xFFFFF7ED)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFFCA5A5)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.shield_outlined,
                            color: Color(0xFFDC2626), size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Қауіпсіздік кеңесі / Safety Tip:',
                                  style: TextStyle(
                                      color: Color(0xFF991B1B),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              SizedBox(height: 4),
                              Text(
                                  'Enable Quick Exit to immediately leave the app if someone approaches. Your safety is the priority.',
                                  style: TextStyle(
                                      color: Color(0xFFB91C1C),
                                      fontSize: 13,
                                      height: 1.4)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Қауіпсіздік мүмкіндіктері / Security Features',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF111827))),
                  const SizedBox(height: 12),
                  AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: _features.asMap().entries.map((e) {
                        final i = e.key;
                        final f = e.value;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: f.bg,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(f.icon, color: f.color, size: 20),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${f.titleKz} / ${f.titleEn}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                                color: Color(0xFF111827))),
                                        const SizedBox(height: 2),
                                        Text(f.description,
                                            style: const TextStyle(
                                                color: Color(0xFF6B7280),
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: _settings[f.id] ?? false,
                                    onChanged: (v) => setState(
                                        () => _settings[f.id] = v),
                                    activeColor: const Color(0xFF7C3AED),
                                  ),
                                ],
                              ),
                            ),
                            if (i < _features.length - 1)
                              const Divider(height: 1),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Disguise mode options
                  if (_settings['disguiseMode'] == true) ...[
                    AppCard(
                      color: const Color(0xFFF5F3FF),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Choose Disguise App',
                              style: TextStyle(
                                  color: Color(0xFF4C1D95),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          const SizedBox(height: 12),
                          GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 3,
                            children: ['Calculator', 'Weather', 'Notes', 'Calendar']
                                .map((app) => OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      child: Text(app,
                                          style: const TextStyle(
                                              color: Color(0xFF374151))),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Data management
                  const Text('Деректерді басқару / Data Management',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF111827))),
                  const SizedBox(height: 12),
                  AppCard(
                    child: Column(
                      children: [
                        _DataButton(
                          icon: Icons.download_outlined,
                          iconColor: const Color(0xFF2563EB),
                          title: 'Export My Data',
                          subtitle: 'Download all your information',
                          onTap: () {},
                        ),
                        const Divider(height: 20),
                        _DataButton(
                          icon: Icons.delete_outline,
                          iconColor: const Color(0xFFEA580C),
                          title: 'Clear All History',
                          subtitle: 'Delete chat and activity history',
                          onTap: () {},
                        ),
                        const Divider(height: 20),
                        _DataButton(
                          icon: Icons.delete_forever_outlined,
                          iconColor: const Color(0xFFDC2626),
                          title: 'Delete Account',
                          subtitle: 'Permanently remove all data',
                          titleColor: const Color(0xFFDC2626),
                          subtitleColor: const Color(0xFFEF4444),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Privacy guarantee
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Құпиялылық кепілдігі / Privacy Guarantee',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF111827))),
                        const SizedBox(height: 10),
                        ...[
                          'End-to-end encryption for all messages',
                          'No data stored on external servers',
                          'Anonymous usage - no personal information required',
                          'Compliant with Kazakhstan privacy laws',
                        ].map((s) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.only(top: 6),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF7C3AED),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(s,
                                        style: const TextStyle(
                                            color: Color(0xFF374151),
                                            fontSize: 13)),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Color? titleColor;
  final Color? subtitleColor;
  final VoidCallback onTap;

  const _DataButton({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.titleColor,
    this.subtitleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: titleColor ?? const Color(0xFF111827),
                        fontSize: 14)),
                Text(subtitle,
                    style: TextStyle(
                        color: subtitleColor ?? const Color(0xFF6B7280),
                        fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
        ],
      ),
    );
  }
}

// ─── PANIC MODE SCREEN ───────────────────────────────────────────────────────

class PanicScreen extends StatefulWidget {
  const PanicScreen({super.key});

  @override
  State<PanicScreen> createState() => _PanicScreenState();
}

class _PanicScreenState extends State<PanicScreen>
    with SingleTickerProviderStateMixin {
  bool _activated = false;
  bool _calling = false;
  bool _locationShared = false;
  int _shakeCount = 0;
  int _countdown = 5;
  late AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _activate() {
    setState(() {
      _activated = true;
      _countdown = 5;
    });
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted || !_activated) return;
      if (_countdown > 0) {
        setState(() => _countdown--);
        _startCountdown();
      } else {
        setState(() => _calling = true);
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) setState(() => _locationShared = true);
        });
      }
    });
  }

  void _cancel() {
    setState(() {
      _activated = false;
      _calling = false;
      _locationShared = false;
      _countdown = 5;
      _shakeCount = 0;
    });
  }

  void _addShake() {
    setState(() => _shakeCount = (_shakeCount + 1).clamp(0, 3));
    if (_shakeCount >= 3) _activate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          AnimatedBuilder(
            animation: _pulseCtrl,
            builder: (_, __) => Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _activated
                      ? [
                          Color.lerp(const Color(0xFFDC2626),
                              const Color(0xFFB91C1C), _pulseCtrl.value)!,
                          Color.lerp(const Color(0xFFEF4444),
                              const Color(0xFFDC2626), _pulseCtrl.value)!,
                        ]
                      : [const Color(0xFFDC2626), const Color(0xFFEA580C)],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed:
                            _activated ? null : () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios_new,
                            color: _activated
                                ? Colors.white54
                                : Colors.white,
                            size: 20),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Дабыл режимі',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          Text('Panic Mode',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (!_activated) ...[
                    // Setup screen
                    AppCard(
                      color: const Color(0xFFFEF2F2),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFEE2E2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.smartphone,
                                color: Color(0xFFDC2626), size: 40),
                          ),
                          const SizedBox(height: 16),
                          const Text('Shake Phone to Activate',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF7F1D1D))),
                          const Text(
                              'Телефонды 3 рет шайқаңыз / Shake device 3 times quickly',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF991B1B), fontSize: 13)),
                          if (_shakeCount > 0) ...[
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                3,
                                (i) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 6),
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: i < _shakeCount
                                        ? const Color(0xFFDC2626)
                                        : const Color(0xFFE5E7EB),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${i + 1}',
                                      style: TextStyle(
                                          color: i < _shakeCount
                                              ? Colors.white
                                              : const Color(0xFF9CA3AF),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0xFFFCA5A5)),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.info_outline,
                                    color: Color(0xFFDC2626), size: 16),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                      'Tap the button below to simulate shake',
                                      style: TextStyle(
                                          color: Color(0xFF991B1B),
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // How it works
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.shield_outlined,
                                  color: Color(0xFF7C3AED), size: 20),
                              SizedBox(width: 8),
                              Text('Қалай жұмыс істейді / How It Works',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xFF111827))),
                            ],
                          ),
                          const SizedBox(height: 14),
                          ...[
                            ('Shake Detection', 'Shake your phone rapidly 3 times'),
                            ('5-Second Countdown', 'Cancel within 5 seconds if activated by mistake'),
                            ('Auto-Dial Hotline', 'Automatically calls emergency hotline (150)'),
                            ('Location Sharing', 'Sends your GPS location to trusted contacts'),
                            ('Silent Mode Option', 'Phone stays silent - no sound alerts'),
                          ].asMap().entries.map((e) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFDC2626),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text('${e.key + 1}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(e.value.$1,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF111827),
                                                  fontSize: 13)),
                                          Text(e.value.$2,
                                              style: const TextStyle(
                                                  color: Color(0xFF6B7280),
                                                  fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    GestureDetector(
                      onTap: _addShake,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFDC2626), Color(0xFFEA580C)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, color: Colors.white),
                            SizedBox(width: 8),
                            Text('Test Panic Mode (Demo)',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    // Activated screen
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFEE2E2), Color(0xFFFFF7ED)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFFDC2626), width: 3),
                      ),
                      child: Column(
                        children: [
                          AnimatedBuilder(
                            animation: _pulseCtrl,
                            builder: (_, __) => Transform.scale(
                              scale:
                                  0.9 + (_pulseCtrl.value * 0.1),
                              child: Container(
                                width: 96,
                                height: 96,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFDC2626),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.error,
                                    color: Colors.white, size: 48),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text('PANIC MODE ACTIVATED',
                              style: TextStyle(
                                  color: Color(0xFF7F1D1D),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          const Text('Дабыл режимі қосылды',
                              style: TextStyle(
                                  color: Color(0xFF991B1B), fontSize: 14)),
                          const SizedBox(height: 16),
                          if (!_calling) ...[
                            Text('Calling in $_countdown seconds...',
                                style: const TextStyle(
                                    color: Color(0xFF7F1D1D),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: (5 - _countdown) / 5,
                                backgroundColor: Colors.white,
                                valueColor: const AlwaysStoppedAnimation(
                                    Color(0xFFDC2626)),
                                minHeight: 10,
                              ),
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton(
                              onPressed: _cancel,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFFDC2626),
                                side: const BorderSide(
                                    color: Color(0xFFDC2626)),
                                minimumSize:
                                    const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text('Cancel (Press to Stop)'),
                            ),
                          ] else ...[
                            // Calling state
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                children: [
                                  AnimatedBuilder(
                                    animation: _pulseCtrl,
                                    builder: (_, __) => Transform.scale(
                                      scale: 0.85 + _pulseCtrl.value * 0.15,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF16A34A),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.phone,
                                            color: Colors.white, size: 22),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Calling Emergency Hotline',
                                          style: TextStyle(
                                              color: Color(0xFF14532D),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                      Text('150 - Connecting...',
                                          style: TextStyle(
                                              color: Color(0xFF16A34A),
                                              fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (_locationShared) ...[
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xFFBBF7D0)),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.check_circle,
                                        color: Color(0xFF16A34A), size: 18),
                                    SizedBox(width: 8),
                                    Text(
                                        'Location shared with trusted contacts',
                                        style: TextStyle(
                                            color: Color(0xFF14532D),
                                            fontSize: 13)),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 12),
                            OutlinedButton(
                              onPressed: _cancel,
                              style: OutlinedButton.styleFrom(
                                minimumSize:
                                    const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text('End Panic Mode'),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),
                  // Privacy notice
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F3FF),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFDDD6FE)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.shield_outlined,
                            color: Color(0xFF7C3AED), size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Құпиялылық / Privacy:',
                                  style: TextStyle(
                                      color: Color(0xFF4C1D95),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              SizedBox(height: 4),
                              Text(
                                  'Panic mode activation is not logged. No record is kept in the app. Your safety is the only priority.',
                                  style: TextStyle(
                                      color: Color(0xFF6D28D9),
                                      fontSize: 13,
                                      height: 1.4)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
