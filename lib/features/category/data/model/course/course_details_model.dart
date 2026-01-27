import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/category/data/model/category_model.dart';
import 'package:centro/features/category/data/model/review_model.dart';
import 'package:centro/features/home/data/model/day_model.dart';
import 'package:centro/features/home/data/model/tag_model.dart';
import 'package:centro/features/home/data/model/location_model.dart';
import 'package:centro/features/profile/data/model/profile_image_model.dart';

class CourseDetailsResponse extends ApiResponse<CourseDetailsModel> {
  CourseDetailsResponse({required super.errors, required super.message, required super.data});

  factory CourseDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CourseDetailsResponse(
      errors: json["payload"]["errors"] != null
          ? CourseDetailsModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: CourseDetailsModel.fromJson(json["payload"]['course']),
    );
  }
}

class CourseDetailsModel extends BaseModel {
  int? iD;
  String? name;
  String? description;
  CategoryInfoModel? category;
  bool? isActive;
  int? price;
  bool? isFull;
  int? sessionDuration;
  int? courseDuration;
  int? capacity;
  int? cancellationFee;
  int? rate;
  bool? isFavorite;
  bool? isAttending;
  List<DayModel>? workdaysList;
  List<TagModel>? facilitiesList;
  LocationModel? location;
  List<ImageModel>? mediaList;
  List<ReviewInfoModel>? reviewsList;

  CourseDetailsModel({
    this.iD,
    this.name,
    this.description,
    this.category,
    this.isActive,
    this.price,
    this.isFull,
    this.sessionDuration,
    this.courseDuration,
    this.capacity,
    this.cancellationFee,
    this.rate,
    this.isFavorite,
    this.isAttending,
    this.workdaysList,
    this.facilitiesList,
    this.location,
    this.mediaList,
    this.reviewsList
  });

  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    iD = json['id'];
    name = json['name'];
    description = json['description'];
    category = json['category'] != null ? CategoryInfoModel.fromJson(json['category']) : null;
    isActive = json['is_active'];
    price = json['price'];
    isFull = json['is_full'];
    sessionDuration = json['session_duration'];
    courseDuration = json['course_duration'];
    capacity = json['capacity'];
    cancellationFee = json['cancellation_fee'];
    rate = json['rate'];
    isFavorite = json['is_favorite'];
    isAttending = json['is_attending'];
    if (json['days'] != null) {
      workdaysList = <DayModel>[];
      json['days'].forEach((v) {
        workdaysList!.add(DayModel.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      facilitiesList = <TagModel>[];
      json['tags'].forEach((v) {
        facilitiesList!.add(TagModel.fromJson(v));
      });
    }
    location = json['location'] != null ? LocationModel.fromJson(json['location']) : null;
    if (json['medias'] != null) {
      mediaList = <ImageModel>[];
      json['medias'].forEach((v) {
        mediaList!.add(ImageModel.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviewsList = <ReviewInfoModel>[];
      json['reviews'].forEach((v) {
        reviewsList!.add(ReviewInfoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = iD;
    data['name'] = name;
    data['description'] = description;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['is_active'] = isActive;
    data['price'] = price;
    data['is_full'] = isFull;
    data['session_duration'] = sessionDuration;
    data['course_duration'] = courseDuration;
    data['capacity'] = capacity;
    data['cancellation_fee'] = cancellationFee;
    data['rate'] = rate;
    data['is_favorite'] = isFavorite;
    data['is_attending'] = isAttending;
    if (facilitiesList != null) {
      data['tags'] = facilitiesList!.map((v) => v.toJson()).toList();
    }
    if(workdaysList != null) {
      data["days"] = workdaysList!.map((e) => e.toJson()).toList();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (mediaList != null) {
      data['medias'] = mediaList!.map((v) => v.toJson()).toList();
    }
    if (reviewsList != null) {
      data['reviews'] = reviewsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
