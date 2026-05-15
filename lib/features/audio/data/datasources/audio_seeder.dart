/// Seeds initial audio tracks on first launch.
///
/// Uses DatabaseHelper.getSetting/updateSetting (exactly like OnboardingService)
/// so there is no need for shared_preferences.
///
/// HOW TO ADD YOUR AUDIO FILES:
/// 1. Drop .mp3/.aac files into  assets/audio/seed/
/// 2. They are already declared in pubspec.yaml under assets
/// 3. Uncomment the relevant entries in [_seed] below
library;

import 'package:alarm_sales_guide/data/local/db_helper.dart';
import 'package:alarm_sales_guide/features/audio/data/datasources/audio_file_storage.dart';
import 'package:alarm_sales_guide/features/audio/data/models/audio_track.dart';
import 'package:flutter/services.dart';

class AudioSeeder {
  AudioSeeder._();
  static final AudioSeeder instance = AudioSeeder._();

  static const _seededKey = 'audioDbSeededV1';

  /// Call once from main() after DatabaseHelper is ready.
  Future<void> seedIfNeeded() async {
    final value = await DatabaseHelper.instance.getSetting(_seededKey);
    if (value == 'true') return;

    final isEmpty = await DatabaseHelper.instance.isAudioTableEmpty();
    if (!isEmpty) {
      await DatabaseHelper.instance.updateSetting(_seededKey, 'true');
      return;
    }

    await _seed();
    await DatabaseHelper.instance.updateSetting(_seededKey, 'true');
  }

  Future<void> _seed() async {
    final rows = <Map<String, dynamic>?>[];

    // ── Sales Strategies ──────────────────────────────────────
    // Uncomment and fill in once you add your asset files:
    //
    rows.add(await _rowFromAsset(
      assetPath: 'assets/audio/seed/Door-to-door_sales.m4a',
      title: 'Opening the Door',
      description: 'How to start a cold call with confidence.',
      category: AudioCategory.salesStrategy,
      durationSeconds: 1753,
      sortOrder: 0,
    ));

    // ── Sample Conversations ───────────────────────────────────
    //
    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_1.mp3',
        title: 'Pro Insights: Audio #1',
        description: 'Door-to-Door recorded sample — Session #1',
        category: AudioCategory.sampleConversation,
        durationSeconds: 243,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_2.mp3',
        title: 'Pro Insights: Audio #2',
        description: 'Door-to-Door recorded sample — Session #2',
        category: AudioCategory.sampleConversation,
        durationSeconds: 158,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_3.mp3',
        title: 'Pro Insights: Audio #3',
        description: 'Door-to-Door recorded sample — Session #3',
        category: AudioCategory.sampleConversation,
        durationSeconds: 286,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_4.mp3',
        title: 'Pro Insights: Audio #4',
        description: 'Door-to-Door recorded sample — Session #4',
        category: AudioCategory.sampleConversation,
        durationSeconds: 114,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_5.mp3',
        title: 'Pro Insights: Audio #5',
        description: 'Door-to-Door recorded sample — Session #5',
        category: AudioCategory.sampleConversation,
        durationSeconds: 366,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_6.mp3',
        title: 'Pro Insights: Audio #6',
        description: 'Door-to-Door recorded sample — Session #6',
        category: AudioCategory.sampleConversation,
        durationSeconds: 191,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_7.mp3',
        title: 'Pro Insights: Audio #7',
        description: 'Door-to-Door recorded sample — Session #7',
        category: AudioCategory.sampleConversation,
        durationSeconds: 263,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_8.mp3',
        title: 'Pro Insights: Audio #8',
        description: 'Door-to-Door recorded sample — Session #8',
        category: AudioCategory.sampleConversation,
        durationSeconds: 137,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_9.mp3',
        title: 'Pro Insights: Audio #9',
        description: 'Door-to-Door recorded sample — Session #9',
        category: AudioCategory.sampleConversation,
        durationSeconds: 201,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_11.mp3',
        title: 'Pro Insights: Audio #11',
        description: 'Door-to-Door recorded sample — Session #11',
        category: AudioCategory.sampleConversation,
        durationSeconds: 49,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_12.mp3',
        title: 'Pro Insights: Audio #12',
        description: 'Door-to-Door recorded sample — Session #12',
        category: AudioCategory.sampleConversation,
        durationSeconds: 72,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_13.mp3',
        title: 'Pro Insights: Audio #13',
        description: 'Door-to-Door recorded sample — Session #13',
        category: AudioCategory.sampleConversation,
        durationSeconds: 174,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_14.mp3',
        title: 'Pro Insights: Audio #14',
        description: 'Door-to-Door recorded sample — Session #14',
        category: AudioCategory.sampleConversation,
        durationSeconds: 118,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_15.mp3',
        title: 'Pro Insights: Audio #15',
        description: 'Door-to-Door recorded sample — Session #15',
        category: AudioCategory.sampleConversation,
        durationSeconds: 234,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_16.mp3',
        title: 'Pro Insights: Audio #16',
        description: 'Door-to-Door recorded sample — Session #16',
        category: AudioCategory.sampleConversation,
        durationSeconds: 145,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_17.mp3',
        title: 'Pro Insights: Audio #17',
        description: 'Door-to-Door recorded sample — Session #17',
        category: AudioCategory.sampleConversation,
        durationSeconds: 88,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_18.mp3',
        title: 'Pro Insights: Audio #18',
        description: 'Door-to-Door recorded sample — Session #18',
        category: AudioCategory.sampleConversation,
        durationSeconds: 81,
        sortOrder: 0,
      ),
    );

    rows.add(
      await _rowFromAsset(
        assetPath: 'assets/audio/seed/audio_file_10.mp3',
        title: 'Pro Insights: Audio #10',
        description: 'Door-to-Door recorded sample — Session #10',
        category: AudioCategory.sampleConversation,
        durationSeconds: 312,
        sortOrder: 0,
      ),
    );

    if (rows.isNotEmpty) {
      await DatabaseHelper.instance.insertAudioTrackBatch(rows.whereType<Map<String, dynamic>>().toList());
    }
  }

  Future<Map<String, dynamic>?> _rowFromAsset({
    required String assetPath,
    required String title,
    String? description,
    required AudioCategory category,
    required int durationSeconds,
    required int sortOrder,
  }) async {
    try {
      final filename = assetPath.split('/').last;
      final bytes = await rootBundle.load(assetPath);
      final savedPath = await AudioFileStorage.instance.saveAudioBytes(
        bytes: bytes.buffer.asUint8List(),
        filename: filename,
      );

      return AudioTrack(
        title: title,
        description: description,
        category: category,
        filePath: savedPath,
        durationSeconds: durationSeconds,
        sortOrder: sortOrder,
        createdAt: DateTime.now(),
      ).toMap();
    } catch (e) {
      print('Error seeding asset \$assetPath: \$e');
      return null;
    }
  }
}