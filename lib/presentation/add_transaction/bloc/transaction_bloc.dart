import 'package:fintracker/domain/dashboard/usecases/updatedashboarddata_usecase.dart';
import 'package:fintracker/domain/add_transaction/usecases/addexpense_usecase.dart';
import 'package:fintracker/domain/add_transaction/usecases/addincome_usecase.dart';
import 'package:fintracker/domain/add_transaction/usecases/setbudget_usecase.dart';
import 'package:fintracker/presentation/add_transaction/bloc/transaction_event.dart';
import 'package:fintracker/presentation/add_transaction/bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent,TransactionState>{
  final AddexpenseUsecase addexpenseUsecase;
  final AddincomeUsecase addincomeUsecase;
  final SetBudgetUsecase setBudgetUsecase;
  final UpdatedashboarddataUsecase updatedashboarddataUsecase;
  TransactionBloc({
    required this.addexpenseUsecase,
    required this.addincomeUsecase,
    required this.setBudgetUsecase,
    required this.updatedashboarddataUsecase
  }):super(TransactionInitial()){
    on<AddExpenseEvent>(_addExpenseEvent);
    on<AddIncomeEvent>(_addIncomeEvent);
    on<AddBudgetEvent>(_addBudgetEvent);
  }

  void _addExpenseEvent(AddExpenseEvent event, Emitter<TransactionState> emit) async {
    try {
      emit(TransactionLoading());

      // Get current balance to check if expense exceeds it
      final dashboardData = await updatedashboarddataUsecase();

      if (event.entity.amount > dashboardData.currentBalance) {
        emit(TransactionFailure(
          "Expense exceeds your current balance of \$${dashboardData.currentBalance.toStringAsFixed(2)}",
        ));
        return;
      }

      await addexpenseUsecase(event.entity);
      await updatedashboarddataUsecase();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      emit(TransactionSuccess("Expense Added Successfully"));
    } catch (e) {
      emit(TransactionFailure("Error Occured"));
    }
  }

  void _addIncomeEvent(AddIncomeEvent event, Emitter<TransactionState> emit) async {
    try{
      emit(TransactionLoading());
      await addincomeUsecase(event.entity);
      await updatedashboarddataUsecase();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      emit(TransactionSuccess("Income Added Successfully"));
    }catch(e){
      emit(TransactionFailure("Error Occured"));
    }
  }

  void _addBudgetEvent(AddBudgetEvent event, Emitter<TransactionState> emit) async {
    try{
      emit(TransactionLoading());
      await setBudgetUsecase(event.budgetLimit);
      await updatedashboarddataUsecase();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      emit(TransactionSuccess("Budget Limit Set Successfully"));
    }catch(e){
      emit(TransactionFailure("Error Occurred"));
    }
  }
}


