import 'package:fintracker/core/router/app_name.dart';
import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/presentation/dashboard/screen/dashboard.dart';
import 'package:fintracker/presentation/transaction/screen/transaction.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final screen = [
    Dashboard(),
    Transaction(),
    // Report(),
    // Wallet(),
    // profile()
  ];

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
      body: IndexedStack(
        index: selectedValue,
        children: screen,
      )
    );
  }
}
