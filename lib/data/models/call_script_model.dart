class CallScriptModel {
  final int? id;
  final int groupId;
  final String bodyAm;
  final String tag;
  final int sortOrder;

  CallScriptModel({
    this.id,
    required this.groupId,
    required this.bodyAm,
    required this.tag,
    required this.sortOrder,
  });

  factory CallScriptModel.fromMap(Map<String, dynamic> map) {
    return CallScriptModel(
      id: map['id'],
      groupId: map['group_id'],
      bodyAm: map['body_am'],
      tag: map['tag'],
      sortOrder: map['sort_order'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group_id': groupId,
      'body_am': bodyAm,
      'tag': tag,
      'sort_order': sortOrder,
    };
  }
}
