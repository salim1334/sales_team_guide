class CallScriptGroupModel {
  final int? id;
  final String title;
  final String titleAm;
  final String icon;
  final int sortOrder;

  CallScriptGroupModel({
    this.id,
    required this.title,
    required this.titleAm,
    required this.icon,
    required this.sortOrder,
  });

  factory CallScriptGroupModel.fromMap(Map<String, dynamic> map) {
    return CallScriptGroupModel(
      id: map['id'],
      title: map['title'],
      titleAm: map['title_am'],
      icon: map['icon'],
      sortOrder: map['sort_order'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'title_am': titleAm,
      'icon': icon,
      'sort_order': sortOrder,
    };
  }
}
