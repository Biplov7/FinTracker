import 'package:ecommerce/domain/dashboard/entities/dashboard_entities.dart';
import 'package:ecommerce/domain/dashboard/entities/recent_transaction_entity.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardEntities dashboard;
  final List<RecentTransactionEntity> recentTransaction;
  final String userName;

  DashboardLoaded(this.dashboard, this.recentTransaction, this.userName);
}

class DashboardFailure extends DashboardState {
  final String error;

  DashboardFailure(this.error);
}
