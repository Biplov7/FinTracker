import 'package:ecommerce/domain/dashboard/usecases/getdashboarddata_usecase.dart';
import 'package:ecommerce/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:ecommerce/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetdashboarddataUsecase getdashboarddataUsecase;
  DashboardBloc({required this.getdashboarddataUsecase}) : super(DashboardInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
  }

  void _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(DashboardLoading());
      final entity = await getdashboarddataUsecase();
      emit(DashboardSuccess(entity));
    } catch (e) {
      emit(DashboardFailure("Cannot load the data"));
    }
  }
}
