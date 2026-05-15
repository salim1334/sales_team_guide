import 'dart:io';

import 'package:alarm_sales_guide/features/audio/controllers/audio_library_controller.dart';
import 'package:alarm_sales_guide/features/audio/controllers/audio_player_controller.dart';
import 'package:alarm_sales_guide/features/audio/data/models/audio_track.dart';
import 'package:alarm_sales_guide/features/audio/data/repositories/audio_repository.dart';
import 'package:alarm_sales_guide/utils/helpers/helper_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class AudioManagementController extends GetxController {
  final _repo = AudioRepository.instance;

  final RxList<AudioTrack> allTracks = <AudioTrack>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllTracks();
  }

  Future<void> loadAllTracks() async {
    try {
      isLoading.value = true;
      allTracks.assignAll(await _repo.getAllTracks());
    } catch (_) {
      THelperFunctions.showSnackBar(
        'Error',
        'Failed to load tracks.',
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  List<AudioTrack> tracksByCategory(AudioCategory category) =>
      allTracks.where((t) => t.category == category).toList();

  Future<PlatformFile?> pickAudioFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );
    return result?.files.firstOrNull;
  }

  Future<bool> uploadTrack({
    required String title,
    String? description,
    required AudioCategory category,
    required PlatformFile pickedFile,
  }) async {
    try {
      isUploading.value = true;

      final file = File(pickedFile.path!);
      final player = Get.find<AudioPlayerController>();
      final durationSeconds = await player.getDurationSeconds(file.path);

      final track = await _repo.addTrack(
        title: title,
        description: description,
        category: category,
        audioFile: file,
        durationSeconds: durationSeconds,
      );

      allTracks.add(track);
      _syncLibraryController();

      THelperFunctions.showSnackBar('Success', '${track.title} uploaded.');
      return true;
    } catch (_) {
      THelperFunctions.showSnackBar(
        'Error',
        'Upload failed. Please try again.',
        isError: true,
      );
      return false;
    } finally {
      isUploading.value = false;
    }
  }

  Future<void> deleteTrack(AudioTrack track) async {
    try {
      final player = Get.find<AudioPlayerController>();
      if (player.isCurrentTrack(track)) await player.stop();

      await _repo.deleteTrack(track);
      allTracks.remove(track);
      _syncLibraryController();

      THelperFunctions.showSnackBar('Success', '${track.title} deleted.');
    } catch (_) {
      THelperFunctions.showSnackBar(
        'Error',
        'Could not delete track.',
        isError: true,
      );
    }
  }

  void _syncLibraryController() {
    if (Get.isRegistered<AudioLibraryController>()) {
      Get.find<AudioLibraryController>().reload();
    }
  }
}
