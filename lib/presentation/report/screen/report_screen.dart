import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_radius.dart';
import 'package:fintracker/domain/report/entities/report_peroid.dart';
import 'package:fintracker/presentation/report/bloc/report_bloc.dart';
import 'package:fintracker/presentation/report/bloc/report_event.dart';
import 'package:fintracker/presentation/report/widget/expense_overview.dart';
import 'package:fintracker/presentation/report/widget/income_overview.dart';
import 'package:fintracker/presentation/report/widget/income_vs_expense_overview.dart';
import 'package:fintracker/presentation/report/widget/report_period_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  ReportPeroid selectedType = ReportPeroid.monthly;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Reports", style: TextTheme.of(context).titleLarge),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.date_range_outlined)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReportPeriodButton(
                        period: ReportPeroid.daily,
                        selectedPeriod: selectedType,
                        onTap: () {
                          setState(() {
                            selectedType = ReportPeroid.daily;
                            context.read<ReportBloc>().add(
                              LoadReportEvent(selectedType),
                            );
                          });
                        },
                      ),
                      ReportPeriodButton(
                        period: ReportPeroid.monthly,
                        selectedPeriod: selectedType,
                        onTap: () {
                          setState(() {
                            selectedType = ReportPeroid.monthly;
                            context.read<ReportBloc>().add(
                              LoadReportEvent(selectedType),
                            );
                          });
                        },
                      ),
                      ReportPeriodButton(
                        period: ReportPeroid.yearly,
                        selectedPeriod: selectedType,
                        onTap: () {
                          setState(() {
                            selectedType = ReportPeroid.yearly;
                            context.read<ReportBloc>().add(
                              LoadReportEvent(selectedType),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              ExpenseOverview(),
              SizedBox(height: 20),
              IncomeOverview(),
              SizedBox(height: 20),
              IncomeVsExpenseOverview(),
            ],
          ),
        ),
      ),
    );
  }
}
