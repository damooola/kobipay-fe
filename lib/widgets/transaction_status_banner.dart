import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kobipay_fe/consts.dart';
import 'package:kobipay_fe/models/transaction_history.dart';

class KobiPayTransactionStatusBanner extends StatelessWidget {
  final KobiPayTransactionStatus status;

  const KobiPayTransactionStatusBanner({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    String text;

    switch (status) {
      case KobiPayTransactionStatus.successful:
        icon = Icons.check_circle;
        color = AppColors.kobiPayGreen;
        text = 'Successful';
        break;
      case KobiPayTransactionStatus.failed:
        icon = Icons.cancel;
        color = AppColors.kobiPayRed;
        text = 'Failed';
        break;
      case KobiPayTransactionStatus.pending:
        icon = Icons.hourglass_top_rounded;
        color = AppColors.kobiPayYellow;
        text = 'Pending';
        break;
      case KobiPayTransactionStatus.refunded:
        icon = Icons.subdirectory_arrow_left_rounded;
        color = AppColors.kobiPayDarkOrange;
        text = 'Refunded';
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 5.0),
        Text(text, style: GoogleFonts.poppins(color: color)),
      ],
    );
  }
}
