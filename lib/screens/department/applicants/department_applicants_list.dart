import 'package:flutter/material.dart';
import 'package:uc_hub/theme/uchub_colors.dart';
import 'package:uc_hub/screens/department/applicants/department_applicant_detail.dart';

class DepartmentApplicantsList extends StatefulWidget {
  const DepartmentApplicantsList({super.key});

  @override
  State<DepartmentApplicantsList> createState() => _DepartmentApplicantsListState();
}

class _DepartmentApplicantsListState extends State<DepartmentApplicantsList> {
  // Mock Data
  final List<Map<String, dynamic>> _applicants = [
    {
      'id': '1',
      'name': 'Budi Santoso',
      'jobTitle': 'Laboratory Assistant',
      'major': 'Informatics 2022',
      'date': '2 hrs ago',
      'status': 'Pending', // Pending, Accepted, Rejected, On Progress
    },
    {
      'id': '2',
      'name': 'Siti Aminah',
      'jobTitle': 'Social Media Intern',
      'major': 'VCD 2021',
      'date': '1 day ago',
      'status': 'On Progress',
    },
    {
      'id': '3',
      'name': 'Kevin Wijaya',
      'jobTitle': 'Laboratory Assistant',
      'major': 'Informatics 2023',
      'date': '3 days ago',
      'status': 'Rejected',
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Accepted': return Colors.green;
      case 'Rejected': return Colors.red;
      case 'On Progress': return Colors.blue;
      default: return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(24.0),
      itemCount: _applicants.length,
      itemBuilder: (context, index) {
        final applicant = _applicants[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.withOpacity(0.1)),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DepartmentApplicantDetail(applicantData: applicant),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: UCHubColors.contentBackground,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.person, color: UCHubColors.primaryStart),
                  ),
                  const SizedBox(width: 16),
                  
                  // Text Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          applicant['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Applied for: ${applicant['jobTitle']}",
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          applicant['major'],
                          style: const TextStyle(fontSize: 12, color: UCHubColors.accentBlueText),
                        ),
                      ],
                    ),
                  ),

                  // Status & Date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(applicant['status']).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          applicant['status'],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor(applicant['status']),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        applicant['date'],
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}