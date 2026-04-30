import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String text;
  const SectionHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.gutter),
    child: Text(text.toUpperCase(),
        style: AppTextStyles.labelBold
            .copyWith(color: AppColors.primaryContainer)),
  );
}