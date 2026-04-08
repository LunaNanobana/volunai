import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/community_screen.dart';
import 'screens/emergency_screen.dart';
import 'screens/shelter_map_screen.dart';
import 'screens/shelter_qr_screen.dart';
import 'screens/safety_plan_screen.dart';
import 'screens/privacy_screen.dart';
import 'screens/panic_screen.dart';
import 'screens/resources_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const SafeSpaceApp());
}

class SafeSpaceApp extends StatelessWidget {
  const SafeSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeSpace',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/':            (ctx) => const WelcomeScreen(),
        '/home':        (ctx) => const HomeScreen(),
        '/chat':        (ctx) => const ChatScreen(),
        '/community':   (ctx) => const CommunityScreen(),
        '/emergency':   (ctx) => const EmergencyScreen(),
        '/shelter-map': (ctx) => const ShelterMapScreen(),
        '/shelter-qr':  (ctx) => const ShelterQRScreen(),
        '/safety-plan': (ctx) => const SafetyPlanScreen(),
        '/privacy':     (ctx) => const PrivacyScreen(),
        '/panic':       (ctx) => const PanicScreen(),
        '/resources':   (ctx) => const ResourcesScreen(),
      },
    );
  }
}
