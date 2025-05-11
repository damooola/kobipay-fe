import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobipay_fe/bloc/transaction_bloc.dart';
import 'package:kobipay_fe/screens/transaction_history.dart';
import 'package:kobipay_fe/services/transaction_services.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => TransactionBloc(KobiPayTransactionApi()),
      child: const KobiPayApp(),
    ),
  );
}

class KobiPayApp extends StatelessWidget {
  const KobiPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KobiPayHistoryPage(),
      title: "Kobi Pay",
    );
  }
}
