class FormValidators {
  /// Validates amount field
  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter an amount";
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return "Enter a valid amount";
    }

    if (amount <= 0) {
      return "Amount must be greater than 0";
    }

    return null;
  }

  /// Validates category selection
  static String? validateCategory(dynamic value) {
    if (value == null) {
      return "Please select a category";
    }
    return null;
  }

  /// Validates wallet/source selection
  static String? validateWallet(dynamic value) {
    if (value == null) {
      return "Please select a wallet";
    }
    return null;
  }

  /// Validates date selection
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select a date";
    }
    return null;
  }

  /// Validates description (optional but max length check)
  static String? validateDescription(String? value) {
    if (value != null && value.length > 100) {
      return "Description must be less than 100 characters";
    }
    return null;
  }

  static String? validateExpenseAgainstBalance(double? expenseAmount, double currentBalance){
    if(expenseAmount == null || expenseAmount< 0){
      return "Please enter a valid amount";
    }
    if(expenseAmount> currentBalance){
      return "Expense exceeds your current balance of \$${currentBalance.toStringAsFixed(2)}";
    }
    return null;
  }
}
