import 'package:fintracker/domain/report/entities/report_entities.dart';
import 'package:fintracker/domain/report/entities/report_peroid.dart';
import 'package:fintracker/domain/report/repositories/report_repositories.dart';

class GetReportUsecase {
  final ReportRepositories repo;
  GetReportUsecase(this.repo);

  Future<ReportEntities> call({required ReportPeroid peroid}){
    return repo.getReport(peroid);
  }
}