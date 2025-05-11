import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTransactionsFromLocal extends TransactionEvent {}

class FetchTransactionsFromJsonList extends TransactionEvent {}

class FetchTransactionsFromLocalJson extends TransactionEvent {}

class FetchTransactionsFromRemote extends TransactionEvent {}
