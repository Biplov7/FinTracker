import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintracker/domain/add_transaction/entities/income_entity.dart';
import 'package:fintracker/domain/add_transaction/entities/income_category.dart';
import 'package:fintracker/domain/add_transaction/entities/income_source.dart';

class IncomeModel extends IncomeEntity {
  final DateTime createdAt;

  IncomeModel({
    required super.id,
    required super.amount,
    required super.category,
    required super.description,
    required super.date,
    required super.source,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      id: map['id'] as String,
      amount: (map['amount'] as num).toDouble(),
      category: IncomeCategory.values.byName(map['category'] as String),
      description: map['description'] as String,
      date: (map['date'] is Timestamp)
          ? (map['date'] as Timestamp).toDate()
          : DateTime.parse(map['date'] as String),
      source: IncomeSource.values.byName(
        (map['source'] as String).split('.').last,
      ),
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] is Timestamp)
              ? (map['createdAt'] as Timestamp).toDate()
              : DateTime.parse(map['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category.name,
      'description': description,
      'date': Timestamp.fromDate(date),
      'source': source.name,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

