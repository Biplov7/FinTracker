import 'package:fintracker/domain/report/entities/report_entities.dart';
import 'package:fintracker/domain/report/entities/report_peroid.dart';
import 'package:fintracker/domain/report/repositories/report_repos.dart';

class GetReportUsecase {
  final ReportRepo repo;
  GetReportUsecase(this.repo);

  Future<ReportEntities> call({required ReportPeroid peroid}){
    return repo.getReport(peroid);
  }
}