import 'package:flutter/material.dart';
import '../../config/session.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  // Brand header
                  Container(
                    width: 64, height: 64,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.shopping_cart,
                        color: Colors.white, size: 32),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text('FRESHMART',
                      style: AppTextStyles.h1
                          .copyWith(color: AppColors.primaryContainer)),
                  Text('Fresh groceries at your doorstep',
                      style: AppTextStyles.bodyMd
                          .copyWith(color: AppColors.outline)),
                  const SizedBox(height: AppSpacing.xl),

                  // Login card
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.surfaceVariant),
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        const AppTextField(
                          label: 'Email',
                          hint: 'customer@test.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        const AppTextField(
                          label: 'Password',
                          hint: '••••••••',
                          obscureText: true,
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // Login as Customer
                        SizedBox(
                          width: double.infinity, height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Session.loginAsCustomer();
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryContainer,
                              foregroundColor: AppColors.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(AppRadius.xl),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('LOGIN AS CUSTOMER',
                                    style: AppTextStyles.buttonText),
                                const SizedBox(width: 6),
                                const Icon(Icons.arrow_forward, size: 18),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),

                        // Login as Vendor
                        SizedBox(
                          width: double.infinity, height: 48,
                          child: OutlinedButton(
                            onPressed: () {
                              Session.loginAsVendor();
                              Navigator.pushReplacementNamed(
                                  context, '/vendor/products');
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: AppColors.primaryContainer),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(AppRadius.xl),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('LOGIN AS VENDOR',
                                    style: AppTextStyles.buttonText.copyWith(
                                        color: AppColors.primaryContainer)),
                                const SizedBox(width: 6),
                                const Icon(Icons.arrow_forward,
                                    size: 18,
                                    color: AppColors.primaryContainer),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/register'),
                    child: Text("DON'T HAVE AN ACCOUNT? REGISTER",
                        style: AppTextStyles.labelBold
                            .copyWith(color: AppColors.primaryContainer)),
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