import 'package:alarm_sales_guide/common/layouts/navigation_drawer_layout.dart';
import 'package:alarm_sales_guide/features/sales_team/controllers/settings_controller.dart';
import 'package:alarm_sales_guide/utils/constants/colors.dart';
import 'package:alarm_sales_guide/utils/constants/sizes.dart';
import 'package:alarm_sales_guide/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return NavigationDrawerLayout(
      title: AppTexts.settings,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.palette_outlined,
                          color: isDark
                              ? AppColors.onPrimary
                              : AppColors.primary,
                        ),
                        const SizedBox(width: AppSizes.sm),
                        Text(
                          'Appearance',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const Divider(height: AppSizes.spaceBtwSections),
                    Obx(
                      () => Column(
                        children: [
                          RadioListTile<ThemeMode>(
                            title: const Text('System Default'),
                            value: ThemeMode.system,
                            groupValue: controller.themeMode.value,
                            onChanged: (val) => controller.setThemeMode(val!),
                            activeColor: isDark
                                ? AppColors.onPrimary
                                : AppColors.primary,
                          ),
                          RadioListTile<ThemeMode>(
                            title: const Text('Light Theme'),
                            value: ThemeMode.light,
                            groupValue: controller.themeMode.value,
                            onChanged: (val) => controller.setThemeMode(val!),
                            activeColor: isDark
                                ? AppColors.onPrimary
                                : AppColors.primary,
                          ),
                          RadioListTile<ThemeMode>(
                            title: const Text('Dark Theme'),
                            value: ThemeMode.dark,
                            groupValue: controller.themeMode.value,
                            onChanged: (val) => controller.setThemeMode(val!),
                            activeColor: isDark
                                ? AppColors.onPrimary
                                : AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwItems),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.text_fields_outlined,
                          color: isDark
                              ? AppColors.onPrimary
                              : AppColors.primary,
                        ),
                        const SizedBox(width: AppSizes.sm),
                        Text(
                          'Text Display',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const Divider(height: AppSizes.spaceBtwSections),
                    Obx(
                      () => Column(
                        children: [
                          RadioListTile<String>(
                            title: const Text('Small'),
                            value: 'small',
                            groupValue: controller.fontScale.value,
                            onChanged: (val) => controller.setFontScale(val!),
                            activeColor: isDark
                                ? AppColors.onPrimary
                                : AppColors.primary,
                          ),
                          RadioListTile<String>(
                            title: const Text('Medium (Default)'),
                            value: 'medium',
                            groupValue: controller.fontScale.value,
                            onChanged: (val) => controller.setFontScale(val!),
                            activeColor: isDark
                                ? AppColors.onPrimary
                                : AppColors.primary,
                          ),
                          RadioListTile<String>(
                            title: const Text('Large'),
                            value: 'large',
                            groupValue: controller.fontScale.value,
                            onChanged: (val) => controller.setFontScale(val!),
                            activeColor: isDark
                                ? AppColors.onPrimary
                                : AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
