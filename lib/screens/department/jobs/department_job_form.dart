import 'package:flutter/material.dart';
import 'package:uc_hub/theme/uchub_colors.dart';

class DepartmentJobForm extends StatefulWidget {
  final Map<String, dynamic>? jobData; // If null, we are creating. If exists, we are editing.

  const DepartmentJobForm({super.key, this.jobData});

  @override
  State<DepartmentJobForm> createState() => _DepartmentJobFormState();
}

class _DepartmentJobFormState extends State<DepartmentJobForm> {
  final _formKey = GlobalKey<FormState>();

  // Form Controllers
  late TextEditingController _titleController;
  late TextEditingController _aboutController;
  late TextEditingController _requirementsController;
  late TextEditingController _benefitsController;
  
  // Dropdown Values
  String? _selectedLocationType;
  String? _selectedJobType;

  final List<String> _locationTypes = ['Onsite', 'Hybrid', 'Remote'];
  final List<String> _jobTypes = ['Full Time', 'Part Time', 'Contract', 'Internship'];

  @override
  void initState() {
    super.initState();
    // Initialize with data if editing, otherwise empty
    _titleController = TextEditingController(text: widget.jobData?['title'] ?? '');
    _aboutController = TextEditingController(text: "We are looking for..."); 
    _requirementsController = TextEditingController(text: "- Student active \n- GPA > 3.0");
    _benefitsController = TextEditingController(text: "- SAT Points\n- Certificate");
    
    _selectedLocationType = widget.jobData?['location']; // e.g., 'Onsite'
    _selectedJobType = widget.jobData?['type']; // e.g., 'Part Time'
  }

  @override
  void dispose() {
    _titleController.dispose();
    _aboutController.dispose();
    _requirementsController.dispose();
    _benefitsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.jobData != null;

    return Scaffold(
      backgroundColor: UCHubColors.contentBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditing ? 'Edit Job Vacancy' : 'New Job Vacancy',
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Basic Information"),
              const SizedBox(height: 16),
              
              // Job Title Input
              _buildTextField(
                label: "Job Title",
                hint: "Ex: Laboratory Assistant",
                controller: _titleController,
              ),
              const SizedBox(height: 16),

              // Dropdowns Row
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      label: "Location Type",
                      value: _selectedLocationType,
                      items: _locationTypes,
                      onChanged: (val) => setState(() => _selectedLocationType = val),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdown(
                      label: "Job Type",
                      value: _selectedJobType,
                      items: _jobTypes,
                      onChanged: (val) => setState(() => _selectedJobType = val),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              _buildSectionTitle("Job Details"),
              const SizedBox(height: 16),

              // Multiline Inputs
              _buildTextField(
                label: "About the Job",
                hint: "Describe the role...",
                controller: _aboutController,
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: "Requirements",
                hint: "- List requirements here...",
                controller: _requirementsController,
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: "Benefits",
                hint: "- List benefits here...",
                controller: _benefitsController,
                maxLines: 3,
              ),

              const SizedBox(height: 40),

              // SAVE BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Simulate Save
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Job Saved Successfully!")),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: EdgeInsets.zero,
                  ).copyWith(elevation: WidgetStateProperty.all(0)),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [UCHubColors.primaryStart, UCHubColors.primaryEnd],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                         BoxShadow(
                          color: UCHubColors.primaryEnd.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ]
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Save & Publish',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: UCHubColors.accentBlueText,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: (value) => value == null || value.isEmpty ? 'Required' : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: UCHubColors.primaryEnd),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
          validator: (value) => value == null ? 'Required' : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: UCHubColors.primaryEnd),
            ),
          ),
        ),
      ],
    );
  }
}