import 'package:flutter/material.dart';
import 'package:uc_hub/view/pages/pages.dart';

void main() {
  runApp(const UCHubApp());
}

class UCHubApp extends StatelessWidget {
  const UCHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}
