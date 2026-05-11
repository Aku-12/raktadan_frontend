import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color _brandRed    = Color(0xFFDC2626);
  static const Color _darkText    = Color(0xFF1A1D2E);
  static const Color _mutedText   = Color(0xFF6B7280);
  static const Color _lightGray   = Color(0xFFF5F5F7);
  static const Color _borderColor = Color(0xFFEEEEF0);
  static const Color _green       = Color(0xFF22C55E);

  final _nameController  = TextEditingController(text: "Saugat Shahi");
  final _emailController = TextEditingController(text: "dev.shahi.apps@gmail.com");
  final _phoneController = TextEditingController(text: "+977 9841234567");

  String _selectedBloodGroup = "B+";
  DateTime _selectedDOB = DateTime(2000, 6, 15);
  String _selectedDistrict = "Lalitpur";
  String _selectedMunicipality = "Lalitpur";
  String _selectedGender = "Male";
  int _currentStep = 0; // 0-based, 3 steps total
  bool _isDonor = true;

  final _bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
  final _districts = ["Kathmandu", "Lalitpur", "Bhaktapur", "Pokhara", "Chitwan"];
  final _municipalities = ["Lalitpur", "Godawari", "Mahalaxmi", "Konjyosom"];

  double get _progress => (_currentStep + 1) / 3;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildProgressBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                child: _currentStep == 0
                    ? _buildStep1()
                    : _currentStep == 1
                        ? _buildStep2()
                        : _buildStep3(),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // ── TOP BAR ─────────────────────────────────────────────────────────────
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        children: [
          if (_currentStep > 0)
            GestureDetector(
              onTap: () => setState(() => _currentStep--),
              child: Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: _lightGray,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back_rounded, size: 20, color: _darkText),
              ),
            )
          else
            const SizedBox(width: 40),
          const Expanded(
            child: Text(
              "Complete Profile",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: _darkText),
            ),
          ),
          Text(
            "${_currentStep + 1}/3",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _mutedText),
          ),
        ],
      ),
    );
  }

  // ── PROGRESS BAR ────────────────────────────────────────────────────────
  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Container(
        height: 5,
        decoration: BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
            widthFactor: _progress,
            child: Container(
              decoration: BoxDecoration(
                color: _brandRed,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  STEP 1 — Personal Info
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
          "Tell us more\nabout yourself",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: _darkText, height: 1.2, letterSpacing: -0.5),
        ),
        const SizedBox(height: 8),
        const Text(
          "This information helps us connect you with the right donors and hospitals.",
          style: TextStyle(fontSize: 14, color: _mutedText, height: 1.5),
        ),
        const SizedBox(height: 28),
        _fieldLabel("FULL NAME"),
        _buildTextField(Icons.person_outline_rounded, _nameController, "Enter your name"),
        const SizedBox(height: 20),
        _fieldLabel("EMAIL (OPTIONAL)"),
        _buildTextField(Icons.alternate_email_rounded, _emailController, "name@example.com"),
        const SizedBox(height: 20),
        _fieldLabel("PHONE NUMBER"),
        _buildTextField(Icons.phone_outlined, _phoneController, "+977 98XXXXXXXX"),
        const SizedBox(height: 20),
        _fieldLabel("GENDER"),
        const SizedBox(height: 8),
        Row(
          children: [
            _genderChip("Male", Icons.male_rounded),
            const SizedBox(width: 10),
            _genderChip("Female", Icons.female_rounded),
            const SizedBox(width: 10),
            _genderChip("Other", Icons.transgender_rounded),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  STEP 2 — Blood & Health
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
          "Your blood &\nhealth details",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: _darkText, height: 1.2, letterSpacing: -0.5),
        ),
        const SizedBox(height: 8),
        const Text(
          "Knowing your blood group helps us match you with those in need.",
          style: TextStyle(fontSize: 14, color: _mutedText, height: 1.5),
        ),
        const SizedBox(height: 28),
        _fieldLabel("BLOOD GROUP"),
        const SizedBox(height: 10),
        _buildBloodGroupGrid(),
        const SizedBox(height: 24),
        _fieldLabel("DATE OF BIRTH"),
        const SizedBox(height: 8),
        _buildDatePicker(),
        const SizedBox(height: 24),
        _fieldLabel("I WANT TO JOIN AS"),
        const SizedBox(height: 10),
        Row(
          children: [
            _roleCard("Donor", Icons.volunteer_activism_rounded, "Give blood,\nsave lives", true),
            const SizedBox(width: 12),
            _roleCard("Recipient", Icons.local_hospital_rounded, "Request blood\nwhen needed", false),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  STEP 3 — Location
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
          "Where are\nyou located?",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: _darkText, height: 1.2, letterSpacing: -0.5),
        ),
        const SizedBox(height: 8),
        const Text(
          "This helps us find nearby blood banks and donors for faster response.",
          style: TextStyle(fontSize: 14, color: _mutedText, height: 1.5),
        ),
        const SizedBox(height: 28),
        _fieldLabel("DISTRICT"),
        const SizedBox(height: 8),
        _buildDropdownField(Icons.location_city_rounded, _selectedDistrict, _districts, (v) => setState(() => _selectedDistrict = v!)),
        const SizedBox(height: 20),
        _fieldLabel("MUNICIPALITY"),
        const SizedBox(height: 8),
        _buildDropdownField(Icons.apartment_rounded, _selectedMunicipality, _municipalities, (v) => setState(() => _selectedMunicipality = v!)),
        const SizedBox(height: 32),
        // Summary card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _brandRed.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.check_circle_rounded, size: 20, color: _brandRed),
                  SizedBox(width: 8),
                  Text("Profile Summary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _darkText)),
                ],
              ),
              const SizedBox(height: 14),
              _summaryRow("Name", _nameController.text),
              _summaryRow("Blood", _selectedBloodGroup),
              _summaryRow("Role", _isDonor ? "Donor" : "Recipient"),
              _summaryRow("Location", "$_selectedMunicipality, $_selectedDistrict"),
            ],
          ),
        ),
      ],
    );
  }

  // ── BOTTOM NAV ──────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    final isLast = _currentStep == 2;
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _borderColor, width: 1)),
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _currentStep--),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    border: Border.all(color: _borderColor, width: 1.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text("Back", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: _mutedText)),
                  ),
                ),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            flex: _currentStep == 0 ? 1 : 1,
            child: GestureDetector(
              onTap: () {
                if (!isLast) setState(() => _currentStep++);
              },
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: _brandRed,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    isLast ? "Save Profile" : "Continue",
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  SHARED WIDGETS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _mutedText, letterSpacing: 1),
    );
  }

  Widget _buildTextField(IconData icon, TextEditingController controller, String hint) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _lightGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: _darkText),
        decoration: InputDecoration(
          icon: Icon(icon, size: 22, color: _mutedText),
          hintText: hint,
          hintStyle: TextStyle(color: _mutedText.withValues(alpha: 0.5)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _genderChip(String label, IconData icon) {
    final selected = _selectedGender == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedGender = label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: selected ? _brandRed : _lightGray,
            borderRadius: BorderRadius.circular(14),
            border: selected ? null : Border.all(color: _borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: selected ? Colors.white : _mutedText),
              const SizedBox(width: 6),
              Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: selected ? Colors.white : _darkText)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBloodGroupGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 2.2,
      ),
      itemCount: _bloodGroups.length,
      itemBuilder: (_, i) {
        final bg = _bloodGroups[i];
        final selected = bg == _selectedBloodGroup;
        return GestureDetector(
          onTap: () => setState(() => _selectedBloodGroup = bg),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: selected ? _brandRed : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: selected ? _brandRed : _borderColor, width: 1.5),
            ),
            child: Center(
              child: Text(bg, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: selected ? Colors.white : _darkText)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _selectedDOB,
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: _brandRed)),
              child: child!,
            );
          },
        );
        if (picked != null) setState(() => _selectedDOB = picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: _lightGray,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _brandRed.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.cake_rounded, size: 22, color: _brandRed),
            const SizedBox(width: 12),
            Text(
              "${_monthName(_selectedDOB.month)} ${_selectedDOB.day.toString().padLeft(2, '0')}, ${_selectedDOB.year}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: _darkText),
            ),
            const Spacer(),
            Icon(Icons.calendar_today_outlined, size: 20, color: _mutedText.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }

  Widget _roleCard(String title, IconData icon, String subtitle, bool isDonorRole) {
    final selected = _isDonor == isDonorRole;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _isDonor = isDonorRole),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFFEF2F2) : _lightGray,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: selected ? _brandRed : _borderColor, width: selected ? 1.5 : 1),
          ),
          child: Column(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: selected ? _brandRed.withValues(alpha: 0.1) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 24, color: selected ? _brandRed : _mutedText),
              ),
              const SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: selected ? _brandRed : _darkText)),
              const SizedBox(height: 4),
              Text(subtitle, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: selected ? _brandRed.withValues(alpha: 0.7) : _mutedText, height: 1.3)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(IconData icon, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: _lightGray, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Icon(icon, size: 22, color: _brandRed),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: _mutedText),
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: _darkText),
                items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: const TextStyle(fontSize: 13, color: _mutedText, fontWeight: FontWeight.w500))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _darkText))),
        ],
      ),
    );
  }

  String _monthName(int m) => const ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"][m - 1];
}
