import 'package:alarm_sales_guide/features/audio/controllers/audio_player_controller.dart';
import 'package:alarm_sales_guide/features/audio/data/models/audio_track.dart';
import 'package:alarm_sales_guide/utils/constants/colors.dart';
import 'package:alarm_sales_guide/utils/constants/radii.dart';
import 'package:alarm_sales_guide/utils/constants/shadows.dart';
import 'package:alarm_sales_guide/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

/// Reusable track row for both the sales library and admin list.
/// Tapping the card calls [AudioPlayerController.play].
class AudioCard extends StatelessWidget {
  final AudioTrack track;

  /// Shown only in the admin view — pass null to hide.
  final VoidCallback? onDelete;

  const AudioCard({super.key, required this.track, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final player = Get.find<AudioPlayerController>();
    final cs = Theme.of(context).colorScheme;

    return Obx(() {
      final isCurrent = player.isCurrentTrack(track);
      final isPlaying = isCurrent && player.isPlaying;
      final isLoading = isCurrent && player.isLoading;

      return GestureDetector(
        onTap: () => player.play(track),
        child: Container(
          margin: const EdgeInsets.only(bottom: AppSizes.sm),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.primaryContainer : isCurrent
                ? AppColors.primaryContainer
                : AppColors.surfaceContainerLowest,
            borderRadius: AppRadii.lg,
            border: Border.all(
              color: isDarkMode
                  ? AppColors.primaryContainer
                  : isCurrent ? AppColors.primary : AppColors.outlineVariant,
              width: isCurrent ? 1.5 : 1,
            ),
            boxShadow: AppShadows.cardShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Row(
              children: [
                // Play / pause button
                _PlayButton(
                  isPlaying: isPlaying,
                  isLoading: isLoading,
                  isCurrent: isCurrent,
                ),
                const SizedBox(width: AppSizes.md),

                // Track info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.title,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: isCurrent ? AppColors.onPrimary : cs.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (track.description != null &&
                          track.description!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          track.description!,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: isCurrent
                                    ? AppColors.onPrimaryContainer
                                    : cs.onSurfaceVariant,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (isCurrent) ...[
                        const SizedBox(height: AppSizes.sm),
                        Obx(
                          () => LinearProgressIndicator(
                            value: player.progress,
                            backgroundColor: AppColors.outlineVariant,
                            color: AppColors.inversePrimary,
                            borderRadius: AppRadii.full,
                            minHeight: 3,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: AppSizes.sm),

                // Duration + optional delete
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      track.formattedDuration,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isCurrent
                            ? AppColors.onPrimaryContainer
                            : cs.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (onDelete != null) ...[
                      const SizedBox(height: AppSizes.xs),
                      GestureDetector(
                        onTap: onDelete,
                        child: const Icon(
                          Iconsax.trash,
                          size: 18,
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _PlayButton extends StatelessWidget {
  final bool isPlaying;
  final bool isLoading;
  final bool isCurrent;

  const _PlayButton({
    required this.isPlaying,
    required this.isLoading,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isCurrent ? AppColors.primary : AppColors.surfaceContainerHigh,
        shape: BoxShape.circle,
      ),
      child: isLoading
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: isCurrent ? AppColors.onPrimary : AppColors.primary,
              ),
            )
          : Icon(
              isPlaying ? Iconsax.pause : Iconsax.play,
              size: 20,
              color: isCurrent ? AppColors.onPrimary : AppColors.primary,
            ),
    );
  }
}
