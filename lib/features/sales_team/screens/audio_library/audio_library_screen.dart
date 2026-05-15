import 'package:alarm_sales_guide/common/layouts/navigation_drawer_layout.dart';
import 'package:alarm_sales_guide/features/audio/controllers/audio_library_controller.dart';
import 'package:alarm_sales_guide/features/audio/data/models/audio_track.dart';
import 'package:alarm_sales_guide/features/audio/widgets/audio_card.dart';
import 'package:alarm_sales_guide/features/audio/widgets/mini_player.dart';
import 'package:alarm_sales_guide/utils/constants/colors.dart';
import 'package:alarm_sales_guide/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AudioLibraryScreen extends StatelessWidget {
  AudioLibraryScreen({super.key});

  final controller = Get.put(AudioLibraryController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AudioCategory.values.length,
      child: NavigationDrawerLayout(
        title: 'Audio Library',
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return _ErrorState(
              message: controller.errorMessage.value,
              onRetry: controller.loadTracks,
            );
          }

          return Column(
            children: [
              // Tab bar sits just below the app bar
              TabBar(
                tabs: AudioCategory.values
                    .map((c) => Tab(text: c.label))
                    .toList(),
                labelStyle: Theme.of(context).textTheme.labelLarge,
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.onSurfaceVariant,
              ),

              // Tab content
              Expanded(
                child: TabBarView(
                  children: AudioCategory.values
                      .map(
                        (c) => _TrackList(category: c, controller: controller),
                      )
                      .toList(),
                ),
              ),

              // Mini player floats above the bottom nav bar
              const MiniPlayer(),
            ],
          );
        }),
      ),
    );
  }
}

class _TrackList extends StatelessWidget {
  final AudioCategory category;
  final AudioLibraryController controller;

  const _TrackList({required this.category, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tracks = controller.tracksForCategory(category);

      if (tracks.isEmpty) return _EmptyState(category: category);

      return ListView.builder(
        // Extra bottom padding so the mini player never covers the last card
        padding: const EdgeInsets.fromLTRB(
          AppSizes.md,
          AppSizes.md,
          AppSizes.md,
          120,
        ),
        itemCount: tracks.length,
        itemBuilder: (_, i) => AudioCard(track: tracks[i]),
      );
    });
  }
}

class _EmptyState extends StatelessWidget {
  final AudioCategory category;
  const _EmptyState({required this.category});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Iconsax.music,
              size: 56,
              color: AppColors.outlineVariant,
            ),
            const SizedBox(height: AppSizes.md),
            Text(
              'No ${category.label} yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.sm),
            Text(
              'Your admin will upload audio tracks here.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Iconsax.warning_2, size: 48, color: AppColors.error),
            const SizedBox(height: AppSizes.md),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSizes.md),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
