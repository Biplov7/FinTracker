import 'package:fintracker/core/theme/app_radius.dart';
import 'package:fintracker/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color txtColor;
  final Widget? icon;
  final VoidCallback? onPressed;
  const MyButton({
    super.key,
    required this.text,
    required this.color,
    required this.txtColor,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.xxl,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 4,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
        ),
        child: icon == null
            ? Text(text, style: TextStyle(color: txtColor))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  const SizedBox(width: AppSpacing.md),
                  Text(text, style: TextStyle(color: txtColor)),
                ],
              ),
      ),
    );
  }
}

