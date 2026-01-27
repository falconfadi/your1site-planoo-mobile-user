
class TagModel {
  int? id;
  String? name;
  String? icon;

  TagModel({this.id, this.name,this.icon});

  TagModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }
}

