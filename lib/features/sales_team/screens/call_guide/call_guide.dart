import 'package:alarm_sales_guide/common/layouts/navigation_drawer_layout.dart';
import 'package:alarm_sales_guide/common/widgets/cards/script_card.dart';
import 'package:alarm_sales_guide/features/sales_team/controllers/call_guide_controller.dart';
import 'package:alarm_sales_guide/utils/constants/sizes.dart';
import 'package:alarm_sales_guide/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallGuide extends StatelessWidget {
  CallGuide({super.key});

  final controller = Get.put(CallGuideController());

  @override
  Widget build(BuildContext context) {
    return NavigationDrawerLayout(
      title: AppTexts.liveCallGuide,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.scriptGroups.isEmpty) {
          return const Center(child: Text('No call scripts available.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppSizes.md),
          itemCount: controller.scriptGroups.length,
          itemBuilder: (context, index) {
            final group = controller.scriptGroups[index];
            final scripts = controller.scriptsByGroup[group.id!] ?? [];
            final isExpanded =
                controller.expandedState[group.id!]?.value ?? false;
            final colorScheme = Theme.of(context).colorScheme;

            return Card(
              margin: const EdgeInsets.only(bottom: AppSizes.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                side: BorderSide(
                  color: isExpanded ? colorScheme.primary : colorScheme.primary,
                ),
                // side: BorderSide(color: isExpanded ? colorScheme.primary : Colors.transparent),
              ),
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  key: ValueKey('group-${group.id}-$isExpanded'),
                  initiallyExpanded: isExpanded,
                  onExpansionChanged: (expanded) =>
                      controller.setExpansion(group.id!, expanded),
                  leading: CircleAvatar(
                    backgroundColor: isExpanded
                        ? colorScheme.primary
                        : colorScheme.primary,
                    // backgroundColor: isExpanded ? colorScheme.primary : colorScheme.surfaceContainerHighest,
                    radius: 16,
                    child: Text(
                      group.icon,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isExpanded
                            ? colorScheme.onPrimary
                            : colorScheme.onPrimary,
                        // color: isExpanded ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isExpanded
                              ? colorScheme.primary
                              : colorScheme.primary,
                          // color: isExpanded ? colorScheme.primary : colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        group.titleAm,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.md,
                        vertical: AppSizes.sm,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: scripts
                            .map((script) => ScriptCard(script: script))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
