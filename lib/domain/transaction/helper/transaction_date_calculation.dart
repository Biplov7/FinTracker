import 'package:fintracker/domain/transaction/enum/transaction_peroid.dart';
import 'package:fintracker/domain/transaction/helper/transaction_date_range.dart';

TransactionDateRange getDateTime(TransactionPeroid peroid) {
  final now = DateTime.now();
  final weekday = now.weekday;

  switch (peroid) {
    case TransactionPeroid.today:
      return TransactionDateRange(
        startDate: DateTime(now.year, now.month, now.day),
        endDate: DateTime(now.year, now.month, now.day + 1),
      );
    case TransactionPeroid.thisWeek:
    final daysFromMonday = weekday-1;
    final startday = DateTime(
      now.year,
      now.month,
      now.day - daysFromMonday
    );
    final endday = startday.add(const Duration(days: 7));
      return TransactionDateRange(
        startDate: startday,
        endDate: endday
      );
    case TransactionPeroid.thisMonth:
      return TransactionDateRange(
        startDate: DateTime(now.year, now.month, 1),
        endDate: DateTime(now.year, now.month+1, 1),  
      );
    case TransactionPeroid.thisYear:
      return TransactionDateRange(
        startDate: DateTime(now.year, 1, 1),
        endDate: DateTime(now.year+1, 1, 1),
      );
  }
}
