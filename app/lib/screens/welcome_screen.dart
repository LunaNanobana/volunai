import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class _Step {
  final IconData icon;
  final String titleKz;
  final String titleEn;
  final String descKz;
  final String descEn;
  final Color iconBg;
  final Color iconColor;
  final List<Color> gradientColors;

  const _Step({
    required this.icon,
    required this.titleKz,
    required this.titleEn,
    required this.descKz,
    required this.descEn,
    required this.iconBg,
    required this.iconColor,
    required this.gradientColors,
  });
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  int _step = 0;
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  final _steps = const [
    _Step(
      icon: Icons.shield_outlined,
      titleKz: 'Қауіпсіз кеңістік',
      titleEn: 'SafeSpace',
      descKz: 'Сізге қолдау көрсетуге арналған қауіпсіз және анонимді платформа',
      descEn: 'A safe and anonymous platform designed to support you',
      iconBg: Color(0xFFEDE9FE),
      iconColor: Color(0xFF7C3AED),
      gradientColors: [Color(0xFFF5F3FF), Color(0xFFFDF2F8), Color(0xFFEFF6FF)],
    ),
    _Step(
      icon: Icons.favorite_border,
      titleKz: 'Сіз жалғыз емессіз',
      titleEn: 'You Are Not Alone',
      descKz: 'AI көмекшісі мен қолдаушы қауымдастықпен байланысыңыз',
      descEn: 'Connect with AI assistant and supportive community',
      iconBg: Color(0xFFFCE7F3),
      iconColor: Color(0xFFDB2777),
      gradientColors: [Color(0xFFFDF2F8), Color(0xFFF5F3FF), Color(0xFFEFF6FF)],
    ),
    _Step(
      icon: Icons.lock_outline,
      titleKz: 'Құпиялылық кепілдігі',
      titleEn: 'Privacy Guaranteed',
      descKz: 'Сіздің қауіпсіздігіңіз біздің басты міндетіміз',
      descEn: 'Your safety is our top priority',
      iconBg: Color(0xFFDBEAFE),
      iconColor: Color(0xFF2563EB),
      gradientColors: [Color(0xFFEFF6FF), Color(0xFFF5F3FF), Color(0xFFFDF2F8)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_step < _steps.length - 1) {
      _animCtrl.reset();
      setState(() => _step++);
      _animCtrl.forward();
    } else {
      _goHome();
    }
  }

  void _goHome() => Navigator.pushReplacementNamed(context, '/home');

  @override
  Widget build(BuildContext context) {
    final step = _steps[_step];
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: step.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Top accent bar
            Container(
              height: 4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFFEC4899), Color(0xFF2563EB)],
                ),
              ),
            ),

            // Main content
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SafeArea(
                  top: true,
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),

                        // Icon circle
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: step.iconBg,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(step.icon, size: 64, color: step.iconColor),
                        ),
                        const SizedBox(height: 36),

                        // Kazakh title
                        Text(
                          step.titleKz,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 6),

                        // English subtitle
                        Text(
                          step.titleEn,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Descriptions
                        Text(
                          step.descKz,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF374151),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          step.descEn,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 36),

                        // Progress dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _steps.length,
                            (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 8,
                              width: i == _step ? 28 : 8,
                              decoration: BoxDecoration(
                                color: i == _step
                                    ? const Color(0xFF7C3AED)
                                    : const Color(0xFFD1D5DB),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom buttons
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                child: Column(
                  children: [
                    // Primary button
                    _step < _steps.length - 1
                        ? GradientButton(
                            text: 'Жалғастыру / Continue',
                            onPressed: _next,
                            trailing: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                          )
                        : GradientButton(
                            text: 'Бастау / Get Started',
                            onPressed: _goHome,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF7C3AED), Color(0xFFDB2777)],
                            ),
                            trailing: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                          ),

                    // Skip button (only on steps 0 & 1)
                    if (_step < _steps.length - 1) ...[
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _goHome,
                        child: const Text(
                          'Өткізіп жіберу / Skip',
                          style: TextStyle(color: Color(0xFF6B7280), fontSize: 15),
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),

            // Bottom accent bar
            Container(
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFFEC4899), Color(0xFF2563EB)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
