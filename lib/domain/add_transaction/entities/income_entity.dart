import 'package:fintracker/domain/add_transaction/entities/income_category.dart';
import 'package:fintracker/domain/add_transaction/entities/income_source.dart';

class IncomeEntity {
  final String id;
  final double amount;
  final IncomeCategory category;
  final String description;
  final DateTime date;
  final IncomeSource source;

  const IncomeEntity({
    this.id = '',
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
    required this.source
  });

  IncomeEntity copyWith({
    String? id,
    double? amount,
    IncomeCategory? category,
    String? description,
    DateTime? date,
    IncomeSource? source
  }) {
    return IncomeEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
      source: source ?? this.source
    );
  }
}

