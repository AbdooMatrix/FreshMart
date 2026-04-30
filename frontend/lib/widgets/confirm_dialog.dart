import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Reusable destructive confirmation dialog (used for product delete).
class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;

  const ConfirmDialog({
    super.key,
    this.title = 'DELETE PRODUCT?',
    this.message = 'Are you sure? This cannot be undone.',
    this.confirmText = 'DELETE',
    this.cancelText = 'CANCEL',
  });

  static Future<bool> show(BuildContext context, {
    String title = 'DELETE PRODUCT?',
    String message = 'Are you sure? This cannot be undone.',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => ConfirmDialog(title: title, message: message),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64, height: 64,
              decoration: const BoxDecoration(
                color: AppColors.errorContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.warning,
                  color: AppColors.error, size: 32),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: AppTextStyles.h2),
            const SizedBox(height: AppSpacing.xs),
            Text(message,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMd
                    .copyWith(color: AppColors.onSurfaceVariant)),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.outline),
                      foregroundColor: AppColors.onSurfaceVariant,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                    ),
                    child: Text(cancelText, style: AppTextStyles.buttonText
                        .copyWith(color: AppColors.onSurfaceVariant)),
                  ),
                ),
                const SizedBox(width: AppSpacing.gutter),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: AppColors.onError,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                    ),
                    child: Text(confirmText, style: AppTextStyles.buttonText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}