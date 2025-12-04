import 'package:flutter/material.dart';
import 'package:uc_hub/theme/uchub_colors.dart';
import 'package:uc_hub/screens/department/jobs/department_job_form.dart';

class DepartmentJobDetail extends StatelessWidget {
  final Map<String, dynamic> job;

  const DepartmentJobDetail({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    // Mock extended data for display since the list usually has summary data
    final String aboutText = "We are looking for a dedicated Laboratory Assistant to help with daily operations, including equipment maintenance and student assistance during practical sessions.";
    final String requirementsText = "• Active Student (min. semester 3)\n• GPA > 3.00\n• Good communication skills\n• Able to work in a team";
    final String benefitsText = "• SAT Points (40 points)\n• Monthly Certificate\n• Flexible working hours";

    return Scaffold(
      backgroundColor: UCHubColors.contentBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black87),
        title: const Text("Job Details", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        actions: [
          // Edit Button
          IconButton(
            icon: const Icon(Icons.edit, color: UCHubColors.accentBlueText),
            onPressed: () {
               Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => DepartmentJobForm(jobData: job))
              );
            },
          ),
          // Delete Button
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () {
               _showDeleteConfirm(context);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // Header Gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job['title'],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: UCHubColors.textDark),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _DetailBadge(text: job['location'], color: Colors.blue),
                      const SizedBox(width: 8),
                      _DetailBadge(text: job['type'], color: Colors.orange),
                      const SizedBox(width: 8),
                       _DetailBadge(text: job['status'], color: job['status'] == 'Active' ? Colors.green : Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Icon(Icons.people, size: 18, color: UCHubColors.textGrey),
                      const SizedBox(width: 6),
                      Text("${job['applicants']} Applicants so far", style: const TextStyle(color: UCHubColors.textGrey)),
                    ],
                  )
                ],
              ),
            ),

            // Content Body
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: "About the Job"),
                  const SizedBox(height: 8),
                  Text(aboutText, style: const TextStyle(height: 1.5, color: Color(0xFF555555))),
                  const SizedBox(height: 24),

                  _SectionHeader(title: "Requirements"),
                  const SizedBox(height: 8),
                  Text(requirementsText, style: const TextStyle(height: 1.5, color: Color(0xFF555555))),
                  const SizedBox(height: 24),

                  _SectionHeader(title: "Benefits"),
                  const SizedBox(height: 8),
                  Text(benefitsText, style: const TextStyle(height: 1.5, color: Color(0xFF555555))),
                ],
              ),
            ),
          ],
        ),
      ),
      // Sticky Bottom Button to View Applicants
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
        ),
        child: ElevatedButton(
          onPressed: () {
            // TODO: Navigate to Applicants List filtered by this job
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Filtering Applicants...")));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: UCHubColors.primaryEnd,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text("View Applicants", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Job?"),
        content: const Text("This action cannot be undone. All applicants for this job will be notified."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context); // Go back to list
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Job Deleted")));
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _DetailBadge extends StatelessWidget {
  final String text;
  final Color color;
  const _DetailBadge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: UCHubColors.textDark),
    );
  }
}