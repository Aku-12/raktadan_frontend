import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static const Color _brandRed    = Color(0xFFDC2626);
  static const Color _darkText    = Color(0xFF1A1D2E);
  static const Color _mutedText   = Color(0xFF6B7280);
  static const Color _lightGray   = Color(0xFFF5F5F7);
  static const Color _borderColor = Color(0xFFEEEEF0);

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              GestureDetector(
                onTap: () {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _lightGray,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.arrow_back_rounded, color: _darkText, size: 20),
                ),
              ),
              const SizedBox(height: 24),
              _buildHeader(),
              const SizedBox(height: 36),
              _buildSignupForm(),
              const SizedBox(height: 32),
              _buildSignupButton(),
              const SizedBox(height: 24),
              _buildDivider(),
              const SizedBox(height: 24),
              _buildSocialSignup(),
              const SizedBox(height: 32),
              _buildLoginPrompt(),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  HEADER
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Create Account",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: _darkText,
            letterSpacing: -1,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Join the Rakta Sanchar community and become a hero today.",
          style: TextStyle(
            fontSize: 15,
            color: _mutedText,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  SIGNUP FORM
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSignupForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel("FULL NAME"),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _nameController,
          icon: Icons.person_outline_rounded,
          hint: "Enter your full name",
        ),
        const SizedBox(height: 20),
        
        _fieldLabel("EMAIL ADDRESS"),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _emailController,
          icon: Icons.alternate_email_rounded,
          hint: "name@example.com",
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        
        _fieldLabel("PASSWORD"),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _passwordController,
          icon: Icons.lock_outline_rounded,
          hint: "Create a password",
          isPassword: true,
          obscureState: _obscurePassword,
          onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        const SizedBox(height: 20),
        
        _fieldLabel("CONFIRM PASSWORD"),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _confirmPasswordController,
          icon: Icons.lock_reset_rounded,
          hint: "Repeat your password",
          isPassword: true,
          obscureState: _obscureConfirmPassword,
          onToggleObscure: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
        ),
      ],
    );
  }

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: _mutedText,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool isPassword = false,
    bool obscureState = false,
    VoidCallback? onToggleObscure,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _lightGray,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && obscureState,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: _darkText,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: _mutedText.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(icon, color: _mutedText, size: 22),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureState ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: _mutedText,
                    size: 20,
                  ),
                  onPressed: onToggleObscure,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  BUTTONS & SOCIALS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSignupButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: _brandRed,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: _borderColor, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "OR",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _mutedText.withOpacity(0.6),
            ),
          ),
        ),
        Expanded(child: Divider(color: _borderColor, thickness: 1)),
      ],
    );
  }

  Widget _buildSocialSignup() {
    return Row(
      children: [
        Expanded(
          child: _socialButton(
            icon: Icons.g_mobiledata_rounded,
            label: "Google",
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _socialButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _borderColor, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: _darkText),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _mutedText,
          ),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: const Text(
            "Log In",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: _brandRed,
            ),
          ),
        ),
      ],
    );
  }
}
