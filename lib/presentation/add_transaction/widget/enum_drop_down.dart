import 'package:fintracker/core/theme/app_radius.dart';
import 'package:fintracker/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EnumDropDown<T extends Enum> extends StatefulWidget {
  final T? value;
  final String labelText;
  final List<T> item;
  final Widget? prefixIcon;
  final IconData Function(T value)? itemIcon;
  final Color iconColor;
  final ValueChanged<T?>? onChanged;
  const EnumDropDown({
    super.key,
    required this.value,
    required this.labelText,
    required this.item,
    required this.prefixIcon,
    this.itemIcon,
    this.iconColor = AppColors.primary,
    required this.onChanged,
  });

  @override
  State<EnumDropDown<T>> createState() => _EnumDropDownState<T>();
}

class _EnumDropDownState<T extends Enum> extends State<EnumDropDown<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: widget.value,
      decoration: InputDecoration(
        hintText: widget.labelText,
        prefixIcon: widget.value != null && widget.itemIcon != null
            ? Icon(widget.itemIcon!(widget.value as T), color: widget.iconColor)
            : widget.prefixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
      items: widget.item.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(formatName(item.name)),
        );
      }).toList(),
      onChanged: widget.onChanged,
    );
  }
}

String formatName(String name) {
  if (name == 'esewa') {
    return 'eSewa';
  }

  return name
      .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
      .trim()
      .replaceFirstMapped(
        RegExp(r'^[a-z]'),
        (match) => match.group(0)!.toUpperCase(),
      );
}
