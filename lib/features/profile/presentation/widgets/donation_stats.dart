import 'package:flutter/material.dart';

class DonationStats extends StatelessWidget {
  const DonationStats({super.key});

  static const Color _textDark  = Color(0xFF111827);
  static const Color _textMuted = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFF3F4F6), width: 1.5),
        ),
        child: Row(
          children: [
            _buildStatItem("12", "Total\nDonations", const Color(0xFFDC2626)),
            const _VerticalDivider(),
            _buildStatItem("3", "Lives\nSaved", const Color(0xFF10B981)),
            const _VerticalDivider(),
            _buildStatItem("B+", "Blood\nType", const Color(0xFF8B5CF6)),
            const _VerticalDivider(),
            _buildStatItem("48", "Donor\nPoints", const Color(0xFFFF8000)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: _textMuted,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      color: const Color(0xFFE5E7EB),
    );
  }
}
