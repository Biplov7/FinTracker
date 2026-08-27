import 'dart:async';
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

  Timer? _refreshTimer;

  DashboardBloc({
    required this.getdashboarddataUsecase,
    required this.getrecenttransactionUsecase,
    required this.updatedashboarddataUsecase,
    required this.getUserProfileUseCase,
  }) : super(DashboardInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<RefreshDashboard>(_onRefreshDashboard);
  }

  void _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(DashboardLoading());

      // Run dashboard data and user profile in parallel (recentTransaction is slower)
      final results = await Future.wait<dynamic>([
        getdashboarddataUsecase(),
        getUserProfileUseCase(),
        getrecenttransactionUsecase(),
      ]);

      final dashboardData = results[0] as dynamic;
      final userProfile = results[1] as dynamic;
      final recentTransaction = results[2] as dynamic;

      emit(
        DashboardLoaded(dashboardData, recentTransaction, userProfile.username),
      );

      // Start periodic refresh every 2 seconds
      _startPeriodicRefresh();
    } catch (e) {
      emit(DashboardFailure("Cannot load the data"));
    }
  }

  void _onRefreshDashboard(
    RefreshDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final dashboardData = await getdashboarddataUsecase();
      final recentTransaction = await getrecenttransactionUsecase();

      if (state is DashboardLoaded) {
        final currentState = state as DashboardLoaded;
        emit(
          DashboardLoaded(
            dashboardData,
            recentTransaction,
            currentState.userName,
          ),
        );
      }
    } catch (e) {
      // Silent fail - don't show error on periodic refresh
    }
  }

  void _startPeriodicRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      add(RefreshDashboard());
    });
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    return super.close();
  }
}
