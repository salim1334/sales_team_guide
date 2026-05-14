import 'package:flutter/material.dart';
import 'package:alarm_sales_guide/data/models/ad_template_model.dart';
import 'package:alarm_sales_guide/utils/constants/sizes.dart';
import 'package:clipboard/clipboard.dart';
import 'package:alarm_sales_guide/utils/helpers/helper_functions.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard({
    super.key,
    required this.template,
  });

  final AdTemplateModel template;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: AppSizes.sm),
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: AppSizes.xs),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                'DAY ${template.dayNumber}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Text(
              template.bodyAm,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSizes.md),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  elevation: 0,
                ),
                onPressed: () {
                  FlutterClipboard.copy(template.bodyAm).then((value) {
                    THelperFunctions.showSnackBar('Copied', 'Template copied to clipboard');
                  });
                },
                icon: const Icon(Icons.copy, size: AppSizes.iconSm),
                label: const Text('Copy to Clipboard'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
