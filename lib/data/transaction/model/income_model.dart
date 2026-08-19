import 'package:ecommerce/domain/transaction/entities/income_entity.dart';
import 'package:ecommerce/domain/transaction/entities/income_category.dart';
import 'package:ecommerce/domain/transaction/entities/income_source.dart';

class IncomeModel extends IncomeEntity {
  IncomeModel({
    required super.id,
    required super.amount,
    required super.category,
    required super.description,
    required super.date,
    required super.source

  });

  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      id: map['id'] as String,
      amount: (map['amount'] as num).toDouble(),
      category: IncomeCategory.values.byName(map['category'] as String),
      description: map['description'] as String,
      date: DateTime.parse(map['date'] as String),
      source: IncomeSource.values.byName(
        (map['source'] as String).split('.').last,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category.name,
      'description': description,
      'date': date.toIso8601String(),
      'source': source.name,
    };
  }
}
