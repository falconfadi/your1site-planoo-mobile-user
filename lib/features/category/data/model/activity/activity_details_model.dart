import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/category/data/model/category_model.dart';
import 'package:centro/features/category/data/model/review_model.dart';
import 'package:centro/features/home/data/model/day_model.dart';
import 'package:centro/features/home/data/model/tag_model.dart';
import 'package:centro/features/home/data/model/location_model.dart';
import 'package:centro/features/profile/data/model/profile_image_model.dart';

class ActivityDetailsResponse extends ApiResponse<ActivityDetailsModel> {
  ActivityDetailsResponse({required super.errors, required super.message, required super.data});

  factory ActivityDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ActivityDetailsResponse(
      errors: json["payload"]["errors"] != null
          ? ActivityDetailsModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: ActivityDetailsModel.fromJson(json["payload"]['activity']),
    );
  }
}

class ActivityDetailsModel extends BaseModel {
  int? iD;
  String? name;
  String? description;
  CategoryInfoModel? category;
  bool? isActive;
  int? price;
  int? sessionDuration;
  int? rate;
  bool? isFavorite;
  List<DayModel>? workdaysList;
  List<TagModel>? facilitiesList;
  LocationModel? location;
  List<ImageModel>? mediaList;
  List<ReviewInfoModel>? reviewsList;

  ActivityDetailsModel({
    this.iD,
    this.name,
    this.description,
    this.category,
    this.isActive,
    this.price,
    this.sessionDuration,
    this.rate,
    this.isFavorite,
    this.workdaysList,
    this.facilitiesList,
    this.location,
    this.mediaList,
    this.reviewsList
  });

  ActivityDetailsModel.fromJson(Map<String, dynamic> json) {
    iD = json['id'];
    name = json['name'];
    description = json['description'];
    category = json['category'] != null ? CategoryInfoModel.fromJson(json['category']) : null;
    isActive = json['is_active'];
    price = json['price'];
    sessionDuration = json['session_duration'];
    rate = json['rate'];
    isFavorite = json['is_favorite'];
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
    data['session_duration'] = sessionDuration;
    data['rate'] = rate;
    data['is_favorite'] = isFavorite;
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
