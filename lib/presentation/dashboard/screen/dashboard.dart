import 'package:ecommerce/core/router/app_name.dart';
import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/core/theme/app_spacing.dart';
import 'package:ecommerce/presentation/dashboard/widget/my_balance_card.dart';
import 'package:ecommerce/presentation/dashboard/widget/my_budget_progress.dart';
import 'package:ecommerce/presentation/dashboard/widget/my_recent_transaction.dart';
import 'package:ecommerce/presentation/dashboard/widget/my_stat_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const double _headerHeight = 180;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        elevation: 18,
        backgroundColor: AppColors.card,

        indicatorColor: AppColors.transp,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            );
          }

          return TextStyle(color: AppColors.textSecondary, fontSize: 12);
        }),
        selectedIndex: selectedValue,
        onDestinationSelected: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: AppColors.primary),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.receipt, color: AppColors.primary),
            label: "Transaction",
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart, color: AppColors.primary),
            label: "Report",
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(
              Icons.account_balance_wallet,
              color: AppColors.primary,
            ),
            label: "Wallet",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person, color: AppColors.primary),
            label: "Profile",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          context.push(AppName.addTransactionName);
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _notificationSection(context),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 110),
                    child: Column(
                      children: [
                        MyBalanceCard(),
                        const SizedBox(height: AppSpacing.md),
                        statCard(),
                        const SizedBox(height: AppSpacing.md),
                        MyBudgetProgress(),
                        const SizedBox(height: AppSpacing.md),
                        MyRecentTransaction(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row statCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyStatCard(
          label: "Income",
          amount: "\$ 12,000.00",
          color: AppColors.success,
          icon: Icons.account_balance,
        ),
        MyStatCard(
          label: "Expense",
          amount: "\$ 12,000.00",
          color: AppColors.danger,
          icon: Icons.wallet_outlined,
        ),
        MyStatCard(
          label: "Income",
          amount: "\$ 12,000.00",
          color: AppColors.textPrimary,
          icon: Icons.savings_outlined,
        ),
      ],
    );
  }

  Padding _notificationSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, 👋",
                style: TextStyle(
                  fontSize: AppSpacing.msm,
                  color: AppColors.card,
                ),
              ),
              Text(
                "Biplov Khanal",
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppColors.card),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              // Even handle
            },
            icon: Icon(
              Icons.notifications_none,
              color: AppColors.card,
              size: AppSpacing.llg,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Column _buildBackground() {
    return Column(
      children: [
        const SizedBox(height: Dashboard._headerHeight),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(160, 50),
                topRight: Radius.elliptical(160, 50),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
