import 'dart:core';

class KobiPayTransaction {
  final String icon;
  final String label;
  final DateTime dateTime;
  final String amount;
  final KobiPayTransactionType transactionType;
  final KobiPayPaymentMethod paymentMethod;
  final KobiPayTransactionStatus transactionStatus;

  const KobiPayTransaction({
    required this.icon,
    required this.label,
    required this.dateTime,
    required this.amount,
    required this.transactionType,
    required this.paymentMethod,
    required this.transactionStatus,
  });

  factory KobiPayTransaction.fromjson(Map<String, dynamic> json) {
    return KobiPayTransaction(
      icon: json['icon'] as String,
      label: json['label'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      amount: json['amount'] as String,
      transactionType:
          KobiPayTransactionType.values[json['transactionType'] as int],
      paymentMethod: KobiPayPaymentMethod.values[json['paymentMethod'] as int],
      transactionStatus:
          KobiPayTransactionStatus.values[json['transactionStatus'] as int],
    );
  }
}

enum KobiPayTransactionStatus { successful, pending, failed, refunded }

enum KobiPayPaymentMethod { creditCard, debitCard, bankTransfer, mobilePayment }

enum KobiPayTransactionType { billPayment, subscription, purchase, withdrawal }
