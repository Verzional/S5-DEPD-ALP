import 'package:flutter/material.dart';
import 'package:uc_hub/theme/uchub_colors.dart';
import 'package:uc_hub/view/pages/department/jobs/department_job_list.dart';
import 'package:uc_hub/view/pages/department/applicants/department_applicants_list.dart';
import 'package:uc_hub/view/pages/department/profile/department_profile_screen.dart';

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
    const DepartmentJobList(), // Index 0: Jobs & Manage
    const DepartmentApplicantsList(), // Index 1: Applicants
    const DepartmentProfileScreen(), // Index 2: Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UCHubColors.contentBackground,
      
      // 1. APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        
        // This sets the color of the Hamburger Icon (which appears automatically because of 'drawer')
        iconTheme: const IconThemeData(color: Colors.black87),
        
        // Reduce spacing to make Logo sit closer to the Hamburger
        titleSpacing: 0, 

        // 2. LOGO (Next to the Hamburger Menu)
        title: Row(
          children: [
            const SizedBox(width: 12), // Small gap between Menu and Logo
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => Navigator.pop(context), // Go back to Home Page
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                ),
              ),
            ),
          ],
        ),
      ),

      // 3. DRAWER (Standard Left-Side Menu)
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
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.business, color: UCHubColors.primaryEnd),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Informatics Dept.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'dave@ciputra.ac.id',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.work_outline),
              title: const Text('Jobs Vacancies'),
              selected: _selectedIndex == 0,
              // Fixed the static access error here
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