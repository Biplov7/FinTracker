import 'package:fintracker/domain/transaction/helper/transaction_date_calculation.dart';
import 'package:fintracker/domain/transaction/usecases/loadtransaction_usecases.dart';
import 'package:fintracker/presentation/transaction/bloc/transaction_event.dart';
import 'package:fintracker/presentation/transaction/bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final LoadtransactionUsecases loadtransactionUsecases;
  TransactionBloc({required this.loadtransactionUsecases})
    : super((InitialState())) {
    on<InitialEvent>(_initialEvent);
    on<LoadTransactionEvent>(_loadTransactionEvent);
  }

  Future<void> _initialEvent(InitialEvent event, Emitter<TransactionState> emit) async {
    try {
      emit(InitialState());
    } catch (e) {
      emit(TransactionFailure('Cannot Load Transaction'));
    }
  }

  Future<void> _loadTransactionEvent(
    LoadTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      emit(TransactionLoading());
      final dataRange = getDateTime(event.period);
      final transaction = await loadtransactionUsecases.call(
        type: event.type,
        startDate: dataRange.startDate,
        endDate: dataRange.endDate,
      );
      emit(
        TransactionSuccess(
          transactions: transaction,
          period: event.period,
          type: event.type,
        ),
      );
    } catch (e) {
      emit(TransactionFailure(e.toString()));
    }
  }
}
