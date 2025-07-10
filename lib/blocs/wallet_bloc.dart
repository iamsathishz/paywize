import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/transaction_model.dart';
import '../repositories/wallet_repository.dart';
import 'wallet_event.dart';
import 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository repository;
  StreamSubscription<double>? _streamSub;

  WalletBloc(this.repository)
    : super(WalletState(repository.currentBalance, [])) {
    on<StartWalletStream>((event, emit) async {
      await emit.forEach<double>(
        repository.getBalanceStream(),
        onData: (balance) {
          final double delta = balance - state.balance;

          final List<TransactionModel> updatedTxns =
              delta > 0
                  ? [
                    TransactionModel(
                      amount: delta,
                      dateTime: DateTime.now(),
                      status: 'Credit',
                      remarks: 'Wallet top-up',
                    ),
                    ...state.transactions,
                  ]
                  : state.transactions;

          return state.copyWith(balance: balance, transactions: updatedTxns);
        },
      );
    });

    on<PayoutRequested>((event, emit) {
      final updatedBalance = repository.payout(event.amount);

      final newTxn = TransactionModel(
        amount: event.amount,
        dateTime: DateTime.now(),
        status: 'Debit',
        remarks: 'Payout',
      );

      emit(
        state.copyWith(
          balance: updatedBalance,
          transactions: [newTxn, ...state.transactions],
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _streamSub?.cancel();
    repository.dispose();
    return super.close();
  }
}
