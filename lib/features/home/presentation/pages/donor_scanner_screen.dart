import 'package:flutter/material.dart';
import 'dart:math' as math;

class DonorScannerScreen extends StatefulWidget {
  const DonorScannerScreen({super.key});

  @override
  State<DonorScannerScreen> createState() => _DonorScannerScreenState();
}

class _DonorScannerScreenState extends State<DonorScannerScreen> with SingleTickerProviderStateMixin {
  bool _isScanning = true;
  late AnimationController _radarController;

  final List<Map<String, dynamic>> _mockDonors = [
    {
      "name": "Bikash Shrestha",
      "bloodGroup": "B+",
      "distance": "1.2 km",
      "location": "Patan Dhoka, Lalitpur",
      "status": "Available Now",
    },
    {
      "name": "Anita Magar",
      "bloodGroup": "B+",
      "distance": "2.8 km",
      "location": "Gwarko, Lalitpur",
      "status": "Available in 1 hr",
    },
    {
      "name": "Sabin Maharjan",
      "bloodGroup": "O-",
      "distance": "4.1 km",
      "location": "Satdobato, Lalitpur",
      "status": "Available Now",
    },
    {
      "name": "Priya Gurung",
      "bloodGroup": "B+",
      "distance": "5.5 km",
      "location": "Balkumari, Lalitpur",
      "status": "Available Now",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Radar rotation controller
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6), // Much slower loop duration
    )..repeat();

    // Simulate network delay
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
          _radarController.stop();
        });
      }
    });
  }

  @override
  void dispose() {
    _radarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dark aesthetic for the scanner vibe
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          _isScanning ? "Locating Donors..." : "Donors Found",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: _isScanning ? _buildScanner() : _buildDonorsList(),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  SCANNER ANIMATION (ShareIt Style Ripples)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildRipple(double animationValue, double delay) {
    // Calculate the current progress of this specific ripple (0.0 to 1.0)
    double value = (animationValue + delay) % 1.0;
    
    return Opacity(
      opacity: 1.0 - value, // Fade out as it expands
      child: Transform.scale(
        scale: 1.0 + (value * 3.5), // Expand outward
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFDC2626).withOpacity(0.2),
            border: Border.all(color: const Color(0xFFDC2626).withOpacity(0.8), width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingDonor(String emoji, double left, double top, double startPhase) {
    return Positioned(
      left: left,
      top: top,
      child: AnimatedBuilder(
        animation: _radarController,
        builder: (context, child) {
          double val = _radarController.value;
          // Calculate distance from startPhase (with wrap around)
          double dist = (val - startPhase) % 1.0;
          if (dist < 0) dist += 1.0;
          
          // Each object is visible for a quarter of the full cycle (0.25)
          double visibility = 0.0;
          if (dist < 0.25) {
             double localP = dist / 0.25; // Normalizes local progress from 0.0 to 1.0
             visibility = math.sin(localP * math.pi); // smooth 0 -> 1 -> 0 curve
          }
          
          if (visibility <= 0.01) return const SizedBox.shrink();

          return Transform.scale(
            scale: visibility,
            child: Opacity(
              opacity: visibility,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFDC2626).withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScanner() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ripple Display
          SizedBox(
            width: 320,
            height: 320,
            child: AnimatedBuilder(
              animation: _radarController,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Expanding Ripples
                    _buildRipple(_radarController.value, 0.0),
                    _buildRipple(_radarController.value, 0.33),
                    _buildRipple(_radarController.value, 0.66),
                    
                    // Mock found donors floating in the ripple (Fruits/Veg as requested)
                    _buildFloatingDonor("🍎", 230, 60, 0.0),   // Top Right
                    _buildFloatingDonor("🥦", 40, 70, 0.25),    // Top Left
                    _buildFloatingDonor("🥕", 60, 220, 0.5),    // Bottom Left
                    _buildFloatingDonor("🍓", 220, 230, 0.75),  // Bottom Right

                    // Center Avatar / Emitter
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFDC2626).withOpacity(0.6),
                            blurRadius: 30,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "SS",
                          style: TextStyle(
                            color: Color(0xFFDC2626),
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 50),
          const Text(
            "Searching Donors...",
            style: TextStyle(
              color: Color(0xFFDC2626),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Broadcasting request to nearby heroes",
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  DONORS LIST RESULTS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDonorsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded, color: Color(0xFF22C55E), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                "4 Nearby Donors Found",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            itemCount: _mockDonors.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final donor = _mockDonors[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
                ),
                child: Row(
                  children: [
                    // Blood Group Badge
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          donor["bloodGroup"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Donor Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            donor["name"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, size: 14, color: Colors.white.withOpacity(0.5)),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${donor['distance']} • ${donor['location']}",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF22C55E),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                donor["status"],
                                style: const TextStyle(
                                  color: Color(0xFF22C55E),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Action Button
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.send_rounded, color: Color(0xFFDC2626), size: 20),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
