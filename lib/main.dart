import 'package:flutter/material.dart';
import 'package:tg_app_final/screens/login_screen.dart';
import 'package:tg_app_final/screens/home_screen.dart';
import 'package:tg_app_final/screens/chat_screen.dart';
import 'package:tg_app_final/screens/profile_screen.dart';
import 'package:tg_app_final/screens/settings_screen.dart';
import 'package:tg_app_final/screens/edit_profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DreamLink',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF527DA3),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF527DA3),
          foregroundColor: Colors.white,
        ),
      ),
      home: const LoginScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/chat': (context) => const ChatScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
      },
    );
  }
}
