import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paywize_r2_interview/models/transaction_model.dart';
import 'package:paywize_r2_interview/screens/transaction_details_screen.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.status == 'Credit';
    final formattedAmount =
        "${isCredit ? '+' : '-'}₹${transaction.amount.toStringAsFixed(2)}";
    final formattedTime = DateFormat('hh:mm a').format(transaction.dateTime);
    final statusColor = isCredit ? Colors.green : Colors.red;

    return ListTile(
      onTap: () => _openDetail(context, transaction),
      title: Text(
        formattedAmount,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isCredit ? Colors.white : Colors.red,
        ),
      ),
      subtitle: Text(
        "$formattedTime • ${transaction.remarks}",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
      trailing: Text(
        transaction.status,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, txn) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, __, ___) => TransactionDetailScreen(transaction: txn),
        transitionsBuilder:
            (_, anim, __, child) => SlideTransition(
              position: Tween(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            ),
      ),
    );
  }
}
