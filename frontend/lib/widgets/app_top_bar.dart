import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Green header used on every screen.
/// - leading: usually a back arrow or menu icon (or null)
/// - trailing: optional action icon (e.g. cart)
///
/// FIX: preferredSize and the Container height now include the top
/// safe-area inset (status-bar height) so the bar never hides behind
/// the phone's pull-down notification area.
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

  /// 56 px of content + whatever the OS status bar consumes.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // 56 dp

  @override
  Widget build(BuildContext context) {
    // MediaQuery gives us the real status-bar height at runtime so the
    // bar is correctly padded on every device (notch, pill, classic bar).
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      height: preferredSize.height + topPadding,
      color: AppColors.primary,
      padding: EdgeInsets.only(
        top: topPadding,      // push content below the status bar
        left: 8,
        right: 8,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: leading ??
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title.toUpperCase(),
                style: AppTextStyles.h2.copyWith(color: AppColors.onPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(width: 48, child: trailing ?? const SizedBox.shrink()),
        ],
      ),
    );
  }
}