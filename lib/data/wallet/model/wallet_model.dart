import 'package:fintracker/domain/wallet/entities/wallet_entities.dart';

class WalletModel extends WalletEntities {
  WalletModel(
    super.bankAccountAmount,
    super.cashWalletAmount,
    super.savingAmount,
    super.creditCard,
  );

  Map<String, dynamic> toMap() {
    return {
      'bankAccountAmount': bankAccountAmount,
      'cashWalletAmount': cashWalletAmount,
      'savingAmount': savingAmount,
      'creditCard': creditCard,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      (map['bankAccountAmount'] ?? 0).toDouble(),
      (map['cashWalletAmount'] ?? 0).toDouble(),
      (map['savingAmount'] ?? 0).toDouble(),
      (map['creditCard'] ?? 0).toDouble(),
    );
  }
}