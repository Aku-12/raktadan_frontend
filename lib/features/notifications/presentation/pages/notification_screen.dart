import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  // ── Palette (matches profile screen) ──
  static const Color _brandRed    = Color(0xFFDC2626);
  static const Color _darkText    = Color(0xFF1A1D2E);
  static const Color _mutedText   = Color(0xFF6B7280);
  static const Color _lightGray   = Color(0xFFF5F5F7);
  static const Color _borderColor = Color(0xFFEEEEF0);
  static const Color _green       = Color(0xFF22C55E);
  static const Color _amber       = Color(0xFFF59E0B);
  static const Color _violet      = Color(0xFF8B5CF6);
  static const Color _blue        = Color(0xFF3B82F6);

  late TabController _tabController;

  final List<_BloodNotification> _notifications = [
    _BloodNotification(
      category: _NotifCategory.urgent,
      title: "Urgent: B+ Blood Needed",
      body: "Bir Hospital urgently needs 2 units of B+ blood. You're a match! Can you donate today?",
      time: "5 min ago",
      isUnread: true,
      actionLabel: "Respond",
    ),
    _BloodNotification(
      category: _NotifCategory.donation,
      title: "Donation Reminder",
      body: "You're eligible to donate again! It's been 90 days since your last donation on Feb 12.",
      time: "30 min ago",
      isUnread: true,
      actionLabel: "Schedule",
    ),
    _BloodNotification(
      category: _NotifCategory.achievement,
      title: "Milestone Unlocked! 🎉",
      body: "Congratulations! You've completed 12 donations and earned the Gold Donor badge.",
      time: "2 hrs ago",
      isUnread: true,
      actionLabel: "View",
    ),
    _BloodNotification(
      category: _NotifCategory.camp,
      title: "Blood Camp Near You",
      body: "Nepal Red Cross Society is organizing a camp at Kathmandu Durbar Square this Saturday.",
      time: "4 hrs ago",
      isUnread: false,
      actionLabel: "Details",
    ),
    _BloodNotification(
      category: _NotifCategory.donation,
      title: "Thank You for Donating!",
      body: "Your donation on May 8 has been processed. Your blood helped save 3 lives.",
      time: "1 day ago",
      isUnread: false,
      actionLabel: "Certificate",
    ),
    _BloodNotification(
      category: _NotifCategory.urgent,
      title: "Emergency: O- Required",
      body: "Teaching Hospital needs O- blood for a critical surgery. Any O- donors nearby?",
      time: "1 day ago",
      isUnread: false,
      actionLabel: "Respond",
    ),
    _BloodNotification(
      category: _NotifCategory.camp,
      title: "Camp Results Available",
      body: "Your health screening results from the Lalitpur Blood Camp are ready to view.",
      time: "2 days ago",
      isUnread: false,
      actionLabel: "View",
    ),
    _BloodNotification(
      category: _NotifCategory.achievement,
      title: "You Inspired a Donor!",
      body: "Someone you referred just completed their first donation. +25 bonus points!",
      time: "3 days ago",
      isUnread: false,
      actionLabel: "Share",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<_BloodNotification> _filteredList(int tabIndex) {
    if (tabIndex == 0) return _notifications;
    final category = [
      _NotifCategory.urgent,
      _NotifCategory.urgent,
      _NotifCategory.donation,
      _NotifCategory.camp,
    ][tabIndex];
    if (tabIndex == 1) {
      return _notifications
          .where((n) => n.category == _NotifCategory.urgent)
          .toList();
    }
    if (tabIndex == 2) {
      return _notifications
          .where((n) =>
              n.category == _NotifCategory.donation ||
              n.category == _NotifCategory.achievement)
          .toList();
    }
    return _notifications.where((n) => n.category == category).toList();
  }

  int get _unreadCount => _notifications.where((n) => n.isUnread).length;

  void _markAllRead() {
    setState(() {
      for (var n in _notifications) {
        n.isUnread = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 6),
            _buildSummaryStrip(),
            const SizedBox(height: 16),
            _buildFilterChips(),
            const SizedBox(height: 10),
            Expanded(
              child: AnimatedBuilder(
                animation: _tabController,
                builder: (context, _) {
                  final items = _filteredList(_tabController.index);
                  return _buildList(items);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  HEADER — stacked left-aligned, no circular buttons
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back icon
          GestureDetector(
            onTap: () {
              if (Navigator.canPop(context)) Navigator.pop(context);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _lightGray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_rounded, size: 20, color: _darkText),
            ),
          ),
          const SizedBox(width: 14),
          // Title
          const Expanded(
            child: Text(
              "Notifications",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: _darkText,
                letterSpacing: -0.5,
              ),
            ),
          ),
          // Unread badge
          if (_unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "$_unreadCount new",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _brandRed,
                ),
              ),
            ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _markAllRead,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _lightGray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.done_all_rounded, size: 20, color: _darkText),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  SUMMARY STRIP — horizontal stats
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSummaryStrip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _brandRed.withValues(alpha: 0.06),
              _brandRed.withValues(alpha: 0.02),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _brandRed.withValues(alpha: 0.1), width: 1),
        ),
        child: Row(
          children: [
            _summaryItem(Icons.water_drop_rounded, "2", "Urgent", _brandRed),
            _summaryDot(),
            _summaryItem(Icons.event_rounded, "1", "Camp", _blue),
            _summaryDot(),
            _summaryItem(Icons.volunteer_activism_rounded, "3", "Donations", _green),
            _summaryDot(),
            _summaryItem(Icons.emoji_events_rounded, "2", "Rewards", _amber),
          ],
        ),
      ),
    );
  }

  Widget _summaryItem(IconData icon, String count, String label, Color color) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: _mutedText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryDot() {
    return Container(
      width: 3,
      height: 3,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: _borderColor,
        shape: BoxShape.circle,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  FILTER CHIPS — pill style
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildFilterChips() {
    final labels = ["All", "Urgent", "Donations", "Camps"];
    final icons = [
      Icons.all_inbox_rounded,
      Icons.priority_high_rounded,
      Icons.volunteer_activism_rounded,
      Icons.location_on_outlined,
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isActive = _tabController.index == i;
          return GestureDetector(
            onTap: () => setState(() => _tabController.index = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isActive ? _brandRed : Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isActive ? _brandRed : _borderColor,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    icons[i],
                    size: 16,
                    color: isActive ? Colors.white : _mutedText,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    labels[i],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.white : _mutedText,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  NOTIFICATION LIST — card-based with left accent stripe
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildList(List<_BloodNotification> items) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _lightGray,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.notifications_off_outlined, size: 36, color: _mutedText),
            ),
            const SizedBox(height: 16),
            const Text(
              "No notifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: _darkText),
            ),
            const SizedBox(height: 6),
            const Text(
              "You're all caught up!",
              style: TextStyle(fontSize: 14, color: _mutedText),
            ),
          ],
        ),
      );
    }

    // Group: Today / Earlier
    final today = items.where((n) => _isRecent(n.time)).toList();
    final earlier = items.where((n) => !_isRecent(n.time)).toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      children: [
        if (today.isNotEmpty) ...[
          _groupLabel("Today"),
          const SizedBox(height: 10),
          ...today.map(_buildNotifCard),
        ],
        if (earlier.isNotEmpty) ...[
          const SizedBox(height: 18),
          _groupLabel("Earlier"),
          const SizedBox(height: 10),
          ...earlier.map(_buildNotifCard),
        ],
        const SizedBox(height: 30),
      ],
    );
  }

  bool _isRecent(String time) =>
      time.contains("min") || time.contains("hr");

  Widget _groupLabel(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: _mutedText,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Divider(color: _borderColor, height: 1)),
      ],
    );
  }

  // ── Individual notification card with colored left accent bar ──
  Widget _buildNotifCard(_BloodNotification item) {
    final meta = _categoryMeta(item.category);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: ValueKey(item.hashCode),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(Icons.delete_outline_rounded, color: _brandRed, size: 22),
        ),
        onDismissed: (_) {
          setState(() => _notifications.remove(item));
        },
        child: Container(
          decoration: BoxDecoration(
            color: item.isUnread ? Colors.white : _lightGray,
            borderRadius: BorderRadius.circular(18),
            border: item.isUnread
                ? Border.all(color: meta.color.withValues(alpha: 0.2), width: 1.5)
                : null,
            boxShadow: item.isUnread
                ? [
                    BoxShadow(
                      color: meta.color.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Left accent bar
                Container(
                  width: 4,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: meta.color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 14, 16, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top row: icon + title + dot
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: meta.bg,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(meta.icon, size: 18, color: meta.color),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: item.isUnread ? FontWeight.w700 : FontWeight.w600,
                                  color: _darkText,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                            if (item.isUnread)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: meta.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Body text
                        Text(
                          item.body,
                          style: const TextStyle(
                            fontSize: 13.5,
                            color: _mutedText,
                            height: 1.45,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        // Bottom row: time + action chip
                        Row(
                          children: [
                            Icon(Icons.schedule_rounded, size: 13, color: _mutedText.withValues(alpha: 0.5)),
                            const SizedBox(width: 4),
                            Text(
                              item.time,
                              style: TextStyle(
                                fontSize: 12,
                                color: _mutedText.withValues(alpha: 0.6),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            // Action chip
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: meta.bg,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                item.actionLabel,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: meta.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _CategoryMeta _categoryMeta(_NotifCategory cat) {
    switch (cat) {
      case _NotifCategory.urgent:
        return _CategoryMeta(
          icon: Icons.water_drop_rounded,
          color: _brandRed,
          bg: const Color(0xFFFEF2F2),
        );
      case _NotifCategory.donation:
        return _CategoryMeta(
          icon: Icons.volunteer_activism_rounded,
          color: _green,
          bg: const Color(0xFFF0FDF4),
        );
      case _NotifCategory.camp:
        return _CategoryMeta(
          icon: Icons.location_on_rounded,
          color: _blue,
          bg: const Color(0xFFEFF6FF),
        );
      case _NotifCategory.achievement:
        return _CategoryMeta(
          icon: Icons.emoji_events_rounded,
          color: _amber,
          bg: const Color(0xFFFFFBEB),
        );
    }
  }
}

// ─── Data Models ──────────────────────────────────────────────────────────────

enum _NotifCategory { urgent, donation, camp, achievement }

class _CategoryMeta {
  final IconData icon;
  final Color color;
  final Color bg;
  const _CategoryMeta({required this.icon, required this.color, required this.bg});
}

class _BloodNotification {
  final _NotifCategory category;
  final String title;
  final String body;
  final String time;
  final String actionLabel;
  bool isUnread;

  _BloodNotification({
    required this.category,
    required this.title,
    required this.body,
    required this.time,
    required this.actionLabel,
    required this.isUnread,
  });
}
