import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/wallet_bloc.dart';
import '../blocs/wallet_state.dart';
import '../widgets/transaction_tile.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          final transactions = state.transactions;

          if (transactions.isEmpty) {
            return const Center(child: Text("No transactions yet."));
          }

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return TransactionTile(transaction: transactions[index]);
            },
          );
        },
      ),
    );
  }
}
