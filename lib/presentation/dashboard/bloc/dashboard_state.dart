import 'package:ecommerce/domain/dashboard/entities/dashboard_entities.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState{}

class DashboardLoading extends DashboardState{}

class DashboardSuccess extends DashboardState{
  final DashboardEntities entity;
  DashboardSuccess(this.entity);
}

class DashboardFailure extends DashboardState{
  final String error;
  DashboardFailure(this.error);
}
