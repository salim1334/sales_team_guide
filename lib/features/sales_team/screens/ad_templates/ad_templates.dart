import 'package:alarm_sales_guide/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alarm_sales_guide/common/layouts/navigation_drawer_layout.dart';
import 'package:alarm_sales_guide/common/widgets/cards/template_card.dart';
import 'package:alarm_sales_guide/features/sales_team/controllers/ad_template_controller.dart';
import 'package:alarm_sales_guide/utils/constants/sizes.dart';
import 'package:alarm_sales_guide/utils/constants/text_strings.dart';

class AdTemplates extends StatelessWidget {
  AdTemplates({super.key});

  final controller = Get.put(AdTemplateController());

  @override
  Widget build(BuildContext context) {
    return NavigationDrawerLayout(
      title: AppTexts.adTemplates,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.adGroups.isEmpty) {
          return const Center(child: Text('No ad templates available.'));
        }

        return Column(
          children: [
            // Group Selector Header
            Container(
              padding: const EdgeInsets.all(AppSizes.md),
              color: Theme.of(context).colorScheme.surface,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Campaign Category',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        isExpanded: true,
                        value: controller.selectedGroupIndex.value,
                        onChanged: (int? newValue) {
                          if (newValue != null) {
                            controller.selectGroup(newValue);
                          }
                        },
                        items: controller.adGroups.asMap().entries.map((entry) {
                          return DropdownMenuItem<int>(
                            value: entry.key,
                            child: Text(
                              entry.value.name,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Templates List
            Expanded(
              child: controller.currentTemplates.isEmpty
                  ? const Center(child: Text('No templates for this group.'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(AppSizes.md),
                      itemCount: controller.currentTemplates.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
                          child: TemplateCard(template: controller.currentTemplates[index]),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}