import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/spacing.dart';
import '../constants/text_style.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.title,
    this.event,
    this.largeButton = true,
    this.icon,
  });

  final String? title;
  final Function()? event;
  final bool largeButton;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        padding: EdgeInsets.symmetric(
          vertical: largeButton ? sp16 : sp8,
          horizontal: largeButton ? sp16 : 0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sp12),
        ),
      ),
      onPressed: () {
        event?.call();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          if (icon != null && title != null) const SizedBox(width: sp8),
          if (title != null)
            Text(
              title ?? '',
              style: (largeButton ? h6 : p5).copyWith(color: whiteColor),
            ),
        ],
      ),
    );
  }
}

class ExtraButton extends StatelessWidget {
  const ExtraButton({
    super.key,
    this.title,
    this.event,
    this.largeButton = true,
    this.borderColor,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  final String? title;
  final Function()? event;
  final bool largeButton;
  final Color? borderColor;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? const Color.fromARGB(0, 0, 0, 0),
        padding: EdgeInsets.symmetric(
          vertical: largeButton ? sp16 : sp8,
          horizontal: largeButton ? sp16 : sp12,
        ),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(sp12)),
        side: BorderSide(color: borderColor ?? borderColor_2, width: 1),
      ),
      onPressed: () {
        event?.call();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          if (icon != null && title != null) const SizedBox(width: sp8),
          if (title != null)
            Text(
              title ?? '',
              style: (largeButton ? h6 : p5).copyWith(color: textColor ?? blackColor),
            ),
        ],
      ),
    );
  }
}
