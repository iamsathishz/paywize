import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/wallet_bloc.dart';
import '../blocs/wallet_state.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        return Card(
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "₹${state.balance.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
