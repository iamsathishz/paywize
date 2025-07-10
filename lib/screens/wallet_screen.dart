import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/wallet_bloc.dart';
import '../blocs/wallet_event.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_list.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(StartWalletStream());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(theme),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth >= 720;
          return isWide ? _buildWideLayout() : _buildNarrowLayout();
        },
      ),
    );
  }

  AppBar _buildAppBar(ThemeData theme) {
    return AppBar(
      scrolledUnderElevation: 0,
      centerTitle: false,
      backgroundColor: Colors.black,
      title: Text(
        "Wallet Balance",
        style: theme.textTheme.titleLarge?.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildWideLayout() {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _spacer(32),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: size.width / 4),
                    child: const BalanceCard(),
                  ),
                  _spacer(32),
                  _buildPayoutButton(size.width / 4),
                  _spacer(32),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _spacer(32),
              _buildSectionTitle('Transaction History'),
              const SizedBox(height: 8),
              const Expanded(child: TransactionList()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _spacer(16),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: size.width / 1),
          child: const BalanceCard(),
        ),
        _spacer(16),
        _buildPayoutButton(size.width / 1.2),
        _spacer(16),
        _buildSectionTitle('Transaction History'),
        const SizedBox(height: 8),
        Expanded(child: const TransactionList()),
      ],
    );
  }

  Widget _buildPayoutButton(double maxWidth) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: const Size.fromHeight(56),
        ),
        onPressed: _handlePayout,
        child: const Text(
          "Payout ₹100",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future<void> _handlePayout() async {
    final balance = context.read<WalletBloc>().repository.currentBalance;

    if (balance <= 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Insufficient wallet balance (₹$balance)")),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Confirm Payout"),
            content: const Text("Do you want to payout ₹100?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Confirm"),
              ),
            ],
          ),
    );
    if (confirm == true && context.mounted) {
      context.read<WalletBloc>().add(PayoutRequested(100));
    }
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _spacer(double height) => SizedBox(height: height);
}
