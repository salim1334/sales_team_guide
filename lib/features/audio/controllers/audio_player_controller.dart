import 'package:alarm_sales_guide/features/audio/data/models/audio_track.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

enum AppPlayerState { idle, loading, playing, paused, completed, error }

/// Single global audio player registered as a permanent GetX service.
///
/// Register once in main():
///   Get.put(AudioPlayerController(), permanent: true);
///
/// Any widget reads state via Get.find<AudioPlayerController>().
class AudioPlayerController extends GetxController {
  final _player = AudioPlayer();

  // ─── Observable state ─────────────────────────────────────────

  final Rx<AudioTrack?> currentTrack = Rx(null);
  final Rx<AppPlayerState> playerState = Rx(AppPlayerState.idle);
  final Rx<Duration> position = Rx(Duration.zero);
  final Rx<Duration> duration = Rx(Duration.zero);
  final RxString errorMessage = ''.obs;

  // ─── Derived helpers ──────────────────────────────────────────

  bool get isPlaying => playerState.value == AppPlayerState.playing;
  bool get isLoading => playerState.value == AppPlayerState.loading;
  bool get hasTrack => currentTrack.value != null;

  double get progress {
    final total = duration.value.inMilliseconds;
    if (total == 0) return 0;
    return (position.value.inMilliseconds / total).clamp(0.0, 1.0);
  }

  bool isCurrentTrack(AudioTrack track) => currentTrack.value?.id == track.id;

  // ─── Lifecycle ────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    _subscribeToStreams();
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }

  // ─── Public API ───────────────────────────────────────────────

  /// Loads [track] and starts playback.
  /// If [track] is already loaded, toggles play/pause instead.
  Future<void> play(AudioTrack track) async {
    if (isCurrentTrack(track)) {
      await togglePlayPause();
      return;
    }

    try {
      playerState.value = AppPlayerState.loading;
      currentTrack.value = track;
      errorMessage.value = '';

      await _player.stop();

      final source = track.isRemote
          ? AudioSource.uri(Uri.parse(track.filePath))
          : AudioSource.uri(Uri.file(track.filePath));

      final actual = await _player.setAudioSource(source);
      duration.value = actual ?? Duration(seconds: track.durationSeconds);

      await _player.play();
    } catch (_) {
      playerState.value = AppPlayerState.error;
      errorMessage.value = 'Could not load audio. Please try again.';
    }
  }

  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> seekTo(Duration pos) => _player.seek(pos);

  Future<void> skip(int seconds) async {
    final next = _player.position + Duration(seconds: seconds);
    final clamped = next < Duration.zero
        ? Duration.zero
        : next > duration.value
        ? duration.value
        : next;
    await seekTo(clamped);
  }

  Future<void> stop() async {
    await _player.stop();
    currentTrack.value = null;
    position.value = Duration.zero;
    duration.value = Duration.zero;
    playerState.value = AppPlayerState.idle;
  }

  /// Probes a file's duration without affecting the active player.
  /// Used when the admin uploads a new track.
  Future<int> getDurationSeconds(String filePath) async {
    final probe = AudioPlayer();
    try {
      final source = filePath.startsWith('http')
          ? AudioSource.uri(Uri.parse(filePath))
          : AudioSource.uri(Uri.file(filePath));
      final d = await probe.setAudioSource(source);
      return d?.inSeconds ?? 0;
    } finally {
      await probe.dispose();
    }
  }

  // ─── Stream subscriptions ─────────────────────────────────────

  void _subscribeToStreams() {
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playerState.value = AppPlayerState.completed;
        position.value = duration.value;
      } else if (state.playing) {
        playerState.value = AppPlayerState.playing;
      } else if (state.processingState == ProcessingState.loading ||
          state.processingState == ProcessingState.buffering) {
        playerState.value = AppPlayerState.loading;
      } else if (currentTrack.value != null) {
        playerState.value = AppPlayerState.paused;
      }
    });

    _player.positionStream.listen((p) => position.value = p);
    _player.durationStream.listen((d) {
      if (d != null) duration.value = d;
    });
  }
}
