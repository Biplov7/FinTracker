import 'package:fintracker/data/wallet/datasource/wallet_datasource.dart';
import 'package:fintracker/data/wallet/model/wallet_model.dart';
import 'package:fintracker/domain/add_transaction/entities/expense_wallet.dart';
import 'package:fintracker/domain/add_transaction/entities/income_source.dart';
import 'package:fintracker/domain/wallet/entities/wallet_entities.dart';
import 'package:fintracker/domain/wallet/repositories/wallet_repositories.dart';

class WalletRepositoriesImplementation extends WalletRepositories {
  final WalletDatasource wd;

  WalletRepositoriesImplementation(this.wd);
  @override
  Future<WalletEntities> getAmountInformation() async {
    double totalSavingAmount = 0;
    double totalWalletAmount = 0;
    double totalBankAmount = 0;
    double totalCreditAmount = 0;

    final incomeList = await wd.getAllIncome();
    final expenseList = await wd.getAllExpense();

    for (final income in incomeList) {
      if (income.source == IncomeSource.savingAccount) {
        totalSavingAmount += income.amount;
      }

      if (income.source == IncomeSource.esewa) {
        totalWalletAmount += income.amount;
      }

      if (income.source == IncomeSource.nabilBank) {
        totalBankAmount += income.amount;
      }
    }

    for(var expense in expenseList){
      if(expense.wallet == ExpenseWallet.creditCard){
        totalCreditAmount += expense.amount;
      }
    }

    return WalletModel(
      totalBankAmount,
      totalWalletAmount,
      totalSavingAmount,
      totalCreditAmount,
    );
  }
}
