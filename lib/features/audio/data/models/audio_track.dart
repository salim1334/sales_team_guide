// // lib/features/audio/data/models/audio_track.dart

// enum AudioCategory { salesStrategy, sampleConversation }

// class AudioTrack {
//   final int? id;
//   final String title;
//   final String? description;
//   final AudioCategory category;
//   final String filePath; // local: absolute path | future: URL
//   final int durationSeconds;
//   final int sortOrder;
//   final DateTime createdAt;

//   // This single field is what makes backend migration trivial:
//   // local file   → filePath = '/data/user/0/.../audio_123.mp3'
//   // future S3    → filePath = 'https://cdn.yourapp.com/audio_123.mp3'
//   // just_audio handles both with AudioSource.uri()
// }
