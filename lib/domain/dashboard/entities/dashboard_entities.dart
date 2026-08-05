class DashboardEntities {
  final double currentBalance;
  final double totalIncome;
  final double totalExpenses;
  final double totalSaving;
  final double budgetUsed;
  final double budgetLimit;

  DashboardEntities(
    this.currentBalance,
    this.totalIncome,
    this.totalExpenses,
    this.totalSaving,
    this.budgetUsed,
    this.budgetLimit,
  );

  DashboardEntities copyWith({
    double? currentBalance,
    double? totalIncome,
    double? totalExpenses,
    double? totalSaving,
    double? budgetUsed,
    double? budgetLimit,
  }) {
    return DashboardEntities(
      currentBalance ?? this.currentBalance,
      totalIncome ?? this.totalIncome,
      totalExpenses ?? this.totalExpenses,
      totalSaving ?? this.totalSaving,
      budgetUsed ?? this.budgetUsed,
      budgetLimit ?? this.budgetLimit,
    );
  }
}