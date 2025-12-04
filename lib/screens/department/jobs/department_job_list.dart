import 'package:flutter/material.dart';
import 'package:uc_hub/theme/uchub_colors.dart';
import 'package:uc_hub/screens/department/jobs/department_job_form.dart'; 
import 'package:uc_hub/screens/department/jobs/department_job_detail.dart'; // Ensure this exists

class DepartmentJobList extends StatelessWidget {
  const DepartmentJobList({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data for Jobs
    final List<Map<String, dynamic>> jobs = [
      {
        'title': 'Laboratory Assistant',
        'type': 'Part Time',
        'location': 'Onsite',
        'postedDate': '2 days ago',
        'applicants': 12,
        'status': 'Active'
      },
      {
        'title': 'Event Coordinator',
        'type': 'Contract',
        'location': 'Hybrid',
        'postedDate': '5 days ago',
        'applicants': 5,
        'status': 'Active'
      },
       {
        'title': 'Social Media Intern',
        'type': 'Internship',
        'location': 'Remote',
        'postedDate': '1 week ago',
        'applicants': 28,
        'status': 'Closed'
      },
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Action Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Active Vacancies",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: UCHubColors.textDark),
                ),
                // Create Button
                InkWell(
                  onTap: () {
                    // Navigate to Create Form (No data passed)
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const DepartmentJobForm())
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [UCHubColors.primaryStart, UCHubColors.primaryEnd],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: UCHubColors.primaryEnd.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 18),
                        SizedBox(width: 6),
                        Text(
                          "Post Job",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),

            // Job Cards List
            ...jobs.map((job) => _JobVacancyCard(job: job)).toList(),
          ],
        ),
      ),
    );
  }
}

class _JobVacancyCard extends StatelessWidget {
  final Map<String, dynamic> job;
  const _JobVacancyCard({required this.job});

  @override
  Widget build(BuildContext context) {
    // 1. Wrap the entire Container in a GestureDetector to make it clickable
    return GestureDetector(
      onTap: () {
        // Navigate to the Detail Page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DepartmentJobDetail(job: job)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Gradient Top Border
            Positioned(
              top: 0, left: 0, right: 0,
              child: Container(
                height: 4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  gradient: LinearGradient(
                    colors: [UCHubColors.borderStart, UCHubColors.borderEnd],
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Edit Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        job['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: UCHubColors.accentBlueText,
                        ),
                      ),
                      // Context Menu for Edit/Delete
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_horiz, color: Colors.grey),
                        onSelected: (value) {
                          if (value == 'edit') {
                             // Navigate to Form with data (Editing mode)
                             Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => DepartmentJobForm(jobData: job))
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 18, color: Colors.grey),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 18, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Delete', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  // Pills for Details
                  Row(
                    children: [
                      _InfoPill(text: job['location'], icon: Icons.location_on_outlined),
                      const SizedBox(width: 8),
                      _InfoPill(text: job['type'], icon: Icons.access_time),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 12),

                  // Footer Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Posted ${job['postedDate']}",
                        style: const TextStyle(fontSize: 12, color: UCHubColors.textGrey),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.person, size: 16, color: UCHubColors.primaryEnd),
                          const SizedBox(width: 4),
                          Text(
                            "${job['applicants']} Applicants",
                            style: const TextStyle(fontWeight: FontWeight.bold, color: UCHubColors.textDark),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final String text;
  final IconData icon;

  const _InfoPill({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: UCHubColors.contentBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: UCHubColors.textGrey),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: UCHubColors.textGrey, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}