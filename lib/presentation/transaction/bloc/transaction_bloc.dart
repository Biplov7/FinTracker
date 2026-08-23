import 'package:ecommerce/domain/transaction/usecases/addexpense_usecase.dart';
import 'package:ecommerce/domain/transaction/usecases/addincome_usecase.dart';
import 'package:ecommerce/domain/dashboard/usecases/setbudget_usecase.dart';
import 'package:ecommerce/presentation/transaction/bloc/transaction_event.dart';
import 'package:ecommerce/presentation/transaction/bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent,TransactionState>{
  final AddexpenseUsecase addexpenseUsecase;
  final AddincomeUsecase addincomeUsecase;
  final SetBudgetUsecase setBudgetUsecase;

  TransactionBloc({
    required this.addexpenseUsecase,
    required this.addincomeUsecase,
    required this.setBudgetUsecase,
  }):super(TransactionInitial()){
    on<AddExpenseEvent>(_addExpenseEvent);
    on<AddIncomeEvent>(_addIncomeEvent);
    on<AddBudgetEvent>(_addBudgetEvent);
  }

  void _addExpenseEvent(AddExpenseEvent event, Emitter<TransactionState> emit) async {
    try{
      emit(TransactionLoading());
      await addexpenseUsecase(event.entity);
      await Future<void>.delayed(const Duration(milliseconds: 500));
      emit(TransactionSuccess("Expense Added Successfully"));
    }catch(e){
      emit(TransactionFailure("Error Occured"));
    }
  }

  void _addIncomeEvent(AddIncomeEvent event, Emitter<TransactionState> emit) async {
    try{
      emit(TransactionLoading());
      await addincomeUsecase(event.entity);
      await Future<void>.delayed(const Duration(milliseconds: 500));
      emit(TransactionSuccess("Income Added Successfully"));
    }catch(e){
      emit(TransactionFailure("Error Occured"));
    }
  }

  void _addBudgetEvent(AddBudgetEvent event, Emitter<TransactionState> emit) async {
    try{
      emit(TransactionLoading());
      await setBudgetUsecase(event.budgetLimit);
      await Future<void>.delayed(const Duration(milliseconds: 500));
      emit(TransactionSuccess("Budget Limit Set Successfully"));
    }catch(e){
      emit(TransactionFailure("Error Occurred"));
    }
  }
}

