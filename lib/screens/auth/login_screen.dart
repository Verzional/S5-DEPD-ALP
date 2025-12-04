import 'package:flutter/material.dart';
import 'package:uc_hub/theme/uchub_colors.dart';
import 'package:uc_hub/screens/department/department_layout.dart';
import 'package:uc_hub/screens/auth/register_department_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    // MVP LOGIC: Direct navigation to Department Dashboard
    // In real app: Validate with backend API
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DepartmentLayout()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo Area
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [UCHubColors.primaryStart, UCHubColors.primaryEnd],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'UC HUB',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 48),

              const Text(
                'Welcome Back!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: UCHubColors.textDark),
              ),
              const SizedBox(height: 8),
              const Text(
                'Login to manage your department',
                textAlign: TextAlign.center,
                style: TextStyle(color: UCHubColors.textGrey),
              ),
              const SizedBox(height: 32),

              // Inputs
              _buildInput("Email Address", Icons.email_outlined, _emailController),
              const SizedBox(height: 16),
              _buildInput("Password", Icons.lock_outline, _passwordController, isPassword: true),
              
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {}, 
                  child: const Text("Forgot Password?", style: TextStyle(color: UCHubColors.primaryEnd))
                ),
              ),
              const SizedBox(height: 24),

              // Login Button
              ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: UCHubColors.primaryEnd,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                  shadowColor: UCHubColors.primaryEnd.withOpacity(0.4),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: UCHubColors.textGrey)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterDepartmentScreen()),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: UCHubColors.primaryEnd, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String hint, IconData icon, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: UCHubColors.textGrey),
        hintText: hint,
        filled: true,
        fillColor: UCHubColors.contentBackground,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}