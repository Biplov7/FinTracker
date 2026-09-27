import 'package:fintracker/domain/wallet/entities/wallet_entities.dart';

abstract class WalletState {}

class WalletInitial extends WalletState{}

class WalletSuccess extends WalletState {
  final WalletEntities entity;
  WalletSuccess(this.entity);
}

class WalletError extends WalletState {
  final String errMsg;
  WalletError(this.errMsg);
}
