import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final String? prefixText;
  final IconData? prefixIcon;
  final Widget? suffix;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.prefixText,
    this.prefixIcon,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!.toUpperCase(),
              style: AppTextStyles.labelBold
                  .copyWith(color: AppColors.onSurfaceVariant)),
          const SizedBox(height: AppSpacing.xs),
        ],
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: obscureText ? 1 : maxLines,
          style: AppTextStyles.bodyMd,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefixText,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 20, color: AppColors.outline)
                : null,
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}