import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      
      theme: ThemeData(
        useMaterial3: true,

        // APPLY POPPINS
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryTextTheme: GoogleFonts.poppinsTextTheme(),

        colorScheme: ColorScheme.fromSeed(
          seedColor: UCHubColors.primaryEnd,
          primary: UCHubColors.primaryEnd,
          surface: UCHubColors.contentBackground,
        ),
        
        scaffoldBackgroundColor: UCHubColors.contentBackground,
        
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      
      home: const LoginScreen(),
    );
  }
}
