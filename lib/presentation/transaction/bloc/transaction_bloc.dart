import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fintracker/domain/transaction/entity/transaction_entity.dart';
import 'package:fintracker/domain/transaction/entity/transaction_enum.dart';
import 'package:fintracker/domain/transaction/enum/transaction_peroid.dart';
import 'package:fintracker/domain/transaction/helper/transaction_date_calculation.dart';
import 'package:fintracker/domain/transaction/usecases/loadtransaction_usecases.dart';
import 'package:fintracker/presentation/transaction/bloc/transaction_event.dart';
import 'package:fintracker/presentation/transaction/bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final LoadtransactionUsecases loadtransactionUsecases;

  TransactionBloc({required this.loadtransactionUsecases})
      : super(InitialState()) {
    on<InitialEvent>(_initialEvent, transformer: restartable());
    on<LoadTransactionEvent>(_loadTransactionEvent, transformer: restartable());
  }

  Future<void> _initialEvent(
    InitialEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    final dataRange = getDateTime(TransactionPeroid.thisYear);

    await emit.forEach<List<TransactionEntity>>(
      loadtransactionUsecases.call(
        type: TransactionEnum.all,
        startDate: dataRange.startDate,
        endDate: dataRange.endDate,
      ),
      onData: (transactions) => TransactionSuccess(
        transactions: transactions,
        period: TransactionPeroid.thisYear,
        type: TransactionEnum.all,
      ),
      onError: (error, stackTrace) =>
          TransactionFailure("Cannot Load Transaction"),
    );
  }

  Future<void> _loadTransactionEvent(
    LoadTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    final dataRange = getDateTime(event.period);

    await emit.forEach<List<TransactionEntity>>(
      loadtransactionUsecases.call(
        type: event.type,
        startDate: dataRange.startDate,
        endDate: dataRange.endDate,
      ),
      onData: (transactions) => TransactionSuccess(
        transactions: transactions,
        period: event.period,
        type: event.type,
      ),
      onError: (error, stackTrace) =>
          TransactionFailure("Failed to load: ${error.toString()}"),
    );
  }
}
