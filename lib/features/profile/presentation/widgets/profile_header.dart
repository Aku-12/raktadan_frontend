import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  static const Color _brand      = Color(0xFFDC2626);
  static const Color _brandLight = Color(0xFFFEE2E2);
  static const Color _textDark   = Color(0xFF111827);
  static const Color _textMuted  = Color(0xFF6B7280);
  static const Color _green      = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        // Avatar with brand ring
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer ring
            Container(
              width: 112,
              height: 112,
              decoration: const BoxDecoration(
                color: _brand,
                shape: BoxShape.circle,
              ),
            ),
            // White spacer
            Container(
              width: 104,
              height: 104,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            // Inner avatar
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: _brandLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 48,
                color: _brand,
              ),
            ),
            // Camera button
            Positioned(
              right: 2,
              bottom: 2,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.camera_alt_rounded, size: 16, color: _textDark),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          "Saugat Shahi",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: _textDark,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "saugat.shahi@gmail.com",
          style: TextStyle(
            fontSize: 15,
            color: _textMuted,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 14),
        // Blood type + Verified badge row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Blood type badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFECACA), width: 1),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bloodtype_rounded, size: 15, color: _brand),
                  SizedBox(width: 5),
                  Text(
                    "B+",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: _brand,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Verified donor badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFDCFCE7), width: 1),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified_rounded, size: 15, color: _green),
                  SizedBox(width: 5),
                  Text(
                    "VERIFIED DONOR",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: _green,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
