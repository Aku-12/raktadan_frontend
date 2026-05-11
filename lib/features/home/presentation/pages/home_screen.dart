import 'package:flutter/material.dart';
import 'donor_scanner_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color _brandRed = Color(0xFFDC2626);
  static const Color _darkText = Color(0xFF1A1D2E);
  static const Color _mutedText = Color(0xFF6B7280);
  static const Color _lightGray = Color(0xFFF5F5F7);
  static const Color _borderColor = Color(0xFFEEEEF0);
  static const Color _green = Color(0xFF22C55E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),
            const SizedBox(height: 10),
            _buildQuickStats(),
            const SizedBox(height: 32),
            _buildSectionHeader("Live Blood Requests", "See Map"),
            const SizedBox(height: 16),
            _buildLiveRequests(),
            const SizedBox(height: 32),
            _buildSectionHeader("Upcoming Blood Drives", "View All"),
            const SizedBox(height: 16),
            _buildBloodDrives(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DonorScannerScreen()),
          );
        },
        backgroundColor: _brandRed,
        elevation: 4,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          "Request Blood",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  HERO SECTION (Curved with Gradient)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeroSection(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, topPad + 16, 24, 60),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEF4444), Color(0xFFB91C1C)], // Lighter to darker red
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
                    ),
                    child: const Center(
                      child: Text(
                        "SS",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, Saugat 👋",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        "Ready to save lives?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.notifications_outlined, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Call to Action Card inside Hero
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "ELIGIBLE",
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "You can donate\nblood today.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: _brandRed,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  child: const Text(
                    "Schedule",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  QUICK STATS (Overlapping the hero)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildQuickStats() {
    return Transform.translate(
      offset: const Offset(0, -40),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              _statItem(Icons.water_drop_rounded, "B+", "Blood Type", const Color(0xFFDC2626)),
              _verticalDivider(),
              _statItem(Icons.favorite_rounded, "3", "Lives Saved", const Color(0xFF22C55E)),
              _verticalDivider(),
              _statItem(Icons.volunteer_activism_rounded, "1", "Donation", const Color(0xFF3B82F6)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statItem(IconData icon, String value, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color.withOpacity(0.8), size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: _darkText,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: _mutedText,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 40,
      color: _lightGray,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  SECTION HEADER
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSectionHeader(String title, String actionText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: _darkText,
              letterSpacing: -0.3,
            ),
          ),
          Text(
            actionText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _brandRed,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  LIVE BLOOD REQUESTS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildLiveRequests() {
    final requests = [
      {"type": "A-", "hospital": "Patan Hospital", "units": "2 Units", "time": "15 min ago", "urgent": true},
      {"type": "O+", "hospital": "Teaching Hosp.", "units": "1 Unit", "time": "1 hr ago", "urgent": false},
      {"type": "AB+", "hospital": "Mediciti Hosp.", "units": "3 Units", "time": "2 hrs ago", "urgent": true},
    ];

    return SizedBox(
      height: 180,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: requests.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final req = requests[index];
          final isUrgent = req["urgent"] as bool;

          return Container(
            width: 220,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isUrgent ? const Color(0xFFFEF2F2) : _lightGray,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isUrgent ? _brandRed.withOpacity(0.3) : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isUrgent ? _brandRed : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          req["type"] as String,
                          style: TextStyle(
                            color: isUrgent ? Colors.white : _darkText,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    if (isUrgent)
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: _brandRed,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            "Live",
                            style: TextStyle(color: _brandRed, fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                  ],
                ),
                const Spacer(),
                Text(
                  req["hospital"] as String,
                  style: const TextStyle(
                    color: _darkText,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.water_drop_outlined, size: 14, color: _mutedText.withOpacity(0.8)),
                    const SizedBox(width: 4),
                    Text(
                      req["units"] as String,
                      style: TextStyle(color: _mutedText, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.access_time, size: 14, color: _mutedText.withOpacity(0.8)),
                    const SizedBox(width: 4),
                    Text(
                      req["time"] as String,
                      style: TextStyle(color: _mutedText, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isUrgent ? _brandRed : Colors.white,
                      foregroundColor: isUrgent ? Colors.white : _darkText,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: isUrgent ? Colors.transparent : Colors.black12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      isUrgent ? "Donate Now" : "View Details",
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  UPCOMING BLOOD DRIVES
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBloodDrives() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _driveCard(
            title: "Lions Club Mega Drive",
            location: "Jawalakhel Ground",
            date: "May 25",
            time: "10:00 AM",
            attendees: 142,
          ),
          const SizedBox(height: 16),
          _driveCard(
            title: "Red Cross Campaign",
            location: "Kathmandu Durbar Square",
            date: "May 28",
            time: "09:00 AM",
            attendees: 89,
          ),
        ],
      ),
    );
  }

  Widget _driveCard({
    required String title,
    required String location,
    required String date,
    required String time,
    required int attendees,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Date Box
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: _lightGray,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.split(" ")[0],
                  style: const TextStyle(color: _mutedText, fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Text(
                  date.split(" ")[1],
                  style: const TextStyle(color: _brandRed, fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _darkText,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: _mutedText),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(color: _mutedText, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.people_outline_rounded, size: 14, color: _mutedText),
                    const SizedBox(width: 4),
                    Text(
                      "$attendees going",
                      style: const TextStyle(color: _mutedText, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Action
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: _borderColor),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_forward_rounded, size: 20, color: _darkText),
          ),
        ],
      ),
    );
  }
}
