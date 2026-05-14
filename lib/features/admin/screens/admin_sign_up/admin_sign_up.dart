import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alarm_sales_guide/utils/constants/sizes.dart';
import 'package:alarm_sales_guide/utils/constants/text_strings.dart';

class AdminSignUpScreen extends StatelessWidget {
  const AdminSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.security, size: 48, color: colorScheme.primary),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                'Create Administrator',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                'Sign up is currently disabled. Please contact system admin.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  AppTexts.backToLogin,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: colorScheme.secondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}