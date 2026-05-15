import 'package:alarm_sales_guide/features/audio/controllers/audio_player_controller.dart';
import 'package:alarm_sales_guide/utils/constants/colors.dart';
import 'package:alarm_sales_guide/utils/constants/radii.dart';
import 'package:alarm_sales_guide/utils/constants/shadows.dart';
import 'package:alarm_sales_guide/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

/// Persistent player bar shown at the bottom of the audio library screen.
/// Collapses completely (zero height) when no track is loaded.
class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final player = Get.find<AudioPlayerController>();

    return Obx(() {
      if (!player.hasTrack) return const SizedBox.shrink();

      final track = player.currentTrack.value!;

      return Container(
        margin: const EdgeInsets.fromLTRB(
          AppSizes.md,
          0,
          AppSizes.md,
          AppSizes.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: AppRadii.lg,
          boxShadow: AppShadows.modalShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Progress bar at top edge
            Obx(
              () => ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: LinearProgressIndicator(
                  value: player.progress,
                  backgroundColor: AppColors.primaryContainer,
                  color: AppColors.inversePrimary,
                  minHeight: 3,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.sm,
              ),
              child: Row(
                children: [
                  // Track info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          track.title,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: AppColors.onPrimary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Obx(
                          () => Text(
                            '${_fmt(player.position.value)} · ${track.formattedDuration}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.onPrimaryContainer),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Controls
                  Row(
                    children: [
                      _IconBtn(
                        icon: Iconsax.backward_15_seconds,
                        onTap: () => player.skip(-15),
                      ),
                      const SizedBox(width: AppSizes.xs),
                      _PlayPauseBtn(player: player),
                      const SizedBox(width: AppSizes.xs),
                      _IconBtn(
                        icon: Iconsax.forward_15_seconds,
                        onTap: () => player.skip(15),
                      ),
                      const SizedBox(width: AppSizes.xs),
                      _IconBtn(icon: Iconsax.close_circle, onTap: player.stop),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  String _fmt(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }
}

class _PlayPauseBtn extends StatelessWidget {
  final AudioPlayerController player;
  const _PlayPauseBtn({required this.player});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: player.togglePlayPause,
        child: Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: AppColors.onPrimary,
            shape: BoxShape.circle,
          ),
          child: player.isLoading
              ? const Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                )
              : Icon(
                  player.isPlaying ? Iconsax.pause : Iconsax.play,
                  size: 18,
                  color: AppColors.primary,
                ),
        ),
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: 22, color: AppColors.onPrimary),
    );
  }
}
