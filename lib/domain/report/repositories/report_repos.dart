import 'package:fintracker/domain/report/entities/report_entities.dart';
import 'package:fintracker/domain/report/entities/report_peroid.dart';

abstract class ReportRepo {
  Future<ReportEntities> getReport(ReportPeroid peroid);
}