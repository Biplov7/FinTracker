import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_spacing.dart';
import 'package:fintracker/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintracker/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:fintracker/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:fintracker/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:fintracker/presentation/dashboard/widget/my_balance_card.dart';
import 'package:fintracker/presentation/dashboard/widget/my_budget_progress.dart';
import 'package:fintracker/presentation/dashboard/widget/my_recent_transaction.dart';
import 'package:fintracker/presentation/dashboard/widget/my_stat_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const double _headerHeight = 180;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with RouteAware {
  int selectedValue = 0;

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(LoadDashboard());
  }

  @override
  void didPush() {
    super.didPush();
    // Refresh when pushed onto the navigator stack
    context.read<DashboardBloc>().add(RefreshDashboard());
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // Refresh when returning from another route
    context.read<DashboardBloc>().add(RefreshDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is DashboardLoaded) {
            return Stack(
              children: [
                _buildBackground(),
                SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      _notificationSection(context, state.userName),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(14, 0, 14, 110),
                          child: Column(
                            children: [
                              MyBalanceCard(
                                currentBalance: state.dashboard.currentBalance,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              statCard(
                                state.dashboard.totalIncome,
                                state.dashboard.totalExpenses,
                                state.dashboard.totalSaving,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              MyBudgetProgress(
                                budgetLimit: state.dashboard.budgetLimit,
                                budgetUsed: state.dashboard.budgetUsed,
                              ),
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
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Row statCard(double totalIncome, double totalExpense, double totalSaving) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyStatCard(
          label: "Income",
          amount: formatCurrency(totalIncome),
          color: AppColors.success,
          icon: Icons.account_balance,
        ),
        MyStatCard(
          label: "Expense",
          amount: formatCurrency(totalExpense),
          color: AppColors.danger,
          icon: Icons.wallet_outlined,
        ),
        MyStatCard(
          label: "Saving",
          amount: formatCurrency(totalSaving),
          color: AppColors.textPrimary,
          icon: Icons.savings_outlined,
        ),
      ],
    );
  }

  Padding _notificationSection(BuildContext context, String userName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, ",
                style: TextStyle(
                  fontSize: AppSpacing.msm,
                  color: AppColors.card,
                ),
              ),
              Text(
                userName,
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
