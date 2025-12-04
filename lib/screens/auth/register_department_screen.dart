import 'package:flutter/material.dart';
import 'package:uc_hub/theme/uchub_colors.dart';

class RegisterDepartmentScreen extends StatefulWidget {
  const RegisterDepartmentScreen({super.key});

  @override
  State<RegisterDepartmentScreen> createState() => _RegisterDepartmentScreenState();
}

class _RegisterDepartmentScreenState extends State<RegisterDepartmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Successful! Please Login.")));
      Navigator.pop(context); // Go back to login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Account',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: UCHubColors.textDark),
              ),
              const SizedBox(height: 8),
              const Text(
                'Register as a Department',
                style: TextStyle(fontSize: 16, color: UCHubColors.accentBlueText, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 32),

              _buildLabel("Department Name"),
              _buildInput(_nameController, "Ex: Informatics Department", Icons.business),
              
              const SizedBox(height: 16),
              _buildLabel("Department Email"),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (!value.endsWith('@ciputra.ac.id')) return 'Must be @ciputra.ac.id';
                  return null;
                },
                decoration: _inputDecoration("email@ciputra.ac.id", Icons.email_outlined),
              ),

              const SizedBox(height: 16),
              _buildLabel("Password"),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) => value != null && value.length < 6 ? 'Min 6 chars' : null,
                decoration: _inputDecoration("Create a password", Icons.lock_outline),
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UCHubColors.primaryEnd,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Register Now", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, color: UCHubColors.textDark)),
    );
  }

  Widget _buildInput(TextEditingController controller, String hint, IconData icon) {
    return TextFormField(
      controller: controller,
      validator: (v) => v!.isEmpty ? 'Required' : null,
      decoration: _inputDecoration(hint, icon),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: UCHubColors.textGrey),
      hintText: hint,
      filled: true,
      fillColor: UCHubColors.contentBackground,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
    );
  }
}