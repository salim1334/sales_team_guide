import 'package:alarm_sales_guide/common/widgets/app_bar/custom_app_bar.dart';
import 'package:alarm_sales_guide/features/audio/controllers/audio_management_controller.dart';
import 'package:alarm_sales_guide/features/audio/data/models/audio_track.dart';
import 'package:alarm_sales_guide/features/audio/widgets/audio_card.dart';
import 'package:alarm_sales_guide/utils/constants/colors.dart';
import 'package:alarm_sales_guide/utils/constants/radii.dart';
import 'package:alarm_sales_guide/utils/constants/sizes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AudioManagementScreen extends StatelessWidget {
  AudioManagementScreen({super.key});

  final controller = Get.put(AudioManagementController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Manage Audio',
        showBackArrow: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.add_circle),
            tooltip: 'Upload track',
            onPressed: () => _showUploadSheet(context),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.allTracks.isEmpty) {
          return _EmptyState(onUpload: () => _showUploadSheet(context));
        }

        return ListView(
          padding: const EdgeInsets.all(AppSizes.md),
          children: AudioCategory.values
              .map(
                (cat) => _CategorySection(
                  category: cat,
                  tracks: controller.tracksByCategory(cat),
                  onDelete: (track) => _confirmDelete(context, track),
                ),
              )
              .toList(),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showUploadSheet(context),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        icon: const Icon(Iconsax.music),
        label: const Text('Upload Audio'),
      ),
    );
  }

  void _showUploadSheet(BuildContext context) {
    Get.bottomSheet(
      _UploadSheet(controller: controller),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _confirmDelete(BuildContext context, AudioTrack track) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete track?'),
        content: Text('"${track.title}" will be permanently removed.'),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteTrack(track);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Category section ───────────────────────────────────────────────────────

class _CategorySection extends StatelessWidget {
  final AudioCategory category;
  final List<AudioTrack> tracks;
  final void Function(AudioTrack) onDelete;

  const _CategorySection({
    required this.category,
    required this.tracks,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
          child: Row(
            children: [
              Text(
                category.label,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: AppSizes.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: AppRadii.full,
                ),
                child: Text(
                  '${tracks.length}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (tracks.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.md),
            child: Text(
              'No tracks yet. Tap Upload Audio to add one.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          )
        else
          ...tracks.map(
            (t) => AudioCard(track: t, onDelete: () => onDelete(t)),
          ),
        const SizedBox(height: AppSizes.md),
      ],
    );
  }
}

// ── Upload bottom sheet ────────────────────────────────────────────────────

class _UploadSheet extends StatefulWidget {
  final AudioManagementController controller;
  const _UploadSheet({required this.controller});

  @override
  State<_UploadSheet> createState() => _UploadSheetState();
}

class _UploadSheetState extends State<_UploadSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AudioCategory _category = AudioCategory.salesStrategy;
  PlatformFile? _pickedFile;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(AppSizes.md),
      padding: EdgeInsets.fromLTRB(
        AppSizes.md,
        AppSizes.md,
        AppSizes.md,
        AppSizes.md + bottomInset,
      ),
      decoration: BoxDecoration(color: cs.surface, borderRadius: AppRadii.xl),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upload Audio',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(Iconsax.close_circle),
                    onPressed: Get.back,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.md),

              // File picker
              _FilePicker(pickedFile: _pickedFile, onPick: _pickFile),
              const SizedBox(height: AppSizes.md),

              // Title field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title *',
                  hintText: 'e.g. Handling Objections',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Title is required'
                    : null,
              ),
              const SizedBox(height: AppSizes.md),

              // Description field
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: AppSizes.md),

              // Category picker
              Text('Category', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: AppSizes.xs),
              _CategoryPicker(
                selected: _category,
                onChanged: (c) => setState(() => _category = c),
              ),
              const SizedBox(height: AppSizes.lg),

              // Submit button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: AppSizes.buttonHeight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppRadii.defaultRadius,
                      ),
                      elevation: AppSizes.buttonElevation,
                    ),
                    onPressed: widget.controller.isUploading.value
                        ? null
                        : _submit,
                    child: widget.controller.isUploading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.onPrimary,
                            ),
                          )
                        : const Text('Upload Track'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    final file = await widget.controller.pickAudioFile();
    if (file != null) setState(() => _pickedFile = file);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_pickedFile == null) {
      Get.snackbar('No file', 'Please pick an audio file first.');
      return;
    }

    final success = await widget.controller.uploadTrack(
      title: _titleController.text.trim(),
      description: _descController.text.trim().isEmpty
          ? null
          : _descController.text.trim(),
      category: _category,
      pickedFile: _pickedFile!,
    );

    if (success) Get.back();
  }
}

// ── Helper sub-widgets ─────────────────────────────────────────────────────

class _FilePicker extends StatelessWidget {
  final PlatformFile? pickedFile;
  final VoidCallback onPick;
  const _FilePicker({required this.pickedFile, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: AppRadii.lg,
          border: Border.all(
            color: pickedFile != null
                ? AppColors.secondary
                : AppColors.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Icon(
              pickedFile != null ? Iconsax.music : Iconsax.folder_open,
              color: pickedFile != null
                  ? AppColors.secondary
                  : AppColors.onSurfaceVariant,
            ),
            const SizedBox(width: AppSizes.sm),
            Expanded(
              child: Text(
                pickedFile?.name ?? 'Tap to select audio file',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: pickedFile != null
                      ? AppColors.onSurface
                      : AppColors.onSurfaceVariant,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (pickedFile != null)
              const Icon(
                Iconsax.tick_circle,
                color: AppColors.secondary,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}

class _CategoryPicker extends StatelessWidget {
  final AudioCategory selected;
  final ValueChanged<AudioCategory> onChanged;
  const _CategoryPicker({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: AudioCategory.values.map((cat) {
        final isSelected = selected == cat;
        final isLast = cat == AudioCategory.values.last;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: EdgeInsets.only(right: isLast ? 0 : AppSizes.sm),
              padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryContainer
                    : AppColors.surfaceContainerLow,
                borderRadius: AppRadii.defaultRadius,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.outlineVariant,
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Text(
                cat.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isSelected
                      ? AppColors.onPrimary
                      : AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onUpload;
  const _EmptyState({required this.onUpload});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Iconsax.music_play,
              size: 64,
              color: AppColors.outlineVariant,
            ),
            const SizedBox(height: AppSizes.md),
            Text(
              'No audio tracks yet',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSizes.sm),
            Text(
              'Upload your first track to get started.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.lg),
            ElevatedButton.icon(
              onPressed: onUpload,
              icon: const Icon(Iconsax.music),
              label: const Text('Upload Audio'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
