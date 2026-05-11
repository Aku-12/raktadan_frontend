import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const Color _brandRed    = Color(0xFFDC2626);
  static const Color _darkText    = Color(0xFF1A1D2E);
  static const Color _mutedText   = Color(0xFF6B7280);
  static const Color _lightGray   = Color(0xFFF5F5F7);
  static const Color _borderColor = Color(0xFFEEEEF0);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 48),
              _buildLoginForm(),
              const SizedBox(height: 32),
              _buildLoginButton(),
              const SizedBox(height: 24),
              _buildDivider(),
              const SizedBox(height: 24),
              _buildSocialLogin(),
              const SizedBox(height: 40),
              _buildSignUpPrompt(),
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
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2), // Light red bg
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _brandRed.withOpacity(0.2)),
          ),
          child: const Center(
            child: Icon(Icons.water_drop_rounded, color: _brandRed, size: 32),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "Welcome back",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: _darkText,
            letterSpacing: -1,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Log in to continue your journey of saving lives.",
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
  //  LOGIN FORM
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          hint: "Enter your password",
          isPassword: true,
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {},
            child: const Text(
              "Forgot Password?",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _brandRed,
              ),
            ),
          ),
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
        obscureText: isPassword && _obscurePassword,
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
                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: _mutedText,
                    size: 20,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
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
  Widget _buildLoginButton() {
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
          "Log In",
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

  Widget _buildSocialLogin() {
    return Row(
      children: [
        Expanded(
          child: _socialButton(
            icon: Icons.g_mobiledata_rounded, // Placeholder for Google icon
            label: "Google",
            onTap: () {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _socialButton(
            icon: Icons.facebook_rounded, // Placeholder for Facebook icon
            label: "Facebook",
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

  Widget _buildSignUpPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _mutedText,
          ),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () {},
          child: const Text(
            "Sign Up",
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
