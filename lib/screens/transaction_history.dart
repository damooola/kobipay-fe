import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kobipay_fe/bloc/transaction_bloc.dart';
import 'package:kobipay_fe/bloc/transaction_event.dart';
import 'package:kobipay_fe/bloc/transaction_state.dart';
import 'package:kobipay_fe/consts.dart';
import 'package:kobipay_fe/models/transaction_detail.dart';
import 'package:kobipay_fe/screens/transaction_detail.dart';
import 'package:kobipay_fe/widgets/dollar_image.dart';
import 'package:kobipay_fe/widgets/netflix_image.dart';
import 'package:kobipay_fe/widgets/transaction_card.dart';

class KobiPayHistoryPage extends StatefulWidget {
  const KobiPayHistoryPage({super.key});

  @override
  State<KobiPayHistoryPage> createState() => _KobiPayHistoryState();
}

class _KobiPayHistoryState extends State<KobiPayHistoryPage> {
  int touchedIndex = -1;
  @override
  void initState() {
    // can use local,jsonlist,remote or localjson to fetch
    context.read<TransactionBloc>().add(FetchTransactionsFromLocalJson());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kobiPayBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.kobiPayBlack,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Icon(Icons.chevron_left_rounded, size: 30),
        ),
        centerTitle: true,
        title: Text(
          'History',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actionsPadding: EdgeInsets.only(right: 40),
        actions: [Icon(Icons.more_vert_rounded)],
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            final transactions = state.transactions;
            return Padding(
              padding: const EdgeInsets.fromLTRB(35, 5, 35, 2),
              child: Column(
                children: [
                  NetflixImage(
                    width: 15,
                    height: 30,
                    padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Netflix',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Production Company',
                    style: GoogleFonts.poppins(
                      color: AppColors.kobiPayDarkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total payment',
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
                                  '897.90',
                                  style: GoogleFonts.hammersmithOne(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Baseline(
                                baseline: 25,
                                baselineType: TextBaseline.alphabetic,
                                child: DollarImage(width: 25, height: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.kobiPayWhite,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'May',
                                style: GoogleFonts.poppins(
                                  color: AppColors.kobiPayDarkGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_rounded),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          duration: const Duration(milliseconds: 550),
                          curve: Curves.easeOut,
                          PieChartData(
                            centerSpaceRadius: 75,
                            sectionsSpace: 2,
                            startDegreeOffset: 80,
                            pieTouchData: PieTouchData(
                              touchCallback: (
                                FlTouchEvent event,
                                pieTouchResponse,
                              ) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex =
                                      pieTouchResponse
                                          .touchedSection!
                                          .touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(show: false),
                            sections: getSections(),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Baseline(
                                  baseline: 30,
                                  baselineType: TextBaseline.alphabetic,
                                  child: Text(
                                    '897.90',
                                    style: GoogleFonts.hammersmithOne(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Baseline(
                                  baseline: 30,
                                  baselineType: TextBaseline.alphabetic,
                                  child: DollarImage(width: 25, height: 20),
                                ),
                              ],
                            ),
                            Text(
                              "Netflix Expenses",
                              style: GoogleFonts.poppins(
                                color: AppColors.kobiPayDarkGrey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Transaction',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      itemCount: transactions.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // go to transaction detail page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return KobiPayDetailPage(
                                    transactionDetail:
                                        KobiPayTrasanctionDetail.toTrasanctionDetail(
                                          transactions[index],
                                        ),
                                  );
                                },
                              ),
                            );
                          },
                          child: KobiPayTransactionCard(
                            transaction: transactions[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is TransactionError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No transactions found.'));
          }
        },
      ),
    );
  }

  //pie chart sections
  List<PieChartSectionData> getSections() {
    return List.generate(6, (index) {
      final bool isTouched = index == touchedIndex;
      final radius = isTouched ? 80.0 : 50.0;
      switch (index) {
        case 0:
          return PieChartSectionData(
            color: AppColors.kobiPayPurple,
            value: 50,
            showTitle: false,
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.kobiPayTeal,
            showTitle: false,
            value: 5,
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.kobiPayLavender,
            value: 19,
            radius: radius,
            showTitle: false,
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.kobiPayPeach,
            value: 5,
            showTitle: false,
            radius: radius,
          );
        case 4:
          return PieChartSectionData(
            color: AppColors.kobiPayMint,
            value: 20,
            radius: radius,
            showTitle: false,
          );
        case 5:
          return PieChartSectionData(
            color: AppColors.kobiPayBlue,
            value: 3,
            showTitle: false,
            radius: radius,
          );
        default:
          throw Exception('Invalid index: $index');
      }
    });
  }
}
