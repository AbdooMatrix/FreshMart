import 'package:flutter/material.dart';
import '../../config/session.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  // ───── Brand Header ─────
                  Container(
                    width: 64, height: 64,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.shopping_cart, color: Colors.white, size: 32),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text('FRESHMART',
                      style: AppTextStyles.h1.copyWith(color: AppColors.primaryContainer)),
                  Text('Fresh groceries at your doorstep',
                      style: AppTextStyles.bodyMd.copyWith(color: AppColors.outline)),
                  const SizedBox(height: AppSpacing.lg),

                  // ───── Login Card ─────
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.surfaceVariant),
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      boxShadow: const [
                        BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2)),
                      ],
                    ),
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        const AppTextField(label: 'Email', hint: 'customer@test.com', keyboardType: TextInputType.emailAddress),
                        const SizedBox(height: AppSpacing.md),
                        const AppTextField(label: 'Password', hint: '••••••••', obscureText: true),
                        const SizedBox(height: AppSpacing.md),

                        Text('CONTINUE AS', style: AppTextStyles.labelBold.copyWith(color: AppColors.onSurfaceVariant)),
                        const SizedBox(height: AppSpacing.sm),

                        // ───── 4 Role Buttons ─────
                        _RoleButton(
                          label: 'LOGIN AS CUSTOMER', icon: Icons.person,
                          background: AppColors.primaryContainer, foreground: AppColors.onPrimary,
                          filled: true,
                          onTap: () { Session.loginAsCustomer(); Navigator.pushReplacementNamed(context, '/home'); },
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _RoleButton(
                          label: 'LOGIN AS VENDOR', icon: Icons.storefront,
                          background: AppColors.surface, foreground: AppColors.primaryContainer,
                          filled: false, borderColor: AppColors.primaryContainer,
                          onTap: () { Session.loginAsVendor(); Navigator.pushReplacementNamed(context, '/vendor/products'); },
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _RoleButton(
                          label: 'LOGIN AS ADMIN', icon: Icons.admin_panel_settings,
                          background: AppColors.secondary, foreground: AppColors.onSecondary,
                          filled: true,
                          onTap: () { Session.loginAsAdmin(); Navigator.pushReplacementNamed(context, '/admin/dashboard'); },
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _RoleButton(
                          label: 'LOGIN AS DELIVERY', icon: Icons.delivery_dining,
                          background: AppColors.surface, foreground: AppColors.tertiary,
                          filled: false, borderColor: AppColors.tertiary,
                          onTap: () { Session.loginAsDelivery(); Navigator.pushReplacementNamed(context, '/delivery/dashboard'); },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: Text("DON'T HAVE AN ACCOUNT? REGISTER",
                        style: AppTextStyles.labelBold.copyWith(color: AppColors.primaryContainer)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable button row used 4× on the login screen.
class _RoleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
  final bool filled;
  final Color? borderColor;
  final VoidCallback onTap;

  const _RoleButton({
    required this.label, required this.icon,
    required this.background, required this.foreground,
    required this.filled, this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: 48,
      child: filled
          ? ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18, color: foreground),
        label: Text(label, style: AppTextStyles.buttonText.copyWith(color: foreground)),
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
          elevation: 0,
        ),
      )
          : OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18, color: foreground),
        label: Text(label, style: AppTextStyles.buttonText.copyWith(color: foreground)),
        style: OutlinedButton.styleFrom(
          backgroundColor: background,
          side: BorderSide(color: borderColor ?? foreground),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
        ),
      ),
    );
  }
}