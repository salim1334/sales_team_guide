enum AudioCategory {
  salesStrategy,
  sampleConversation;

  String get label {
    switch (this) {
      case AudioCategory.salesStrategy:
        return 'Sales Strategies';
      case AudioCategory.sampleConversation:
        return 'Sample Conversations';
    }
  }

  /// Stable string persisted in SQLite — never rename these values.
  String get dbValue {
    switch (this) {
      case AudioCategory.salesStrategy:
        return 'sales_strategy';
      case AudioCategory.sampleConversation:
        return 'sample_conversation';
    }
  }

  static AudioCategory fromDbValue(String value) {
    return AudioCategory.values.firstWhere(
      (e) => e.dbValue == value,
      orElse: () => AudioCategory.salesStrategy,
    );
  }
}

class AudioTrack {
  final int? id;
  final String title;
  final String? description;
  final AudioCategory category;

  /// Absolute local path OR a remote URL — just_audio handles both via
  /// AudioSource.uri(), so switching to a backend requires no UI changes.
  final String filePath;

  final int durationSeconds;
  final int sortOrder;
  final DateTime createdAt;

  const AudioTrack({
    this.id,
    required this.title,
    this.description,
    required this.category,
    required this.filePath,
    required this.durationSeconds,
    required this.sortOrder,
    required this.createdAt,
  });

  String get formattedDuration {
    final m = durationSeconds ~/ 60;
    final s = durationSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  bool get isRemote =>
      filePath.startsWith('http://') || filePath.startsWith('https://');

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'title': title,
    'description': description,
    'category': category.dbValue,
    'file_path': filePath,
    'duration_seconds': durationSeconds,
    'sort_order': sortOrder,
    'created_at': createdAt.toIso8601String(),
  };

  factory AudioTrack.fromMap(Map<String, dynamic> map) => AudioTrack(
    id: map['id'] as int?,
    title: map['title'] as String,
    description: map['description'] as String?,
    category: AudioCategory.fromDbValue(map['category'] as String),
    filePath: map['file_path'] as String,
    durationSeconds: map['duration_seconds'] as int,
    sortOrder: map['sort_order'] as int,
    createdAt: DateTime.parse(map['created_at'] as String),
  );

  AudioTrack copyWith({
    int? id,
    String? title,
    String? description,
    AudioCategory? category,
    String? filePath,
    int? durationSeconds,
    int? sortOrder,
    DateTime? createdAt,
  }) => AudioTrack(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    filePath: filePath ?? this.filePath,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is AudioTrack && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
