class AdTemplateModel {
  final int? id;
  final int groupId;
  final int dayNumber;
  final String bodyAm;
  final int isFavorite;

  AdTemplateModel({
    this.id,
    required this.groupId,
    required this.dayNumber,
    required this.bodyAm,
    this.isFavorite = 0,
  });

  factory AdTemplateModel.fromMap(Map<String, dynamic> map) {
    return AdTemplateModel(
      id: map['id'],
      groupId: map['group_id'],
      dayNumber: map['day_number'],
      bodyAm: map['body_am'],
      isFavorite: map['is_favorite'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group_id': groupId,
      'day_number': dayNumber,
      'body_am': bodyAm,
      'is_favorite': isFavorite,
    };
  }
}
