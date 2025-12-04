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
  late TextEditingController _departmentController;
  late TextEditingController _locationController;
  late TextEditingController _levelController;

  late TextEditingController _jobDescriptionController;
  late TextEditingController _minQualificationController;
  late TextEditingController _skillsController;
  late TextEditingController _deadlineController;
  late TextEditingController _peopleHiringController;
  late TextEditingController _feeRangeController;

  // Dropdown Values
  String? _selectedWorkplaceType;
  String? _selectedJobType;

  final List<String> _workplaceTypes = ['Onsite', 'Hybrid', 'Remote'];
  final List<String> _jobTypes = ['Full Time', 'Part Time', 'Contract', 'Internship'];

  @override
  void initState() {
    super.initState();

    _titleController =
        TextEditingController(text: widget.jobData?['title'] ?? '');
    _departmentController =
        TextEditingController(text: widget.jobData?['department'] ?? '');
    _locationController =
        TextEditingController(text: widget.jobData?['location'] ?? '');
    _levelController =
        TextEditingController(text: widget.jobData?['level'] ?? '');

    _jobDescriptionController = TextEditingController(
        text: widget.jobData?['description'] ?? 'We are looking for...');
    _minQualificationController = TextEditingController(
        text: widget.jobData?['minQualification'] ?? 'Minimum qualification...');
    _skillsController = TextEditingController(
        text: widget.jobData?['skills'] ?? '- Communication\n- Teamwork');
    _deadlineController =
        TextEditingController(text: widget.jobData?['deadline'] ?? '');
    _peopleHiringController = TextEditingController(
        text: widget.jobData?['peopleHiring'] ?? '');
    _feeRangeController =
        TextEditingController(text: widget.jobData?['feeRange'] ?? '');

    _selectedWorkplaceType = widget.jobData?['workplaceType'];
    _selectedJobType = widget.jobData?['jobType'];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _departmentController.dispose();
    _locationController.dispose();
    _levelController.dispose();
    _jobDescriptionController.dispose();
    _minQualificationController.dispose();
    _skillsController.dispose();
    _deadlineController.dispose();
    _peopleHiringController.dispose();
    _feeRangeController.dispose();
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
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 900;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 64 : 24,
              vertical: 24,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    "Let's Set Up Your Vacancy",
                    style: TextStyle(
                      fontSize: isWide ? 32 : 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Top row: Overview card + Find a Great Hire card
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildOverviewCard(),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          flex: 5,
                          child: _buildFindGreatHireSection(),
                        ),
                      ],
                    )
                  else ...[
                    _buildOverviewCard(),
                    const SizedBox(height: 24),
                    _buildFindGreatHireSection(),
                  ],

                  const SizedBox(height: 32),
                  _buildMoreAboutJobSection(),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // === OVERVIEW CARD (kiri kecil) ===
  Widget _buildOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Hiring Request Overview',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: UCHubColors.accentBlueText,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Use this form to start your department's hiring process. "
            "Please ensure you provide accurate and complete information so the HR team "
            "can review and publish the job vacancy effectively.",
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "This form will help you:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "1. Define the job role clearly\n"
            "2. List required qualifications & skills\n"
            "3. Explain the purpose of hiring\n"
            "4. Provide key job details for HR review\n"
            "5. Prepare a vacancy that attracts qualified candidates",
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // === SECTION 1: FIND A GREAT HIRE ===
  Widget _buildFindGreatHireSection() {
    return _buildGradientSectionCard(
      title: 'Find a Great Hire',
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Job Title
          _buildLabelledField(
            label: 'Job Title',
            child: _buildTextField(
              hint: 'Ex: Laboratory Assistant',
              controller: _titleController,
            ),
          ),
          const SizedBox(height: 16),

          // Department
          _buildLabelledField(
            label: 'Department',
            child: _buildTextField(
              hint: 'Ex: Student Affairs',
              controller: _departmentController,
            ),
          ),
          const SizedBox(height: 16),

          // Workplace & Employment type
          Row(
            children: [
              Expanded(
                child: _buildLabelledField(
                  label: 'Workplace Type',
                  child: _buildDropdown(
                    value: _selectedWorkplaceType,
                    hint: 'Select',
                    items: _workplaceTypes,
                    onChanged: (val) =>
                        setState(() => _selectedWorkplaceType = val),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildLabelledField(
                  label: 'Employment Type',
                  child: _buildDropdown(
                    value: _selectedJobType,
                    hint: 'Select',
                    items: _jobTypes,
                    onChanged: (val) =>
                        setState(() => _selectedJobType = val),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Location
          _buildLabelledField(
            label: 'Location',
            child: _buildTextField(
              hint: 'Ex: UC Surabaya',
              controller: _locationController,
            ),
          ),
          const SizedBox(height: 16),

          // Level of Position
          _buildLabelledField(
            label: 'Level of Position',
            child: _buildTextField(
              hint: 'Ex: Entry Level',
              controller: _levelController,
            ),
          ),
        ],
      ),
    );
  }

  // === SECTION 2: MORE ABOUT THE JOB ===
  Widget _buildMoreAboutJobSection() {
    return _buildGradientSectionCard(
      title: 'More About the Job',
      child: Column(
        children: [
          const SizedBox(height: 16),

          _buildLabelledField(
            label: 'Job Description',
            child: _buildTextField(
              hint: 'Describe the role...',
              controller: _jobDescriptionController,
              maxLines: 4,
            ),
          ),
          const SizedBox(height: 16),

          _buildLabelledField(
            label: 'Minimum Qualification',
            child: _buildTextField(
              hint: 'Ex: Min. SMA / Bachelor',
              controller: _minQualificationController,
            ),
          ),
          const SizedBox(height: 16),

          _buildLabelledField(
            label: 'Skills Required',
            child: _buildTextField(
              hint: '- Communication\n- Teamwork',
              controller: _skillsController,
              maxLines: 3,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildLabelledField(
                  label: 'Deadline Application',
                  child: _buildTextField(
                    hint: 'Ex: 31 Dec 2025',
                    controller: _deadlineController,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildLabelledField(
                  label: 'Number People Hiring',
                  child: _buildTextField(
                    hint: 'Ex: 3',
                    controller: _peopleHiringController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildLabelledField(
            label: 'Fee Range',
            child: _buildTextField(
              hint: 'Ex: Rp500.000 - Rp1.000.000',
              controller: _feeRangeController,
            ),
          ),
          const SizedBox(height: 24),

          // Buttons row: Preview + Create
          Row(
            children: [
              TextButton(
                onPressed: () {
                  // TODO: implement preview later
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preview coming soon')),
                  );
                },
                child: const Text(
                  'Preview',
                  style: TextStyle(
                    color: UCHubColors.accentBlueText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 44,
                child: _buildPrimaryGradientButton(
                  label: 'Create',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Simulate Save
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Job Saved Successfully!'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // === HELPERS ===

  // Section wrapper: pill gradient title + white card
  Widget _buildGradientSectionCard({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Pill header
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [UCHubColors.primaryStart, UCHubColors.primaryEnd],
              ),
              borderRadius: BorderRadius.circular(999),
              boxShadow: [
                BoxShadow(
                  color: UCHubColors.primaryEnd.withOpacity(0.4),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Card content
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildLabelledField({
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (value) =>
          value == null || value.trim().isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: UCHubColors.primaryEnd.withOpacity(0.15),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: UCHubColors.primaryEnd.withOpacity(0.15),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: UCHubColors.primaryEnd,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    required String hint,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Required' : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: UCHubColors.primaryEnd.withOpacity(0.15),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: UCHubColors.primaryEnd.withOpacity(0.15),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: UCHubColors.primaryEnd,
            width: 1.5,
          ),
        ),
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 20,
        color: UCHubColors.accentBlueText,
      ),
    );
  }

  Widget _buildPrimaryGradientButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ).copyWith(
        elevation: MaterialStateProperty.all(0),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [UCHubColors.primaryStart, UCHubColors.primaryEnd],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: UCHubColors.primaryEnd.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
