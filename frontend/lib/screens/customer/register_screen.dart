import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscure = true;

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
                  Text('JOIN FRESHMART',
                      style: AppTextStyles.h1
                          .copyWith(color: AppColors.primaryContainer)),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.surfaceVariant),
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        const AppTextField(hint: 'FULL NAME'),
                        const SizedBox(height: AppSpacing.gutter),
                        const AppTextField(
                          hint: 'EMAIL',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: AppSpacing.gutter),
                        const AppTextField(
                          hint: 'PHONE',
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: AppSpacing.gutter),
                        AppTextField(
                          hint: 'PASSWORD',
                          obscureText: _obscure,
                          suffix: IconButton(
                            icon: Icon(_obscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () => setState(() => _obscure = !_obscure),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.gutter),
                        const AppTextField(
                            hint: 'CONFIRM PASSWORD', obscureText: true),
                        const SizedBox(height: AppSpacing.md),
                        PrimaryButton(
                          label: 'Create Account',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text(
                                  'Registration UI only — TA excluded auth')),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('ALREADY HAVE AN ACCOUNT? LOGIN',
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