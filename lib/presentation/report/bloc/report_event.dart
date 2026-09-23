import 'package:fintracker/domain/report/entities/report_peroid.dart';

abstract class ReportEvent {}


class LoadReportEvent extends ReportEvent{
  ReportPeroid peroid;
  LoadReportEvent(this.peroid);
}

class ChangeReprotPeroid extends ReportEvent{
  ReportPeroid peroid;
  ChangeReprotPeroid(this.peroid);
}