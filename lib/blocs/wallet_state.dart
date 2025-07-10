import 'package:paywize_r2_interview/models/transaction_model.dart';

class WalletState {
  final double balance;
  final List<TransactionModel> transactions;

  WalletState(this.balance, this.transactions);

  WalletState copyWith({
    double? balance,
    List<TransactionModel>? transactions,
  }) {
    return WalletState(
      balance ?? this.balance,
      transactions ?? this.transactions,
    );
  }
}
