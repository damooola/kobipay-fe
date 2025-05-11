import 'package:kobipay_fe/consts.dart';
import 'package:kobipay_fe/models/transaction_history.dart';

class KobiPayTransactionDB {
  //mock trasaction list
  static List<KobiPayTransaction> kobiPayTransactions = [
    KobiPayTransaction(
      icon: kobiPayTransactionIcon,
      label: kobiPayTransactiionLabel,
      dateTime: DateTime(2025, 5, 11, 20, 24),
      amount: '17.99',
      transactionStatus: KobiPayTransactionStatus.successful,
      transactionType: KobiPayTransactionType.billPayment,
      paymentMethod: KobiPayPaymentMethod.creditCard,
    ),
    KobiPayTransaction(
      icon: kobiPayTransactionIcon,
      label: kobiPayTransactiionLabel,
      dateTime: DateTime(2025, 5, 10, 10, 54),
      amount: '32.45',
      transactionStatus: KobiPayTransactionStatus.pending,
      transactionType: KobiPayTransactionType.subscription,
      paymentMethod: KobiPayPaymentMethod.debitCard,
    ),
    KobiPayTransaction(
      icon: kobiPayTransactionIcon,
      label: kobiPayTransactiionLabel,
      dateTime: DateTime(2025, 5, 4, 05, 04),
      amount: '23.56',
      transactionStatus: KobiPayTransactionStatus.failed,
      transactionType: KobiPayTransactionType.purchase,
      paymentMethod: KobiPayPaymentMethod.bankTransfer,
    ),
    KobiPayTransaction(
      icon: kobiPayTransactionIcon,
      label: kobiPayTransactiionLabel,
      dateTime: DateTime(2025, 5, 3, 23, 24),
      amount: '45.62',
      transactionStatus: KobiPayTransactionStatus.successful,
      transactionType: KobiPayTransactionType.withdrawal,
      paymentMethod: KobiPayPaymentMethod.mobilePayment,
    ),
  ];

  // mock json list
  static List<Map<String, dynamic>> mockJsonList = [
    {
      "icon": kobiPayTransactionIcon,
      "label": kobiPayTransactiionLabel,
      "dateTime": "2025-05-11T20:24:00",
      "amount": "9.89",
      "transactionType": 1,
      "paymentMethod": 0,
      "transactionStatus": 0,
    },
    {
      "icon": kobiPayTransactionIcon,
      "label": kobiPayTransactiionLabel,
      "dateTime": "2025-05-10T10:54:00",
      "amount": "12.69",
      "transactionType": 1,
      "paymentMethod": 2,
      "transactionStatus": 1,
    },
    {
      "icon": kobiPayTransactionIcon,
      "label": kobiPayTransactiionLabel,
      "dateTime": "2025-05-04T05:04:00",
      "amount": "7.93",
      "transactionType": 1,
      "paymentMethod": 3,
      "transactionStatus": 0,
    },
    {
      "icon": kobiPayTransactionIcon,
      "label": kobiPayTransactiionLabel,
      "dateTime": "2025-05-03T23:24:00",
      "amount": "14.99",
      "transactionType": 3,
      "paymentMethod": 1,
      "transactionStatus": 2,
    },
  ];
}
