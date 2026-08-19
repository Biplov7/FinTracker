abstract class TransactionState {}

class TransactionInitial extends TransactionState{}

class TransactionSuccess extends TransactionState{
  final String msg;
  TransactionSuccess(this.msg);
}

class TransactionFailure extends TransactionState{
  final String msg;
  TransactionFailure(this.msg);
}

class TransactionLoading extends TransactionState{}
