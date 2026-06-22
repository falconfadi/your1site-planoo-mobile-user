import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';

class NotificationsResponse extends ApiResponse<NotificationsModel> {
  NotificationsResponse({required super.errors, required super.message, required super.data});

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      errors: json["payload"]["errors"] != null
          ? NotificationsModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: NotificationsModel.fromJson(json["payload"]),
    );
  }
}

class NotificationsModel extends BaseModel {

  List<NotificationInfoModel>? notificationsList;

  NotificationsModel({this.notificationsList});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notificationsList = <NotificationInfoModel>[];
      json['notifications'].forEach((v) {
        notificationsList!.add(NotificationInfoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notificationsList != null) {
      data['notifications'] = notificationsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationInfoModel extends BaseModel {
  int? notificationId;
  String? title;
  String? body;
  String? type;
  bool? isViewed;
  Payload? payload;
  String? createdAt;

  NotificationInfoModel({
    this.notificationId,
    this.title,
    this.body,
    this.type,
    this.isViewed,
    this.payload,
    this.createdAt,
  });

  NotificationInfoModel.fromJson(Map<String, dynamic> json) {
    notificationId = json['id'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    isViewed = json['is_viewed'];
    payload = json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = notificationId;
    data['title'] = title;
    data['body'] = body;
    data['type'] = type;
    data['is_viewed'] = isViewed;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }
}


class Payload {
  int? type;
  int? code;
  int? appointment;
  int? course;
  int? event;
  Result? result;

  Payload({
    this.type,
    this.code,
    this.appointment,
    this.course,
    this.event,
    this.result,
  });

  Payload.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
    appointment = json['appointment'];
    course = json['course'];
    event = json['event'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['code'] = code;
    data['appointment'] = appointment;
    data['course'] = course;
    data['event'] = event;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  String? name;

  Result({this.name});

  Result.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}