import 'package:flutter/material.dart';

class AppColors {
  static const Color purple600 = Color(0xFF7C3AED);
  static const Color purple500 = Color(0xFF8B5CF6);
  static const Color purple100 = Color(0xFFEDE9FE);
  static const Color purple50  = Color(0xFFF5F3FF);

  static const Color pink600   = Color(0xFFDB2777);
  static const Color pink500   = Color(0xFFEC4899);
  static const Color pink100   = Color(0xFFFCE7F3);
  static const Color pink50    = Color(0xFFFDF2F8);

  static const Color blue600   = Color(0xFF2563EB);
  static const Color blue100   = Color(0xFFDBEAFE);
  static const Color blue50    = Color(0xFFEFF6FF);
  static const Color cyan600   = Color(0xFF0891B2);

  static const Color green600  = Color(0xFF16A34A);
  static const Color green500  = Color(0xFF22C55E);
  static const Color green100  = Color(0xFFDCFCE7);
  static const Color green50   = Color(0xFFF0FDF4);
  static const Color emerald600 = Color(0xFF059669);

  static const Color red600    = Color(0xFFDC2626);
  static const Color red500    = Color(0xFFEF4444);
  static const Color red100    = Color(0xFFFEE2E2);
  static const Color red50     = Color(0xFFFEF2F2);

  static const Color orange600 = Color(0xFFEA580C);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange50  = Color(0xFFFFF7ED);
  static const Color amber600  = Color(0xFFD97706);

  static const Color gray50    = Color(0xFFF9FAFB);
  static const Color gray100   = Color(0xFFF3F4F6);
  static const Color gray200   = Color(0xFFE5E7EB);
  static const Color gray300   = Color(0xFFD1D5DB);
  static const Color gray400   = Color(0xFF9CA3AF);
  static const Color gray500   = Color(0xFF6B7280);
  static const Color gray600   = Color(0xFF4B5563);
  static const Color gray700   = Color(0xFF374151);
  static const Color gray900   = Color(0xFF111827);

  static const LinearGradient purplePink = LinearGradient(
    colors: [purple600, pink600],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFFEC4899), Color(0xFF2563EB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient onboardingBg = LinearGradient(
    colors: [Color(0xFFF5F3FF), Color(0xFFFDF2F8), Color(0xFFEFF6FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient redOrange = LinearGradient(
    colors: [red600, Color(0xFFEA580C)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient greenEmerald = LinearGradient(
    colors: [green600, emerald600],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient blueCyan = LinearGradient(
    colors: [blue600, cyan600],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient purpleBlue = LinearGradient(
    colors: [purple600, blue600],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient orangeAmber = LinearGradient(
    colors: [orange600, amber600],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class AppTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.purple600),
    scaffoldBackgroundColor: AppColors.gray50,
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
        elevation: 0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.gray100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );
}

// Reusable gradient button
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final LinearGradient gradient;
  final Widget? trailing;
  final double height;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.gradient = AppColors.purplePink,
    this.trailing,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

// Reusable screen header
class ScreenHeader extends StatelessWidget {
  final String titleKz;
  final String titleEn;
  final LinearGradient gradient;
  final List<Widget>? actions;
  final Widget? bottom;

  const ScreenHeader({
    super.key,
    required this.titleKz,
    required this.titleEn,
    required this.gradient,
    this.actions,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleKz,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          titleEn,
                          style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  ...?actions,
                ],
              ),
            ),
            if (bottom != null)
              Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), child: bottom!),
          ],
        ),
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsets? padding;

  const AppCard({super.key, required this.child, this.color, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );
  }
}
