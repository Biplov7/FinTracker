import 'package:fintracker/domain/wallet/usecases/get_amount_usecases.dart';
import 'package:fintracker/presentation/wallet/bloc/wallet_event.dart';
import 'package:fintracker/presentation/wallet/bloc/wallet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletBloc extends Bloc<WalletEvent,WalletState>{
  final GetAmountUsecases getAmountUsecases;
  WalletBloc(this.getAmountUsecases):super(WalletInitial()){
    on<LoadWalletEvent>(_loadWalletEvent);
  }

  Future<void> _loadWalletEvent(LoadWalletEvent event, Emitter<WalletState> emit) async{
    try{
      final entity = await getAmountUsecases();
      emit(WalletSuccess(entity));
    }catch(e){
      emit(WalletError("Cannot load the wallet ${e.toString()}"));
    }
  }
}