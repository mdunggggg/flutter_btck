import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/colors.dart';
import '../constants/spacing.dart';
import '../constants/text_style.dart';


class EmptyContainer extends StatelessWidget {
  const EmptyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(sp16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(sp12),
      ),
      child: Column(
        children: [
          Lottie.asset(
            'assets/jsons/empty.json',
          ),
          const SizedBox(height: sp24),
          Text(
            'Danh sách rỗng',
            style: p1.copyWith(color: greyColor),
          ),
        ],
      ),
    );
  }
}

