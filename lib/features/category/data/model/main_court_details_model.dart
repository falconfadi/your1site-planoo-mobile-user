
class MainCourtDetailsModel {
  String? id;
  String? userId;
  int? categoryId;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  MainCourtDetailsModel({
    this.id,
    this.userId,
    this.categoryId,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt
  });

  MainCourtDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
