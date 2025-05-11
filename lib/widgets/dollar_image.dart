import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kobipay_fe/consts.dart';

class DollarImage extends StatelessWidget {
  final double width;
  final double height;
  const DollarImage({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      kobiPayDollarIcon,
      height: height,
      width: width,
      colorFilter: const ColorFilter.mode(
        AppColors.kobiPayPink,
        BlendMode.srcIn,
      ),
    );
  }
}
