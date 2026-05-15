import 'package:alarm_sales_guide/features/audio/data/models/audio_track.dart';
import 'package:alarm_sales_guide/features/audio/data/repositories/audio_repository.dart';
import 'package:get/get.dart';

class AudioLibraryController extends GetxController {
  final _repo = AudioRepository.instance;

  final RxList<AudioTrack> salesStrategyTracks = <AudioTrack>[].obs;
  final RxList<AudioTrack> sampleConversationTracks = <AudioTrack>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadTracks();
  }

  Future<void> loadTracks() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final results = await Future.wait([
        _repo.getTracksByCategory(AudioCategory.salesStrategy),
        _repo.getTracksByCategory(AudioCategory.sampleConversation),
      ]);

      salesStrategyTracks.assignAll(results[0]);
      sampleConversationTracks.assignAll(results[1]);
    } catch (_) {
      errorMessage.value = 'Failed to load audio tracks.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> reload() => loadTracks();

  List<AudioTrack> tracksForCategory(AudioCategory category) {
    return switch (category) {
      AudioCategory.salesStrategy => salesStrategyTracks,
      AudioCategory.sampleConversation => sampleConversationTracks,
    };
  }
}
