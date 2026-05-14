class AdTemplateGroupModel {
  final int? id;
  final String name;
  final String description;
  final int sortOrder;

  AdTemplateGroupModel({
    this.id,
    required this.name,
    required this.description,
    required this.sortOrder,
  });

  factory AdTemplateGroupModel.fromMap(Map<String, dynamic> map) {
    return AdTemplateGroupModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      sortOrder: map['sort_order'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sort_order': sortOrder,
    };
  }
}
