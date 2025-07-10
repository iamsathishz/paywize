import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paywize_r2_interview/helper/theme.dart';
import 'screens/wallet_screen.dart';
import 'repositories/wallet_repository.dart';
import 'blocs/wallet_bloc.dart';
import 'blocs/wallet_event.dart';

void main() {
  runApp(const WalletApp());
}

class WalletApp extends StatelessWidget {
  const WalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paywize R2 Interview',
      debugShowCheckedModeBanner: false,
      theme: appDarkTheme,
      home: BlocProvider(
        create: (_) => WalletBloc(WalletRepository())..add(StartWalletStream()),
        child: const WalletScreen(),
      ),
    );
  }
}
