import 'package:bai_tap_cuoi_ky/base/base_cache_image.dart';
import 'package:bai_tap_cuoi_ky/constants/spacing.dart';
import 'package:bai_tap_cuoi_ky/models/staff_entity.dart';
import 'package:flutter/material.dart';

import '../../../base/item_row.dart';
import '../../../constants/colors.dart';

class StaffCardView extends StatelessWidget {
  const StaffCardView({super.key, required this.staff});

  final StaffEntity staff;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(sp12),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.1),
            blurRadius: sp4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(sp16),
      margin: const EdgeInsets.all(sp16),
      child: Row(
        children: [
           Container(
            height: sp64,
            width: sp64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(sp12),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: BaseCacheImage(
              url: staff.avatar,
            ),
          ),
          gapWidth(sp16),
          Expanded(
            child: Column(
              children: [
                RowItem(
                  title: 'Tên',
                  content: staff.name,
                ),
                RowItem(
                  title: 'Email',
                  content: staff.email,
                ),
                RowItem(
                  title: 'Ngày sinh',
                  content: staff.dateOfBirth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
