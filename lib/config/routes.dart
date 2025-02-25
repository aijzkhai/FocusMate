import 'package:flutter/material.dart';
import '../screens/main/home_screen.dart';
import '../screens/main/profile_screen.dart';
import '../screens/main/settings_screen.dart';
import '../screens/main/statistics_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/welcome_screen.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String statistics = '/statistics';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      welcome: (context) => const WelcomeScreen(),
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      home: (context) => const HomeScreen(),
      settings: (context) => const SettingsScreen(),
      statistics: (context) => const StatisticsScreen(),
      profile: (context) => const ProfileScreen(),
    };
  }
}
