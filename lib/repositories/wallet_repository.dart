import 'dart:async';
import 'dart:math';

class WalletRepository {
  final StreamController<double> _balanceController =
      StreamController<double>();
  late final Stream<double> _broadcastStream;
  late final Timer _timer;
  double _balance;

  WalletRepository({double initialBalance = 1000}) : _balance = initialBalance {
    _broadcastStream = _balanceController.stream.asBroadcastStream();
    final Random random = Random();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final double randomAmount = random.nextInt(101).toDouble();
      _balance += randomAmount;
      _balanceController.add(_balance);
    });
  }

  Stream<double> getBalanceStream() => _broadcastStream;

  double get currentBalance => _balance;

  double payout(double amount) {
    _balance -= amount;
    _balanceController.add(_balance);
    return _balance;
  }

  void dispose() {
    _timer.cancel();
    _balanceController.close();
  }
}
