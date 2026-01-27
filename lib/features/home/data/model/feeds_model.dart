import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/category/data/model/activity/activity_details_model.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';

class FeedsResponse extends ApiResponse<FeedsModel> {

  FeedsResponse({required super.errors, required super.message, required super.data});

  factory FeedsResponse.fromJson(Map<String, dynamic> json) {
    return FeedsResponse(
      errors: json["payload"]["errors"] != null
          ? FeedsModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: FeedsModel.fromJson(json["payload"]),
    );
  }
}

class FeedsModel extends BaseModel {

  FeedInfoModel? feedsList;

  FeedsModel({this.feedsList});

  FeedsModel.fromJson(Map<String, dynamic> json) {
    feedsList = json['feeds'] != null ? FeedInfoModel.fromJson(json['feeds']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feedsList != null) {
      data['feeds'] = feedsList!.toJson();
    }
    return data;
  }
}

class FeedInfoModel {

  List<ActivityDetailsModel>? activities;
  List<CourseDetailsModel>? courses;
  List<EventDetailsModel>? events;

  FeedInfoModel({
    this.activities,
    this.courses,
    this.events
  });

  FeedInfoModel.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = <ActivityDetailsModel>[];
      json['activities'].forEach((v) {
        activities!.add(ActivityDetailsModel.fromJson(v));
      });
    }
    if (json['courses'] != null) {
      courses = <CourseDetailsModel>[];
      json['courses'].forEach((v) {
        courses!.add(CourseDetailsModel.fromJson(v));
      });
    }
    if (json['events'] != null) {
      events = <EventDetailsModel>[];
      json['events'].forEach((v) {
        events!.add(EventDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

