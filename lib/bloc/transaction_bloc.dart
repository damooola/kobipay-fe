import 'package:bloc/bloc.dart';
import 'package:kobipay_fe/bloc/transaction_event.dart';
import 'package:kobipay_fe/bloc/transaction_state.dart';
import 'package:kobipay_fe/services/transaction_services.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final KobiPayTransactionApi transactionApi;

  TransactionBloc(this.transactionApi) : super(TransactionInitial()) {
    on<FetchTransactionsFromLocalJson>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions =
            await transactionApi.getTransactionHistoryFromLocalJson();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(
          TransactionError('Failed to fetch transactions from local JSON: $e'),
        );
      }
    });

    on<FetchTransactionsFromRemote>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions =
            await transactionApi.getTransactionHistoryFromRemote();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError('Failed to fetch transactions from remote: $e'));
      }
    });

    on<FetchTransactionsFromJsonList>((event, emit) {
      emit(TransactionLoading());
      try {
        final transactions = transactionApi.getTransactionHistoryFromJsonList();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(
          TransactionError('Failed to fetch transactions from json list: $e'),
        );
      }
    });

    on<FetchTransactionsFromLocal>((event, emit) {
      emit(TransactionLoading());
      try {
        final transactions = transactionApi.getTransactionHistoryFromLocal();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError('Failed to fetch transactions from local: $e'));
      }
    });
  }
}
