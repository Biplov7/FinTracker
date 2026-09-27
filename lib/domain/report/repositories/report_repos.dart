import 'package:fintracker/domain/report/entities/report_entities.dart';
import 'package:fintracker/domain/report/entities/report_peroid.dart';

abstract class ReportRepo {
  Stream<ReportEntities> getReport(ReportPeroid peroid);
}