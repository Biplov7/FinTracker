import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fintracker/domain/report/entities/report_entities.dart';
import 'package:fintracker/domain/report/usecases/get_report_usecase.dart';
import 'package:fintracker/presentation/report/bloc/report_event.dart';
import 'package:fintracker/presentation/report/bloc/report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetReportUsecase getReportUsecase;

  ReportBloc({required this.getReportUsecase}) : super(ReportInitial()) {
    on<LoadReportEvent>(_loadReportEvent, transformer: restartable());
    on<ChangeReprotPeroid>(_changeReportPeroid, transformer: restartable());
  }

  Future<void> _loadReportEvent(
    LoadReportEvent event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportLoading());
    await emit.forEach<ReportEntities>(
      getReportUsecase(peroid: event.peroid),
      onData: (report) => ReportLoaded(report),
      onError: (error, stackTrace) =>
          ReportError("Failed to load report: ${error.toString()}"),
    );
  }

  Future<void> _changeReportPeroid(
    ChangeReprotPeroid event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportLoading());
    await emit.forEach<ReportEntities>(
      getReportUsecase(peroid: event.peroid),
      onData: (report) => ReportLoaded(report),
      onError: (error, stackTrace) =>
          ReportError("Failed to change period: ${error.toString()}"),
    );
  }
}
