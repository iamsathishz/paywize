import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';
import 'dart:convert';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat(
      'EEEE, dd MMMM yyyy - hh:mm a',
    ).format(transaction.dateTime);
    final statusColor =
        transaction.status == 'Credit' ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction Detail',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Hero(
        tag: transaction.hashCode,
        child: Material(
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Amount', '₹${transaction.amount.toStringAsFixed(2)}'),
                _label('Status', transaction.status, color: statusColor),
                _label('Date', dateStr),
                _label('Remarks', transaction.remarks),
                const SizedBox(height: 16),
                Text(
                  'Raw JSON',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SelectableText(
                    const JsonEncoder.withIndent(
                      '  ',
                    ).convert(transaction.toJson()),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String title, String value, {Color? color}) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
