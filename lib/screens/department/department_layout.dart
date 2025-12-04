import 'package:flutter/material.dart';
import 'package:uc_hub/theme/uchub_colors.dart';
import 'package:uc_hub/screens/department/jobs/department_job_list.dart';
import 'package:uc_hub/screens/department/applicants/department_applicants_list.dart';
import 'package:uc_hub/screens/department/profile/department_profile_screen.dart';

class DepartmentLayout extends StatefulWidget {
  const DepartmentLayout({super.key});

  @override
  State<DepartmentLayout> createState() => _DepartmentLayoutState();
}

class _DepartmentLayoutState extends State<DepartmentLayout> {
  // Current active page index
  int _selectedIndex = 0;

  // The list of pages corresponding to the menu
  final List<Widget> _pages = [
    const DepartmentJobList(), 
    const DepartmentApplicantsList(), // <-- Changed from Center text
    const DepartmentProfileScreen(),
  ];

  final List<String> _titles = [
    "Manage Jobs",
    "Student Applicants",
    "Department Profile",
  ];
  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer after selection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UCHubColors.contentBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87), // Hamburger color
        title: Row(
          children: [
            // Mini Logo
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [UCHubColors.primaryStart, UCHubColors.primaryEnd],
                ),
              ),
              child: const Text(
                'UC',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              _titles[_selectedIndex],
              style: const TextStyle(color: UCHubColors.textDark, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
      // THE HAMBURGER MENU
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [UCHubColors.primaryStart, UCHubColors.primaryEnd],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.business, color: UCHubColors.primaryEnd)),
                  SizedBox(height: 10),
                  Text('Informatics Dept.', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('dave@ciputra.ac.id', style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.work_outline),
              title: const Text('Jobs Vacancies'),
              selected: _selectedIndex == 0,
              selectedColor: UCHubColors.primaryEnd,
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.people_outline),
              title: const Text('Applicants'),
              selected: _selectedIndex == 1,
              selectedColor: UCHubColors.primaryEnd,
              onTap: () => _onItemTapped(1),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings / Profile'),
              selected: _selectedIndex == 2,
              selectedColor: UCHubColors.primaryEnd,
              onTap: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}