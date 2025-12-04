import 'package:flutter/material.dart';
import '../widgets/student_card.dart';
import 'job_vacancies_page.dart';

class StudentListPage extends StatelessWidget {
  const StudentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int gridColumnCount = screenWidth < 800 ? 2 : 3;
    double cardAspectRatio = screenWidth < 800 ? 0.8 : 1.1;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Job Vacancies'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JobVacanciesPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Student List'),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
          ],
        ),
      ),
      body: Builder(
        builder: (context) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Student List",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          margin: const EdgeInsets.only(right: 8),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Search",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 80,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text("Filter"),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridColumnCount,
                      childAspectRatio: cardAspectRatio,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return const StudentCard(
                        name: "Student Name",
                        bio: "Short bio about the student",
                        location: "Location",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
