import 'dart:io';
import 'package:alarm_sales_guide/data/local/db_helper.dart';
import 'package:alarm_sales_guide/features/audio/data/datasources/audio_file_storage.dart';
import 'package:alarm_sales_guide/features/audio/data/models/audio_track.dart';

/// The only class controllers import from the audio data layer.
/// Combines DatabaseHelper (metadata) and AudioFileStorage (files).
class AudioRepository {
  AudioRepository._();
  static final AudioRepository instance = AudioRepository._();

  final _db = DatabaseHelper.instance;
  final _storage = AudioFileStorage.instance;

  // ─── Queries ──────────────────────────────────────────────────

  Future<List<AudioTrack>> getAllTracks() async {
    final rows = await _db.getAudioTracks();
    return rows.map(AudioTrack.fromMap).toList();
  }

  Future<List<AudioTrack>> getTracksByCategory(AudioCategory category) async {
    final rows = await _db.getAudioTracks(category: category.dbValue);
    return rows.map(AudioTrack.fromMap).toList();
  }

  // ─── Mutations ────────────────────────────────────────────────

  /// Copies [audioFile] to disk, inserts a row, and returns the saved track.
  Future<AudioTrack> addTrack({
    required String title,
    String? description,
    required AudioCategory category,
    required File audioFile,
    required int durationSeconds,
  }) async {
    final filePath = await _storage.saveAudioFile(audioFile);
    final sortOrder = await _db.nextAudioSortOrder(category.dbValue);

    final track = AudioTrack(
      title: title,
      description: description,
      category: category,
      filePath: filePath,
      durationSeconds: durationSeconds,
      sortOrder: sortOrder,
      createdAt: DateTime.now(),
    );

    final id = await _db.insertAudioTrack(track.toMap());
    return track.copyWith(id: id);
  }

  Future<void> updateTrackMetadata(AudioTrack track) async {
    await _db.updateAudioTrack(track.id!, track.toMap());
  }

  /// Deletes both the SQLite row and the file on disk.
  Future<void> deleteTrack(AudioTrack track) async {
    await _db.deleteAudioTrack(track.id!);
    await _storage.deleteAudioFile(track.filePath);
  }

  // ─── Seeder helper ────────────────────────────────────────────

  Future<String> saveAudioBytes({
    required List<int> bytes,
    required String filename,
  }) => _storage.saveAudioBytes(bytes: bytes, filename: filename);
}
