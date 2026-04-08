import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ShelterMapScreen extends StatefulWidget {
  const ShelterMapScreen({super.key});

  @override
  State<ShelterMapScreen> createState() => _ShelterMapScreenState();
}

class _Shelter {
  final int id;
  final String nameKz, nameEn, address, distance, walkTime, driveTime, phone;
  final bool available;
  final List<String> services;

  const _Shelter({
    required this.id,
    required this.nameKz,
    required this.nameEn,
    required this.address,
    required this.distance,
    required this.walkTime,
    required this.driveTime,
    required this.phone,
    required this.available,
    required this.services,
  });
}

class _ShelterMapScreenState extends State<ShelterMapScreen> {
  int _selected = 1;

  final _shelters = const [
    _Shelter(
      id: 1,
      nameKz: 'Алматы әйелдер дағдарыс орталығы',
      nameEn: "Almaty Women's Crisis Center",
      address: 'Dostyk Ave 125, Almaty',
      distance: '2.3 km',
      walkTime: '28 min',
      driveTime: '8 min',
      phone: '+7 (727) 292-91-04',
      available: true,
      services: ['24/7 Shelter', 'Legal Aid', 'Counseling', 'Children Welcome'],
    ),
    _Shelter(
      id: 2,
      nameKz: 'Қауіпсіз баспана орталығы',
      nameEn: 'Safe Haven Center',
      address: 'Abay Ave 52, Almaty',
      distance: '4.7 km',
      walkTime: '58 min',
      driveTime: '15 min',
      phone: '+7 (727) 250-15-89',
      available: true,
      services: ['Shelter', 'Medical', 'Job Training'],
    ),
    _Shelter(
      id: 3,
      nameKz: 'Әйелдерге қолдау үйі',
      nameEn: "Women's Support House",
      address: 'Satpaev St 90, Almaty',
      distance: '6.1 km',
      walkTime: '1h 15min',
      driveTime: '18 min',
      phone: '+7 (727) 378-44-22',
      available: false,
      services: ['Shelter', 'Education', 'Child Care'],
    ),
  ];

  _Shelter get _sel => _shelters.firstWhere((s) => s.id == _selected);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF16A34A), Color(0xFF059669)],
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
                        Text('Баспаналар картасы',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        Text('Shelter Map',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // "Map" area (grey container with pins overlay)
          SizedBox(
            height: 280,
            child: Stack(
              children: [
                // Map placeholder with gradient
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFDCFCE7), Color(0xFFBBF7D0), Color(0xFF6EE7B7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: CustomPaint(
                    painter: _MapGridPainter(),
                    child: Container(),
                  ),
                ),

                // Your location dot
                const Positioned(
                  top: 130,
                  left: 160,
                  child: _LocationDot(),
                ),

                // Shelter pins
                ..._shelters.map((s) {
                  final offsets = {1: Offset(220, 85), 2: Offset(290, 140), 3: Offset(120, 170)};
                  final pos = offsets[s.id]!;
                  return Positioned(
                    left: pos.dx,
                    top: pos.dy,
                    child: GestureDetector(
                      onTap: () => setState(() => _selected = s.id),
                      child: _ShelterPin(
                        number: s.id,
                        selected: _selected == s.id,
                        available: s.available,
                      ),
                    ),
                  );
                }),

                // Legend
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Color(0xFF2563EB),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text('Your Location',
                                style: TextStyle(fontSize: 11, color: Color(0xFF374151))),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                color: Color(0xFF16A34A), size: 14),
                            const SizedBox(width: 4),
                            const Text('Available',
                                style: TextStyle(fontSize: 11, color: Color(0xFF374151))),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                color: Color(0xFF6B7280), size: 14),
                            const SizedBox(width: 4),
                            const Text('Full',
                                style: TextStyle(fontSize: 11, color: Color(0xFF374151))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Selected shelter details
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Detail card
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: [
                          // Gradient header
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: _sel.available
                                    ? [const Color(0xFF16A34A), const Color(0xFF059669)]
                                    : [const Color(0xFF4B5563), const Color(0xFF374151)],
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(_sel.nameKz,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                          Text(_sel.nameEn,
                                              style: TextStyle(
                                                  color: Colors.white.withOpacity(0.85),
                                                  fontSize: 13)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        _sel.available ? 'Beds Available' : 'Call First',
                                        style: TextStyle(
                                          color: _sel.available
                                              ? const Color(0xFF16A34A)
                                              : const Color(0xFF374151),
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Colors.white.withOpacity(0.8), size: 14),
                                    const SizedBox(width: 4),
                                    Text(_sel.address,
                                        style: TextStyle(
                                            color: Colors.white.withOpacity(0.85),
                                            fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Distance info
                          Container(
                            color: const Color(0xFFF0FDF4),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _InfoPill(
                                    icon: Icons.navigation_outlined,
                                    value: _sel.distance,
                                    label: 'Distance'),
                                Container(height: 36, width: 1, color: const Color(0xFFBBF7D0)),
                                _InfoPill(
                                    icon: Icons.directions_walk,
                                    value: _sel.walkTime,
                                    label: 'Walking'),
                                Container(height: 36, width: 1, color: const Color(0xFFBBF7D0)),
                                _InfoPill(
                                    icon: Icons.directions_car_outlined,
                                    value: _sel.driveTime,
                                    label: 'Driving'),
                              ],
                            ),
                          ),
                          // Services
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Services Available:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF374151),
                                        fontSize: 13)),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: _sel.services
                                      .map((s) => Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color(0xFF16A34A)
                                                      .withOpacity(0.3)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(s,
                                                style: const TextStyle(
                                                    color: Color(0xFF16A34A),
                                                    fontSize: 12)),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                          // Contact
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Column(
                              children: [
                                const Divider(),
                                Row(
                                  children: [
                                    const Icon(Icons.phone_outlined,
                                        color: Color(0xFF16A34A), size: 16),
                                    const SizedBox(width: 8),
                                    Text(_sel.phone,
                                        style: const TextStyle(
                                            color: Color(0xFF374151),
                                            fontSize: 13)),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                const Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        color: Color(0xFF16A34A), size: 16),
                                    SizedBox(width: 8),
                                    Text('Open 24/7 - Emergency Access Available',
                                        style: TextStyle(
                                            color: Color(0xFF374151),
                                            fontSize: 13)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Actions
                  GradientButton(
                    text: 'Get Directions Now',
                    gradient: AppColors.greenEmerald,
                    trailing: const Icon(Icons.navigation_outlined,
                        color: Colors.white, size: 18),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.phone_outlined, size: 16),
                          label: const Text('Call Shelter'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 48),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/shelter-qr'),
                          icon: const Icon(Icons.qr_code_outlined, size: 16),
                          label: const Text('QR Entry'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 48),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Other shelters
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text('Other Nearby Shelters',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF111827))),
                  ),
                  const SizedBox(height: 10),
                  ..._shelters
                      .where((s) => s.id != _selected)
                      .map((s) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: GestureDetector(
                              onTap: () => setState(() => _selected = s.id),
                              child: AppCard(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: s.available
                                            ? const Color(0xFFDCFCE7)
                                            : const Color(0xFFF3F4F6),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.shield_outlined,
                                        color: s.available
                                            ? const Color(0xFF16A34A)
                                            : const Color(0xFF6B7280),
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(s.nameKz,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF111827),
                                                  fontSize: 13)),
                                          Text('${s.distance} away',
                                              style: const TextStyle(
                                                  color: Color(0xFF6B7280),
                                                  fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right,
                                        color: Color(0xFF9CA3AF)),
                                  ],
                                ),
                              ),
                            ),
                          )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _InfoPill(
      {required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF16A34A), size: 16),
            const SizedBox(width: 4),
            Text(value,
                style: const TextStyle(
                    color: Color(0xFF14532D),
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
          ],
        ),
        Text(label,
            style: const TextStyle(color: Color(0xFF16A34A), fontSize: 11)),
      ],
    );
  }
}

class _LocationDot extends StatefulWidget {
  const _LocationDot();

  @override
  State<_LocationDot> createState() => _LocationDotState();
}

class _LocationDotState extends State<_LocationDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..repeat();
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _anim,
            builder: (_, __) => Container(
              width: 40 * _anim.value,
              height: 40 * _anim.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2563EB)
                    .withOpacity((1 - _anim.value) * 0.4),
              ),
            ),
          ),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: const [
                BoxShadow(color: Color(0x402563EB), blurRadius: 6)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShelterPin extends StatelessWidget {
  final int number;
  final bool selected;
  final bool available;

  const _ShelterPin(
      {required this.number, required this.selected, required this.available});

  Color get _color {
    if (selected) return const Color(0xFF16A34A);
    return available ? const Color(0xFFDC2626) : const Color(0xFF6B7280);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: selected ? 1.25 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(Icons.location_on, color: _color, size: 36,
              shadows: const [Shadow(blurRadius: 8, color: Colors.black26)]),
          Positioned(
            top: 2,
            right: -2,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF16A34A) : const Color(0xFF6B7280),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: Text('$number',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF16A34A).withOpacity(0.12)
      ..strokeWidth = 1;

    // Horizontal roads
    for (double y = 60; y < size.height; y += 60) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Vertical roads
    for (double x = 60; x < size.width; x += 60) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Some blocks
    final blockPaint = Paint()
      ..color = const Color(0xFF16A34A).withOpacity(0.08);
    canvas.drawRoundRect(
        RRect.fromRectXY(const Rect.fromLTWH(70, 20, 110, 35), 4, 4),
        blockPaint);
    canvas.drawRoundRect(
        RRect.fromRectXY(const Rect.fromLTWH(200, 20, 80, 35), 4, 4),
        blockPaint);
    canvas.drawRoundRect(
        RRect.fromRectXY(const Rect.fromLTWH(20, 80, 100, 40), 4, 4),
        blockPaint);
    canvas.drawRoundRect(
        RRect.fromRectXY(const Rect.fromLTWH(170, 80, 120, 40), 4, 4),
        blockPaint);
    canvas.drawRoundRect(
        RRect.fromRectXY(const Rect.fromLTWH(70, 145, 60, 40), 4, 4),
        blockPaint);
    canvas.drawRoundRect(
        RRect.fromRectXY(const Rect.fromLTWH(200, 145, 90, 40), 4, 4),
        blockPaint);
  }

  @override
  bool shouldRepaint(_) => false;
}
