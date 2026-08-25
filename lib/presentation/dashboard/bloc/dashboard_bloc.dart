import 'package:ecommerce/domain/dashboard/usecases/getdashboarddata_usecase.dart';
import 'package:ecommerce/domain/dashboard/usecases/getuserprofile_usecase.dart';
import 'package:ecommerce/domain/dashboard/usecases/getrecenttransaction_usecase.dart';
import 'package:ecommerce/domain/dashboard/usecases/updatedashboarddata_usecase.dart';
import 'package:ecommerce/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:ecommerce/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetdashboarddataUsecase getdashboarddataUsecase;
  final GetrecenttransactionUsecase getrecenttransactionUsecase;
  final UpdatedashboarddataUsecase updatedashboarddataUsecase;
  final GetUserProfileUseCase getUserProfileUseCase;

  DashboardBloc({
    required this.getdashboarddataUsecase,
    required this.getrecenttransactionUsecase,
    required this.updatedashboarddataUsecase,
    required this.getUserProfileUseCase,
  }) : super(DashboardInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
  }

  void _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(DashboardLoading());
      final dashboardData = await getdashboarddataUsecase();
      final userProfile = await getUserProfileUseCase();
      emit(DashboardSuccess(dashboardData, userProfile.username));
    } catch (e) {
      emit(DashboardFailure("Cannot load the data"));
    }
  }
}
