import 'package:flutter/material.dart';
import 'package:uc_hub/theme/uchub_colors.dart';

class DepartmentProfileScreen extends StatefulWidget {
  const DepartmentProfileScreen({super.key});

  @override
  State<DepartmentProfileScreen> createState() => _DepartmentProfileScreenState();
}

class _DepartmentProfileScreenState extends State<DepartmentProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;
  late TextEditingController _descController;

  bool _isEditing = false; // Toggle to enable/disable editing

  @override
  void initState() {
    super.initState();
    // Mock Data Initialization
    _nameController = TextEditingController(text: "Informatics Department");
    _emailController = TextEditingController(text: "dave@ciputra.ac.id");
    _phoneController = TextEditingController(text: "031-7451699 (Ext 123)");
    _locationController = TextEditingController(text: "UC Main Building, 5th Floor");
    _descController = TextEditingController(text: "The Informatics Department focuses on software engineering, AI, and data science.");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // TODO: Perform API update here
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Updated Successfully")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // 1. Profile Picture / Logo Section
          Center(
            child: Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: UCHubColors.primaryEnd, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.business, size: 50, color: UCHubColors.primaryEnd),
                ),
                if (_isEditing)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: UCHubColors.textDark,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 2. Main Form
          Container(
            padding: const EdgeInsets.all(24),
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Department Info",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: UCHubColors.textDark),
                      ),
                      IconButton(
                        icon: Icon(_isEditing ? Icons.close : Icons.edit, color: UCHubColors.accentBlueText),
                        onPressed: _toggleEdit,
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 16),

                  _buildTextField("Department Name", _nameController, Icons.domain),
                  const SizedBox(height: 16),
                  _buildTextField(
                    "Email Address", 
                    _emailController, 
                    Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Required';
                      if (!value.endsWith('@ciputra.ac.id')) {
                        return 'Must be @ciputra.ac.id';
                      }
                      return null;
                    }
                  ),
                  const SizedBox(height: 16),
                  _buildTextField("Internal Phone", _phoneController, Icons.phone),
                  const SizedBox(height: 16),
                  _buildTextField("Location (Floor/Room)", _locationController, Icons.location_on_outlined),
                  const SizedBox(height: 16),
                  _buildTextField("Description", _descController, Icons.info_outline, maxLines: 3),

                  if (_isEditing) ...[
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UCHubColors.primaryEnd,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Save Changes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // 3. Settings / Account Actions
          Container(
            padding: const EdgeInsets.all(24),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Settings",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: UCHubColors.textDark),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.lock_outline, color: UCHubColors.textGrey),
                  title: const Text("Change Password"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    // TODO: Show Change Password Dialog
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text("Logout", style: TextStyle(color: Colors.redAccent)),
                  onTap: () {
                    // TODO: Handle Logout
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label, 
    TextEditingController controller, 
    IconData icon, 
    {int maxLines = 1, String? Function(String?)? validator}
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          enabled: _isEditing,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(color: _isEditing ? Colors.black : Colors.black87),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: UCHubColors.primaryStart.withOpacity(0.7)),
            filled: true,
            fillColor: _isEditing ? UCHubColors.contentBackground : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: _isEditing 
                ? const BorderSide(color: UCHubColors.borderStart) 
                : BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: _isEditing 
                ? const BorderSide(color: UCHubColors.borderStart) 
                : BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}