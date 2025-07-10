abstract class WalletEvent {}

class StartWalletStream extends WalletEvent {}

class PayoutRequested extends WalletEvent {
  final double amount;
  PayoutRequested(this.amount);
}
