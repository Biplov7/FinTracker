import 'package:fintracker/domain/report/entities/report_entities.dart';

abstract class ReportState{}

class ReportInitial extends ReportState{}

class ReportLoading extends ReportState{}

class ReportLoaded extends ReportState{
  final ReportEntities entities;
  ReportLoaded(this.entities);
}

class ReportError extends ReportState{
  final String errMsg;
  ReportError(this.errMsg);
}
