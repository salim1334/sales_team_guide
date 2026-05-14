import 'package:flutter/material.dart';
import 'package:alarm_sales_guide/data/models/call_script_model.dart';
import 'package:alarm_sales_guide/utils/constants/colors.dart';
import 'package:alarm_sales_guide/utils/constants/sizes.dart';
import 'package:clipboard/clipboard.dart';
import 'package:alarm_sales_guide/utils/helpers/helper_functions.dart';

class ScriptCard extends StatelessWidget {
  const ScriptCard({
    super.key,
    required this.script,
  });

  final CallScriptModel script;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (script.tag.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(bottom: AppSizes.sm),
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: AppSizes.xs),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  script.tag,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.onSecondaryContainer),
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    script.bodyAm,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                IconButton(
                  onPressed: () {
                    FlutterClipboard.copy(script.bodyAm).then((value) {
                      THelperFunctions.showSnackBar('Copied', 'Script copied to clipboard');
                    });
                  },
                  icon: const Icon(Icons.copy, size: AppSizes.iconSm, color: AppColors.outline),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
