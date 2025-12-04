import 'package:flutter/material.dart';
import 'package:uc_hub/screens/auth/login_screen.dart';
import 'package:uc_hub/theme/uchub_colors.dart';

void main() {
  runApp(const UCHubApp());
}

class UCHubApp extends StatelessWidget {
  const UCHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UC HUB Department',
      debugShowCheckedModeBanner: false,
      
      // Global Theme Configuration
      theme: ThemeData(
        fontFamily: 'Inter', // Ensure you have 'Inter' in your pubspec.yaml or remove this line
        useMaterial3: true,
        
        // Color Scheme derived from your Brand Colors
        colorScheme: ColorScheme.fromSeed(
          seedColor: UCHubColors.primaryEnd,
          primary: UCHubColors.primaryEnd,
          surface: UCHubColors.contentBackground,
        ),
        
        // Default Scaffold Background
        scaffoldBackgroundColor: UCHubColors.contentBackground,
        
        // AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent, // Removes the slight color tint on scroll
          elevation: 0,
          centerTitle: false,
        ),
      ),
      
      // The Entry Point of the Application
      home: const LoginScreen(), 
    );
  }
}