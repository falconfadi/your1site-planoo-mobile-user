import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/category/data/model/court/court_details_model.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';

class FeaturedResponse extends ApiResponse<FeaturedModel> {

  FeaturedResponse({required super.errors, required super.message, required super.data});

  factory FeaturedResponse.fromJson(Map<String, dynamic> json) {
    return FeaturedResponse(
      errors: json["payload"]["errors"] != null
          ? FeaturedModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: FeaturedModel.fromJson(json["payload"]),
    );
  }
}

class FeaturedModel extends BaseModel {

  FeaturedInfoModel? featuredInfoModel;

  FeaturedModel({this.featuredInfoModel});

  FeaturedModel.fromJson(Map<String, dynamic> json) {
    featuredInfoModel = json['featured'] != null ? FeaturedInfoModel.fromJson(json['featured']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (featuredInfoModel != null) {
      data['featured'] = featuredInfoModel!.toJson();
    }
    return data;
  }
}

class FeaturedInfoModel {

  List<CourtDetailsModel>? courts;
  List<CourseDetailsModel>? courses;
  List<EventDetailsModel>? events;

  FeaturedInfoModel({
    this.courts,
    this.courses,
    this.events
  });

  FeaturedInfoModel.fromJson(Map<String, dynamic> json) {
    if (json['activity'] != null) {
      courts = <CourtDetailsModel>[];
      json['activity'].forEach((v) {
        courts!.add(CourtDetailsModel.fromJson(v));
      });
    }
    if (json['course'] != null) {
      courses = <CourseDetailsModel>[];
      json['course'].forEach((v) {
        courses!.add(CourseDetailsModel.fromJson(v));
      });
    }
    if (json['event'] != null) {
      events = <EventDetailsModel>[];
      json['event'].forEach((v) {
        events!.add(EventDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courts != null) {
      data['activity'] = courts!.map((v) => v.toJson()).toList();
    }
    if (courses != null) {
      data['course'] = courses!.map((v) => v.toJson()).toList();
    }
    if (events != null) {
      data['event'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

