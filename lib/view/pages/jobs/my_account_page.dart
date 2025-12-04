import 'package:flutter/material.dart';

import '../../../data/dummy_jobs_data.dart';

class AppColors {
  static const Color backgroundCream = Color(0xFFFFF8F4);
  static const Color textDark = Color(0xFF2D3436);
  static const Color textGrey = Color(0xFF636E72);
  static const Color whiteCard = Colors.white;
  static const Color gradientStart = Color(0xFFFF8C42);
  static const Color gradientEnd = Color(0xFFFF3E8D);
  static const Color inputBorder = Color(0xFFEFF0F6);
  static const Color errorRed = Color(0xFFFF3B30);
}

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _majorCtrl;
  late TextEditingController _batchCtrl; 
  late TextEditingController _dobCtrl;

  @override
  void initState() {
    super.initState();
    // Load data dari dummy user
    final user = currentUser;
    _nameCtrl = TextEditingController(text: user.name);
    _emailCtrl = TextEditingController(text: user.email);
    _phoneCtrl = TextEditingController(text: user.phoneNumber);
    _majorCtrl = TextEditingController(text: user.major);
    _batchCtrl = TextEditingController(text: user.semester.toString());
    _dobCtrl = TextEditingController(text: "12 August 2003");
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _majorCtrl.dispose();
    _batchCtrl.dispose();
    _dobCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Account",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4), 
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          )
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: NetworkImage(currentUser.photoUrl),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.gradientStart, AppColors.gradientEnd],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          onPressed: () {
                            // Logic ganti foto
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),

              // 2. FORM DATA DIRI
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: AppColors.whiteCard,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Personal Information", style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    const SizedBox(height: 20),
                    
                    _buildLabel("Full Name"),
                    _buildTextField(_nameCtrl, "Enter your full name", Icons.person_outline),
                    const SizedBox(height: 16),

                    _buildLabel("Date of Birth"),
                    _buildTextField(_dobCtrl, "Select date", Icons.calendar_today, isReadOnly: true, onTap: () {
                      // Logic DatePicker
                    }),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Major"),
                              _buildTextField(_majorCtrl, "Major", Icons.school_outlined),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Batch (Angkatan)"),
                              _buildTextField(_batchCtrl, "Year", Icons.history_edu),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    
                    const Text("Contact Details", style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    const SizedBox(height: 20),
                    
                    _buildLabel("Email Address"),
                    _buildTextField(_emailCtrl, "Enter email", Icons.email_outlined),
                    const SizedBox(height: 16),
                    
                    _buildLabel("Phone Number"),
                    _buildTextField(_phoneCtrl, "Enter phone", Icons.phone_outlined),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 3. SETTINGS & SECURITY ACTIONS
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.whiteCard,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 5))],
                ),
                child: Column(
                  children: [
                    _buildActionTile(
                      icon: Icons.lock_outline,
                      title: "Change Password",
                      onTap: () {},
                    ),
                    const Divider(),
                    _buildActionTile(
                      icon: Icons.settings_outlined,
                      title: "Settings",
                      onTap: () {},
                    ),
                    const Divider(),
                    _buildActionTile(
                      icon: Icons.logout,
                      title: "Log Out",
                      color: AppColors.errorRed,
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // 4. SAVE BUTTON
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.gradientStart, AppColors.gradientEnd],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gradientStart.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Changes Saved Successfully!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER: FORM LABEL ---
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: AppColors.textGrey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // --- WIDGET HELPER: TEXT FIELD ---
  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {bool isReadOnly = false, VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: TextField(
        controller: controller,
        readOnly: isReadOnly,
        onTap: onTap,
        style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textDark),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
          prefixIcon: Icon(icon, color: AppColors.textGrey, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }

  // --- WIDGET HELPER: ACTION LIST TILE ---
  Widget _buildActionTile({required IconData icon, required String title, required VoidCallback onTap, Color color = AppColors.textDark}) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }
}

