import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kobipay_fe/consts.dart';
import 'package:kobipay_fe/models/transaction_detail.dart';
import 'package:kobipay_fe/models/transaction_history.dart';
import 'package:kobipay_fe/widgets/dollar_image.dart';
import 'package:kobipay_fe/widgets/netflix_image.dart';
import 'package:kobipay_fe/widgets/transaction_status_banner.dart';

class KobiPayDetailPage extends StatefulWidget {
  final KobiPayTrasanctionDetail transactionDetail;
  const KobiPayDetailPage({super.key, required this.transactionDetail});

  @override
  State<KobiPayDetailPage> createState() =>
      _KobiPayTransactionDetailPageState();
}

class _KobiPayTransactionDetailPageState extends State<KobiPayDetailPage> {
  late KobiPayTransactionStatus status;
  bool isRefunded = false;

  @override
  void initState() {
    super.initState();
    status = widget.transactionDetail.transactionStatus;
  }

  void handleRefund() {
    setState(() {
      status = KobiPayTransactionStatus.refunded;
      isRefunded = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Transaction has been refunded.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.kobiPayGreen,
      ),
    );
  }

  String getTransactionTypeText(KobiPayTransactionType type) {
    switch (type) {
      case KobiPayTransactionType.purchase:
        return 'Purchase';
      case KobiPayTransactionType.billPayment:
        return 'Bill Payment';
      case KobiPayTransactionType.withdrawal:
        return 'Withdrawal';
      case KobiPayTransactionType.subscription:
        return 'Subscription';
    }
  }

  String getPaymentMethodText(KobiPayPaymentMethod method) {
    switch (method) {
      case KobiPayPaymentMethod.creditCard:
        return 'Credit Card';
      case KobiPayPaymentMethod.debitCard:
        return 'Debit Card';
      case KobiPayPaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case KobiPayPaymentMethod.mobilePayment:
        return 'Mobile Payment';
    }
  }

  String formatDateTime(DateTime dateTime) {
    String getDaySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final monthName = monthNames[dateTime.month - 1];
    final dayWithSuffix = '${dateTime.day}${getDaySuffix(dateTime.day)}';

    return '$monthName $dayWithSuffix, ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}${dateTime.hour >= 12 ? 'pm' : 'am'}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kobiPayBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.kobiPayBlack,
        elevation: 0,
        actions: [
          // customer support icon
          Icon(Icons.support_agent_rounded, size: 30),
        ],
        actionsPadding: const EdgeInsets.only(right: 35.0),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.chevron_left_rounded, size: 30),
        ),
        centerTitle: true,
        title: Text(
          'Transaction Details',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(35, 45, 35, 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.kobiPayLightGrey,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 35),
                      Text(
                        widget.transactionDetail.merchantName,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Baseline(
                            baseline: 30,
                            baselineType: TextBaseline.alphabetic,
                            child: Text(
                              widget.transactionDetail.transactionAmount,
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Baseline(
                            baseline: 25,
                            baselineType: TextBaseline.alphabetic,
                            child: DollarImage(width: 22, height: 22),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -20,
                  child: NetflixImage(
                    width: 10,
                    height: 25,
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 35),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: AppColors.kobiPayLightGrey,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  infoTile(
                    "Transaction Type",
                    getTransactionTypeText(
                      widget.transactionDetail.transactionType,
                    ),
                  ),
                  infoTile(
                    'Payment Method',
                    getPaymentMethodText(
                      widget.transactionDetail.paymentMethod,
                    ),
                  ),
                  statusTile("Transaction Status", status),
                  infoTile(
                    'Transaction Date',
                    formatDateTime(
                      widget.transactionDetail.transactionDateTime,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 5,
              children: [
                ElevatedButton(
                  onPressed: isRefunded ? null : handleRefund,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    backgroundColor:
                        isRefunded
                            ? AppColors.kobiPayLightGrey
                            : AppColors.kobiPayLightOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isRefunded ? 'Refunded' : 'Refund',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: AppColors.kobiPayBlack,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    backgroundColor: AppColors.kobiPayPeach,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Share Receipt',
                    style: GoogleFonts.poppins(
                      color: AppColors.kobiPayBlack,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget infoTile(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AppColors.kobiPayDarkGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: AppColors.kobiPayDarkGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget statusTile(String label, KobiPayTransactionStatus status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AppColors.kobiPayDarkGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        KobiPayTransactionStatusBanner(status: status),
      ],
    );
  }

  Widget amountTile(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AppColors.kobiPayDarkGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Baseline(
              baseline: 30,
              baselineType: TextBaseline.alphabetic,
              child: Text(
                amount,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Baseline(
              baseline: 25,
              baselineType: TextBaseline.alphabetic,
              child: SvgPicture.asset(
                kobiPayDollarIcon,
                height: 20,
                width: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.kobiPayPink,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
