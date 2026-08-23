import 'package:ecommerce/domain/dashboard/repositories/dashboard_repo.dart';

class SetBudgetUsecase {
  final DashboardRepo repo;

  SetBudgetUsecase(this.repo);

  Future<void> call(double budgetLimit) {
    return repo.setBudgetLimit(budgetLimit);
  }
}
