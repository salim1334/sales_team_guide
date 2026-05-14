import 'package:alarm_sales_guide/features/onboarding/controllers/onboarding_controller.dart';
import 'package:alarm_sales_guide/features/onboarding/services/onboarding_service.dart';
import 'package:alarm_sales_guide/routes/routes.dart';
import 'package:alarm_sales_guide/utils/constants/colors.dart';
import 'package:alarm_sales_guide/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final controller = Get.put(OnboardingController());

  static final List<_OnboardingStep> steps = [
    _OnboardingStep(
      title: 'Welcome',
      subtitle: 'Learn how to use the app quickly with a short walkthrough.',
      icon: Icons.auto_awesome_outlined,
    ),
    _OnboardingStep(
      title: 'Live Call Guide',
      subtitle:
          'Open call scripts grouped by category and follow them step-by-step.',
      icon: Icons.phone_in_talk_outlined,
    ),
    _OnboardingStep(
      title: 'Ad Templates',
      subtitle:
          'Browse campaigns by category and use the template text for your outreach.',
      icon: Icons.campaign_outlined,
    ),
    _OnboardingStep(
      title: 'Settings',
      subtitle: 'Adjust theme and text size so the app fits your preferences.',
      icon: Icons.settings_outlined,
    ),
  ];

  Future<void> _finish() async {
    await Get.put(OnboardingService()).setSeen();
    Get.offAllNamed(AppRoutes.adTemplate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
        actions: [
          TextButton(
            onPressed: _finish,
            child: const Text('Skip'),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          final idx = controller.stepIndex.value;
          final step = steps[idx];

          return Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            step.icon,
                            size: 44,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: AppSizes.md),
                        Text(
                          step.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSizes.sm),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.md,
                          ),
                          child: Text(
                            step.subtitle,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    steps.length,
                    (i) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: idx == i ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: idx == i
                            ? AppColors.primary
                            : AppColors.outlineVariant,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.md),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: controller.stepIndex.value == 0
                            ? null
                            : () => controller.back(),
                        child: const Text('Back'),
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (controller.stepIndex.value == steps.length - 1) {
                            await _finish();
                          } else {
                            controller.next();
                          }
                        },
                        child: Text(
                          controller.stepIndex.value == steps.length - 1
                              ? 'Finish'
                              : 'Next',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _OnboardingStep {
  final String title;
  final String subtitle;
  final IconData icon;

  const _OnboardingStep({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

