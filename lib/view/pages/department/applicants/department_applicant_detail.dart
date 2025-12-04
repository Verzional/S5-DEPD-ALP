import 'package:flutter/material.dart';
import 'package:uc_hub/theme/uchub_colors.dart';

class DepartmentApplicantDetail extends StatefulWidget {
  final Map<String, dynamic> applicantData;

  const DepartmentApplicantDetail({super.key, required this.applicantData});

  @override
  State<DepartmentApplicantDetail> createState() => _DepartmentApplicantDetailState();
}

class _DepartmentApplicantDetailState extends State<DepartmentApplicantDetail> {
  final TextEditingController _notesController = TextEditingController();
  String _currentStatus = '';

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.applicantData['status'];
    _notesController.text = "Student has good grades in Algorithms. (Example Note)";
  }

  void _updateStatus(String newStatus) {
    setState(() {
      _currentStatus = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Application marked as $newStatus")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UCHubColors.contentBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black87),
        title: const Text("Application Detail", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Student Profile Header
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: UCHubColors.borderStart,
                    child: Icon(Icons.person, size: 40, color: UCHubColors.primaryEnd),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.applicantData['name'],
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.applicantData['major'],
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                   Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: UCHubColors.pillBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _currentStatus,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 2. Job Information
            _buildSectionHeader("Applying For"),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.work, color: UCHubColors.primaryStart),
                  const SizedBox(width: 12),
                  Text(
                    widget.applicantData['jobTitle'],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. Attachments (CV / Portfolio)
            _buildSectionHeader("Attachments"),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildAttachmentButton(Icons.picture_as_pdf, "View CV")),
                const SizedBox(width: 16),
                Expanded(child: _buildAttachmentButton(Icons.link, "View Portfolio")),
              ],
            ),
            const SizedBox(height: 24),

            // 4. Notes Section
            _buildSectionHeader("Internal Notes"),
            const SizedBox(height: 8),
            TextField(
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Add notes about this applicant...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 32),
            
            // 5. Action Buttons
            const Divider(),
            const SizedBox(height: 16),
            const Text("Update Status:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton("Reject", Colors.red, Icons.close, () => _updateStatus("Rejected")),
                _buildActionButton("Progress", Colors.blue, Icons.hourglass_empty, () => _updateStatus("On Progress")),
                _buildActionButton("Accept", Colors.green, Icons.check, () => _updateStatus("Accepted")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: UCHubColors.textDark),
    );
  }

  Widget _buildAttachmentButton(IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {
        // Mock opening file
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Opening Attachment...")));
      },
      icon: Icon(icon, size: 18, color: UCHubColors.accentBlueText),
      label: Text(label, style: const TextStyle(color: UCHubColors.accentBlueText)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: UCHubColors.borderStart),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12))
        ],
      ),
    );
  }
}