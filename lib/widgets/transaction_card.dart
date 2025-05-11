import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kobipay_fe/consts.dart';
import 'package:kobipay_fe/models/transaction_history.dart';
import 'package:kobipay_fe/widgets/netflix_image.dart';

class KobiPayTransactionCard extends StatefulWidget {
  final KobiPayTransaction transaction;

  const KobiPayTransactionCard({super.key, required this.transaction});

  @override
  State<KobiPayTransactionCard> createState() => _KobiPayTransactionCardState();
}

class _KobiPayTransactionCardState extends State<KobiPayTransactionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    fadeAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();

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

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return 'Today ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'pm' : 'am'}';
    } else if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day - 1) {
      return 'Yesterday ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'pm' : 'am'}';
    } else {
      return '$monthName $dayWithSuffix, ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'pm' : 'am'}';
    }
  }

  String formatAmount(String amount) {
    return '-\$$amount';
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Card(
        color: AppColors.kobiPayWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          contentPadding: const EdgeInsets.only(
            bottom: 10,
            top: 5,
            right: 15,
            left: 10,
          ),
          leading: NetflixImage(
            width: 7,
            height: 20,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          ),
          minLeadingWidth: 10,
          title: Text(
            widget.transaction.label,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            formatDateTime(widget.transaction.dateTime),
            style: GoogleFonts.poppins(
              color: AppColors.kobiPayDarkGrey,
              fontSize: 12,
            ),
          ),
          trailing: Text(
            formatAmount(widget.transaction.amount),
            style: GoogleFonts.poppins(
              color: AppColors.kobiPayLightOrange,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
