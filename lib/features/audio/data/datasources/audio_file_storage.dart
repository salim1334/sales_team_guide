import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Manages physical audio files on the device's documents directory.
/// Only this class reads/writes files — everything else works with paths.
class AudioFileStorage {
  AudioFileStorage._();
  static final AudioFileStorage instance = AudioFileStorage._();

  static const String _audioSubdir = 'audio';

  Future<Directory> get _audioDir async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(base.path, _audioSubdir));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  /// Copies [sourceFile] into the managed audio directory.
  /// Returns the absolute destination path to store in SQLite.
  Future<String> saveAudioFile(File sourceFile) async {
    final dir = await _audioDir;
    final ext = p.extension(sourceFile.path);
    final name = '${DateTime.now().millisecondsSinceEpoch}$ext';
    final dest = File(p.join(dir.path, name));
    await sourceFile.copy(dest.path);
    return dest.path;
  }

  /// Saves raw bytes (used by the seeder copying from assets).
  Future<String> saveAudioBytes({
    required List<int> bytes,
    required String filename,
  }) async {
    final dir = await _audioDir;
    final dest = File(p.join(dir.path, filename));
    await dest.writeAsBytes(bytes, flush: true);
    return dest.path;
  }

  /// Deletes the file at [filePath]. Silently ignores missing files.
  /// Never deletes remote URLs.
  Future<void> deleteAudioFile(String filePath) async {
    if (filePath.startsWith('http') || filePath.isEmpty) return;
    final file = File(filePath);
    if (await file.exists()) await file.delete();
  }

  Future<bool> fileExists(String filePath) async {
    if (filePath.startsWith('http')) return true;
    return File(filePath).exists();
  }
}
