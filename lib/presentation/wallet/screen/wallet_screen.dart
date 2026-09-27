import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/presentation/wallet/bloc/wallet_bloc.dart';
import 'package:fintracker/presentation/wallet/bloc/wallet_event.dart';
import 'package:fintracker/presentation/wallet/bloc/wallet_state.dart';
import 'package:fintracker/presentation/wallet/widget/wallet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(LoadWalletEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Wallet", style: TextTheme.of(context).titleLarge),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add), iconSize: 30),
        ],
      ),
      body: BlocConsumer<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletSuccess) {
            final wallet = state.entity;
            return Column(
              children: [
                WalletContainer(
                  accountName: "Bank Account",
                  amount: wallet.bankAccountAmount,
                  title: "Main Bank",
                  colorContent: Color(0xFF0FA052),
                  iconContent: Icons.account_balance,
                ),
                WalletContainer(
                  accountName: "Cash Wallet",
                  amount: wallet.cashWalletAmount,
                  title: "Physical Cash",
                  colorContent: Color(0xFF7652D3),
                  iconContent: Icons.account_balance_wallet,
                ),
                WalletContainer(
                  accountName: "Savings",
                  amount: wallet.savingAmount,
                  title: "For Future",
                  colorContent: Color(0xFFFF9F0A),
                  iconContent: Icons.savings,
                ),
                WalletContainer(
                  accountName: "Credit Card",
                  amount: wallet.creditCard,
                  title: "Outstanding",
                  colorContent: Color(0xFF1769C2),
                  iconContent: Icons.credit_card,
                ),
              ],
            );
          }
          return SizedBox();
        },
        listener: (context, state) {
          if (state is WalletError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Cannot Load Wallet"),
                behavior: SnackBarBehavior.floating,
                showCloseIcon: true,
              ),
            );
          }
        },
      ),
    );
  }
}
