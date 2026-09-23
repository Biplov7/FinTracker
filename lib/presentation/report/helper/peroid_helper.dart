import 'package:fintracker/domain/report/entities/report_peroid.dart';

class PeroidHelper {
  static String getPeroid(ReportPeroid period){
    switch(period){
      
      case ReportPeroid.daily:
        return "Daily";
      case ReportPeroid.monthly:
        return "Monthly";
      case ReportPeroid.yearly:
      return "Yearly";
    }
  }
}