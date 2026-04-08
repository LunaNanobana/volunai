import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/volunai_logo.dart';
import 'main_navigation.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const VolunAILogo(size: 130),
                const SizedBox(height: 60),
                const Text(
                  'Вы являетесь :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () => _navigate(context),
                  child: Text(
                    'Организатор',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textDark.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _navigate(context),
                    child: const Text('Пользователь'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (_) => const MainNavigation()));
  }
}
