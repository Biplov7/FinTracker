import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_radius.dart';
import 'package:fintracker/core/utils/currency_formatter.dart';
import 'package:fintracker/domain/add_transaction/entities/income_category.dart';
import 'package:fintracker/presentation/report/bloc/report_bloc.dart';
import 'package:fintracker/presentation/report/bloc/report_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeOverview extends StatefulWidget {
  const IncomeOverview({super.key});

  @override
  State<IncomeOverview> createState() => IncomeOverviewState();
}

class IncomeOverviewState extends State<IncomeOverview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        color: AppColors.card,
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: AppRadius.medium,
          vertical: AppRadius.medium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Income Overview",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 0.7,
              ),
            ),

            BlocBuilder<ReportBloc, ReportState>(
              builder: (context, state) {
                if (state is ReportLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is ReportLoaded) {
                  if (state.entities.totalIncome == 0 &&
                      state.entities.totalExpense == 0) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 50,
                      ),
                      child: Center(child: Text("No Transaction has done yet")),
                    );
                  }
                  final entity = state.entities;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              // Total Expense
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formatCurrency(entity.totalExpense),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    "Total Expense",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black.withValues(
                                            alpha: 0.6,
                                          ),
                                        ),
                                  ),
                                ],
                              ),

                              SizedBox(width: AppRadius.large),

                              VerticalDivider(
                                color: AppColors.textPrimary,
                                thickness: 1,
                                width: 20,
                              ),

                              SizedBox(width: AppRadius.large),

                              // Total Income
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formatCurrency(entity.totalIncome),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    "Total Income",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black.withValues(
                                            alpha: 0.6,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 160,
                                  child: PieChart(
                                    PieChartData(
                                      centerSpaceRadius: 55,
                                      sectionsSpace: 2,
                                      sections: entity.incomeByCategory.entries.map((
                                        entry,
                                      ) {
                                        final index = entity
                                            .incomeByCategory
                                            .keys
                                            .toList()
                                            .indexOf(entry.key);
                                        return PieChartSectionData(
                                          color: giveColor(index),
                                          value: entry
                                              .value, // already the percentage
                                          title:
                                              '${entry.value.toStringAsFixed(0)}%',
                                          radius: 30,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      formatCurrency(entity.totalIncome),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                    Text(
                                      "Total Income",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black.withValues(
                                              alpha: 0.6,
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: entity.incomeByCategory.entries.map((
                                e,
                              ) {
                                final index = entity.incomeByCategory.keys
                                    .toList()
                                    .indexOf(e.key);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          color: giveColor(index),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '${getExpense(e.key)}  ${e.value.ceil()} %',
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Color giveColor(int index) {
  final colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
  ];
  return colors[index % colors.length];
}

String getExpense(IncomeCategory category) {
  switch (category) {
    case IncomeCategory.salary:
      return 'Salary';
    case IncomeCategory.freelance:
      return 'Freelance';
    case IncomeCategory.business:
      return 'Business';
    case IncomeCategory.investment:
      return 'Investment';
    case IncomeCategory.rentalIncome:
      return 'RentalIncome';
    case IncomeCategory.interest:
      return "Interest";
    case IncomeCategory.gift:
      return "Gift";
    case IncomeCategory.other:
      return "Other";
  }
}
