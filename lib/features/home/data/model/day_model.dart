
class DayModel {
  int? id;
  String? day;
  String? start;
  String? end;
  bool? isActive;

  DayModel({
    this.id,
    this.day,
    this.start,
    this.end,
    this.isActive,
  });

  DayModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    start = json['start'];
    end = json['end'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day'] = day;
    data['start'] = start;
    data['end'] = end;
    data['is_active'] = isActive;
    return data;
  }
}
