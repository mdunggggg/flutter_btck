import 'package:bai_tap_cuoi_ky/base/base_cache_image.dart';
import 'package:bai_tap_cuoi_ky/constants/spacing.dart';
import 'package:bai_tap_cuoi_ky/models/staff_entity.dart';
import 'package:flutter/material.dart';

import '../../../base/item_row.dart';

class StaffCardView extends StatelessWidget {
  const StaffCardView({super.key, required this.staff});

  final StaffEntity staff;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          margin: const EdgeInsets.symmetric(vertical: sp16),
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
        )
      ],
    );
  }
}
