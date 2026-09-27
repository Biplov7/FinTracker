import 'package:fintracker/domain/wallet/entities/wallet_entities.dart';

abstract class WalletRepositories {
  Future<WalletEntities> getAmountInformation();
}