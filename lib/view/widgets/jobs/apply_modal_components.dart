import 'dart:ui'; // Diperlukan untuk BackdropFilter
import 'package:flutter/material.dart';

class ModalColors {
  static const Color gradientStart = Color(0xFFFF8C42); 
  static const Color gradientEnd = Color(0xFFFF3E8D); 
  static const Color textDark = Color(0xFF2D3436);
  static const Color textGrey = Color(0xFFABAFB1);
  static const Color inputBorder = Color(0xFFEFF0F6); 
  static const Color errorRed = Color(0xFFFF4B4B);
  static const Color successGreen = Color(0xFF4CAF50);
}

class ApplyJobModalWrapper extends StatefulWidget {
  final String jobTitle;

  const ApplyJobModalWrapper({super.key, required this.jobTitle});

  @override
  State<ApplyJobModalWrapper> createState() => _ApplyJobModalWrapperState();
}

class _ApplyJobModalWrapperState extends State<ApplyJobModalWrapper> {
  int _currentStep = 1; 
  String _errorMessage = ''; 

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();

  String? _cvFileName;
  String? _portfolioFileName;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  void _nextStep() {
    setState(() {
      _errorMessage = ''; 
      _currentStep++;
    });
  }

  void _prevStep() {
    setState(() {
      _errorMessage = '';
      _currentStep--;
    });
  }

  void _showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  void _submitApplication() {
    setState(() {
      _errorMessage = '';
      _currentStep = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget content;
    switch (_currentStep) {
      case 1:
        content = _Step1ProfileContent(
          jobTitle: widget.jobTitle,
          onNext: _nextStep,
          onError: _showError,
          nameCtrl: _fullNameController,
          emailCtrl: _emailController,
          phoneCtrl: _phoneController,
          majorCtrl: _majorController,
        );
        break;
      case 2:
        content = _Step2DocumentsContent(
          jobTitle: widget.jobTitle,
          onBack: _prevStep,
          onSubmit: _submitApplication,
          onError: _showError,
          onCvChanged: (val) => setState(() => _cvFileName = val),
          onPortfolioChanged: (val) => setState(() => _portfolioFileName = val),
          cvFileName: _cvFileName,
          portfolioFileName: _portfolioFileName,
        );
        break;
      case 3:
        content = const _SuccessContent();
        break;
      default:
        content = const SizedBox.shrink();
    }

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ), 
      child: Dialog(
        backgroundColor:
            Colors.transparent, 
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          width: screenWidth > 500 ? 500 : screenWidth * 0.9,
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24), 
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_currentStep < 3) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  ModalColors.gradientStart,
                                  ModalColors.gradientEnd,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$_currentStep',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _currentStep == 1
                                ? 'Step 1 of 2: Confirm Your Profile'
                                : 'Step 2 of 2: Attach Documents',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ModalColors.textDark,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close,
                          color: ModalColors.textGrey,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Applying for: ${widget.jobTitle}',
                      style: TextStyle(
                        color: ModalColors.textGrey,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.grey[200], height: 1),
                  const SizedBox(height: 24),
                ],

                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(
                        color: ModalColors.errorRed,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Step1ProfileContent extends StatelessWidget {
  final String jobTitle;
  final VoidCallback onNext;
  final Function(String) onError;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController majorCtrl;

  const _Step1ProfileContent({
    required this.jobTitle,
    required this.onNext,
    required this.onError,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
    required this.majorCtrl,
  });

  void _validateAndProceed() {
    if (nameCtrl.text.isEmpty ||
        emailCtrl.text.isEmpty ||
        phoneCtrl.text.isEmpty ||
        majorCtrl.text.isEmpty) {
      onError("Please fill in all profile fields.");
    } else {
      onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildLabeledInput(
                "Full Name",
                "Enter Full Name",
                nameCtrl,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildLabeledInput(
                "Email Address",
                "Enter Email Address",
                emailCtrl,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildLabeledInput(
                "Phone Number",
                "Enter Phone Number",
                phoneCtrl,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildLabeledInput("Major", "Enter Major", majorCtrl),
            ),
          ],
        ),
        const SizedBox(height: 32),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: ModalColors.textGrey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Back",
                  style: TextStyle(
                    color: ModalColors.textGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: _GradientButton(
                text: "Continue to Step 2",
                onPressed: _validateAndProceed,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLabeledInput(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: ModalColors.textGrey,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: ModalColors.textGrey.withOpacity(0.7),
                fontSize: 14,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _Step2DocumentsContent extends StatelessWidget {
  final String jobTitle;
  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final Function(String) onError;
  final ValueChanged<String?> onCvChanged;
  final ValueChanged<String?> onPortfolioChanged;
  final String? cvFileName;
  final String? portfolioFileName;

  const _Step2DocumentsContent({
    required this.jobTitle,
    required this.onBack,
    required this.onSubmit,
    required this.onError,
    required this.onCvChanged,
    required this.onPortfolioChanged,
    this.cvFileName,
    this.portfolioFileName,
  });

  void _validateAndSubmit() {
    if (cvFileName == null || portfolioFileName == null) {
      onError("Please attach both CV and Portfolio.");
    } else {
      onSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel("Curriculum Vitae", required: true),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: _documentBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _OutlineSmallButton(
                    text: "Use Saved",
                    onPressed: () {
                      onCvChanged("User_CV_2025.pdf");
                      onError("");
                    },
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _GradientSmallButton(
                      icon: Icons.cloud_upload_outlined,
                      text: "Upload New File (Max 20MB, PDF/DOCX)",
                      onPressed: () {
                        onCvChanged("New_Uploaded_CV.pdf");
                        onError("");
                      },
                    ),
                  ),
                ],
              ),
              if (cvFileName != null) ...[
                const SizedBox(height: 12),
                Text(
                  cvFileName!,
                  style: const TextStyle(
                    color: ModalColors.textDark,
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),

        _buildSectionLabel("Portfolio", required: true),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: _documentBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _OutlineSmallButton(
                    text: "Use Saved",
                    onPressed: () {
                      onPortfolioChanged("User_Portfolio_2025.pdf");
                      onError("");
                    },
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _GradientSmallButton(
                      icon: Icons.cloud_upload_outlined,
                      text: "Upload New File (Max 20MB, PDF/DOCX)",
                      onPressed: () {
                        onPortfolioChanged("New_Uploaded_Portfolio.pdf");
                        onError("");
                      },
                    ),
                  ),
                ],
              ),
              if (portfolioFileName != null) ...[
                const SizedBox(height: 12),
                Text(
                  portfolioFileName!,
                  style: const TextStyle(
                    color: ModalColors.textDark,
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),

        _buildSectionLabel("Cover Letter", required: false),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: _documentBoxDecoration(),
          child: _GradientSmallButton(
            icon: Icons.cloud_upload_outlined,
            text: "Upload New File (Max 20MB, PDF/DOCX)",
            onPressed: () {
              debugPrint("Cover letter uploaded click");
            },
            fullWidth: true,
          ),
        ),

        const SizedBox(height: 32),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onBack,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: ModalColors.textGrey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Back",
                  style: TextStyle(
                    color: ModalColors.textGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: _GradientButton(
                text: "Submit Application",
                onPressed: _validateAndSubmit,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String label, {required bool required}) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: ModalColors.textDark,
          ),
        ),
        if (required)
          Text(
            " (Required)",
            style: TextStyle(
              fontSize: 12,
              color: ModalColors.textGrey.withOpacity(0.7),
            ),
          )
        else
          Text(
            " (Optional)",
            style: TextStyle(
              fontSize: 12,
              color: ModalColors.textGrey.withOpacity(0.7),
            ),
          ),
      ],
    );
  }

  BoxDecoration _documentBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

class _SuccessContent extends StatelessWidget {
  const _SuccessContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: ModalColors.successGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 50),
          ),
          const SizedBox(height: 24),
          const Text(
            "Application Submitted!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: ModalColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Good luck! You can track your application status in the 'My Applications' menu.",
            textAlign: TextAlign.center,
            style: TextStyle(color: ModalColors.textGrey),
          ),
          const SizedBox(height: 32),
          _GradientButton(
            text: "Close",
            onPressed: () => Navigator.of(context).pop(),
            width: 150,
          ),
        ],
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;

  const _GradientButton({
    required this.text,
    required this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ModalColors.gradientStart, ModalColors.gradientEnd],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _OutlineSmallButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const _OutlineSmallButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        side: const BorderSide(color: ModalColors.textGrey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: ModalColors.textGrey,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _GradientSmallButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool fullWidth;

  const _GradientSmallButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      height: 45,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ModalColors.gradientStart, ModalColors.gradientEnd],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        icon: Icon(icon, color: Colors.white, size: 18),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
