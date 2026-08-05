import 'package:ecommerce/domain/dashboard/entities/dashboard_entities.dart';

class DashboardModel extends DashboardEntities {
  DashboardModel(
    super.currentBalance,
    super.totalIncome,
    super.totalExpenses,
    super.totalSaving,
    super.budgetUsed,
    super.budgetLimit,
  );

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    return DashboardModel(
      (map['currentBalance'] ?? 0).toDouble(),
      (map['totalIncome'] ?? 0).toDouble(),
      (map['totalExpenses'] ?? 0).toDouble(),
      (map['totalSaving'] ?? 0).toDouble(),
      (map['budgetUsed'] ?? 0).toDouble(),
      (map['budgetLimit'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentBalance': currentBalance,
      'totalIncome': totalIncome,
      'totalExpenses': totalExpenses,
      'totalSaving': totalSaving,
      'budgetUsed': budgetUsed,
      'budgetLimit': budgetLimit,
    };
  }
}