import 'package:flutter/material.dart';
import 'view/pages/job_vacancies_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job Vacancy Preview',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const JobVacanciesPage(),
    );
  }
}
