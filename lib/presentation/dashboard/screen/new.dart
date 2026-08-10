import 'package:flutter/material.dart';
import 'package:ecommerce/core/theme/app_colors.dart';

/// ─────────────────────────────────────────────────────────────────────────
/// DASHBOARD SCREEN
///
/// KEY LAYOUT IDEA:
/// Everything lives inside ONE Stack. The Stack has exactly two children:
///   1. The background (green top + white curved sheet)
///   2. The real UI content (SafeArea > Column), painted ON TOP of #1
///
/// Because both are children of the SAME Stack, the second one visually
/// overlaps the first wherever they occupy the same screen coordinates.
/// This is what lets the balance card straddle the green/white seam.
/// ─────────────────────────────────────────────────────────────────────────
class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  // Roughly how tall the green header area is before the white sheet begins.
  // Tweak this to match your design's curve position.
  static const double _headerHeight = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      // extendBody lets the scroll content flow behind a translucent/notched
      // bottom bar instead of stopping abruptly above it.
      extendBody: true,
      body: Stack(
        children: [
          // ── LAYER 1: BACKGROUND ────────────────────────────────────────
          _buildBackground(),

          // ── LAYER 2: REAL CONTENT (painted on top of Layer 1) ─────────
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  // SingleChildScrollView, not a plain Column, because the
                  // list of cards + transactions can exceed screen height.
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Negative translate pulls this card UP so it visually
                        // overlaps the header/curve seam, without affecting
                        // where it sits in the scroll flow.
                        Transform.translate(
                          offset: const Offset(0, -30),
                          child: _buildBalanceCard(),
                        ),
                        const SizedBox(height: 8),
                        _buildStatsRow(),
                        const SizedBox(height: 24),
                        _buildBudgetProgress(),
                        const SizedBox(height: 24),
                        _buildTransactionsHeader(),
                        const SizedBox(height: 12),
                        _buildTransactionTile(
                          icon: Icons.lunch_dining,
                          iconBg: const Color(0xFFFFE8D6),
                          title: 'Lunch',
                          subtitle: 'Today, 12:30 PM',
                          amount: '-\$15.00',
                          isNegative: true,
                        ),
                        _buildTransactionTile(
                          icon: Icons.account_balance_wallet,
                          iconBg: const Color(0xFFDDF3E4),
                          title: 'Salary',
                          subtitle: 'Aug 20, 09:00 AM',
                          amount: '+\$1,200.00',
                          isNegative: false,
                        ),
                        _buildTransactionTile(
                          icon: Icons.local_taxi,
                          iconBg: const Color(0xFFFFF3CD),
                          title: 'Taxi',
                          subtitle: 'Aug 19, 06:30 PM',
                          amount: '-\$12.00',
                          isNegative: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      // Docks the FAB into the notch of the BottomAppBar, centered.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── BACKGROUND: green rectangle + white curved sheet ─────────────────────
  Widget _buildBackground() {
    return Column(
      children: [
        const SizedBox(height: _headerHeight),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(160, 60),
                topRight: Radius.elliptical(160, 60),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── HEADER: greeting + notification bell ──────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, 👋',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                'Biplov Khanal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // ── BALANCE CARD (the one that overlaps the seam) ─────────────────────
  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Current Balance', style: TextStyle(color: Colors.grey)),
              Icon(Icons.remove_red_eye_outlined, color: Colors.grey, size: 20),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            '\$12,540.00',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.arrow_upward, color: Colors.green.shade600, size: 16),
              const SizedBox(width: 4),
              Text(
                '+12.5% than last month',
                style: TextStyle(color: Colors.green.shade600, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── INCOME / EXPENSE / SAVINGS ROW ────────────────────────────────────
  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: Icons.arrow_downward,
            iconColor: Colors.green,
            iconBg: const Color(0xFFDDF3E4),
            label: 'Income',
            amount: '\$15,200.00',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.arrow_upward,
            iconColor: Colors.red,
            iconBg: const Color(0xFFFBDCDC),
            label: 'Expense',
            amount: '\$2,660.00',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.account_balance,
            iconColor: Colors.blue,
            iconBg: const Color(0xFFDCE9FB),
            label: 'Savings',
            amount: '\$12,540.00',
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String amount,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 2),
          Text(
            amount,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ── BUDGET PROGRESS ────────────────────────────────────────────────────
  Widget _buildBudgetProgress() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Budget Progress', style: TextStyle(fontWeight: FontWeight.w600)),
              Text('August 2024', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '80%',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(
            'of \$5,000',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.8,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('\$4,000 used', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('\$1,000 left', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  // ── RECENT TRANSACTIONS ────────────────────────────────────────────────
  Widget _buildTransactionsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Recent Transactions', style: TextStyle(fontWeight: FontWeight.w600)),
        Text('See All', style: TextStyle(color: AppColors.primary, fontSize: 12)),
      ],
    );
  }

  Widget _buildTransactionTile({
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
    required String amount,
    required bool isNegative,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, size: 18, color: Colors.black87),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isNegative ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  // ── BOTTOM NAV BAR WITH FAB NOTCH ──────────────────────────────────────
  Widget _buildBottomNav() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navIcon(Icons.home, 'Home', active: true),
          _navIcon(Icons.swap_horiz, 'Transactions'),
          const SizedBox(width: 40), // gap for the notched FAB
          _navIcon(Icons.insert_chart_outlined, 'Reports'),
          _navIcon(Icons.person_outline, 'Profile'),
        ],
      ),
    );
  }

  Widget _navIcon(IconData icon, String label, {bool active = false}) {
    final color = active ? AppColors.primary : Colors.grey;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(color: color, fontSize: 10)),
      ],
    );
  }
}