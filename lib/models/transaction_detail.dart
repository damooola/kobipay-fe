import 'package:kobipay_fe/models/transaction_history.dart';

class KobiPayTrasanctionDetail {
  final String merchantName;
  final String merchantImage;
  final String transactionAmount;
  final DateTime transactionDateTime;
  final KobiPayTransactionType transactionType;
  final KobiPayPaymentMethod paymentMethod;
  final KobiPayTransactionStatus transactionStatus;

  KobiPayTrasanctionDetail({
    required this.merchantName,
    required this.merchantImage,
    required this.transactionAmount,
    required this.transactionDateTime,
    required this.transactionType,
    required this.paymentMethod,
    required this.transactionStatus,
  });

  static KobiPayTrasanctionDetail toTrasanctionDetail(
    KobiPayTransaction transaction,
  ) {
    return KobiPayTrasanctionDetail(
      merchantName: transaction.label,
      merchantImage: transaction.icon,
      transactionAmount: transaction.amount,
      transactionDateTime: transaction.dateTime,
      transactionType: transaction.transactionType,
      paymentMethod: transaction.paymentMethod,
      transactionStatus: transaction.transactionStatus,
    );
  }
}
