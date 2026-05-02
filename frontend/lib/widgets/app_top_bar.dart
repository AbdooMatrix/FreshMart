import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;

  const AppTopBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      height: preferredSize.height + topPadding,
      color: AppColors.primary,
      padding: EdgeInsets.only(top: topPadding, left: 8, right: 8),
      child: Stack(
        children: [
          // Centered title across the full width
          Positioned.fill(
            child: Center(
              child: Text(
                title.toUpperCase(),
                style: AppTextStyles.h2.copyWith(color: AppColors.onPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Leading + trailing on top
          Row(
            children: [
              leading ??
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
              const Spacer(),
              trailing ?? const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}