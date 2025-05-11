import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kobipay_fe/consts.dart';

class NetflixImage extends StatelessWidget {
  final EdgeInsets padding;
  final double width;
  final double height;
  const NetflixImage({
    super.key,
    required this.width,
    required this.height,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF101010),
      ),
      child: SvgPicture.asset(
        kobiPayTransactionIcon,
        colorFilter: ColorFilter.mode(AppColors.kobiPayRed, BlendMode.srcIn),
        height: height,
        width: width,
      ),
    );
  }
}
