import 'package:fintracker/domain/report/usecases/get_report_usecase.dart';
import 'package:fintracker/presentation/report/bloc/report_event.dart';
import 'package:fintracker/presentation/report/bloc/report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetReportUsecase getReportUsecase;
  ReportBloc({required this.getReportUsecase}) : super(ReportInitial()) {
    on<LoadReportEvent>(_loadReportEvent);
    on<ChangeReprotPeroid>(_changeReportPeroid);
  }

  Future<void> _loadReportEvent(
    LoadReportEvent event,
    Emitter<ReportState> emit,
  ) async {
    try {
      emit(ReportLoading());
      final report = await getReportUsecase(peroid: event.peroid);
      emit(ReportLoaded(report));
    } catch (e) {
      emit(ReportError("Failed to load report ${e.toString()}"));
    }
  }

  void _changeReportPeroid(
    ChangeReprotPeroid event,
    Emitter<ReportState> emit,
  ) async {
    try {
      emit(ReportLoading());
      final report = await getReportUsecase(peroid: event.peroid);
      emit(ReportLoaded(report));
    } catch (e) {
      emit(ReportError("Failed to change peroid ${e.toString()}"));
    }
  }
}
