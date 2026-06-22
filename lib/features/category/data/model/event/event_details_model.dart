import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/category/data/model/category_model.dart';
import 'package:centro/features/category/data/model/review_model.dart';
import 'package:centro/features/home/data/model/day_model.dart';
import 'package:centro/features/home/data/model/tag_model.dart';
import 'package:centro/features/home/data/model/location_model.dart';
import 'package:centro/features/profile/data/model/profile_image_model.dart';

class EventDetailsResponse extends ApiResponse<EventDetailsModel> {
  EventDetailsResponse({required super.errors, required super.message, required super.data});

  factory EventDetailsResponse.fromJson(Map<String, dynamic> json) {
    return EventDetailsResponse(
      errors: json["payload"]["errors"] != null
          ? EventDetailsModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: EventDetailsModel.fromJson(json["payload"]['event']),
    );
  }
}

class EventDetailsModel extends BaseModel {
  int? iD;
  String? name;
  String? description;
  CategoryInfoModel? category;
  bool? isActive;
  bool? isFull;
  int? capacity;
  int? admissionFee;
  int? withdrawalFee;
  int? eventDuration;
  String? startDate;
  String? endDate;
  int? rate;
  String? status;
  bool? isFavorite;
  bool? isAttending;
  List<DayModel>? workdaysList;
  List<TagModel>? facilitiesList;
  LocationModel? location;
  List<ImageModel>? mediaList;
  List<ReviewInfoModel>? reviewsList;

  EventDetailsModel({
    this.iD,
    this.name,
    this.description,
    this.category,
    this.isActive,
    this.isFull,
    this.capacity,
    this.admissionFee,
    this.withdrawalFee,
    this.eventDuration,
    this.startDate,
    this.endDate,
    this.rate,
    this.status,
    this.isFavorite,
    this.isAttending,
    this.workdaysList,
    this.facilitiesList,
    this.location,
    this.mediaList,
    this.reviewsList
  });

  EventDetailsModel.fromJson(Map<String, dynamic> json) {
    iD = json['id'];
    name = json['name'];
    description = json['description'];
    category = json['category'] != null ? CategoryInfoModel.fromJson(json['category']) : null;
    isActive = json['is_active'];
    isFull = json['is_full'];
    capacity = json['capacity'];
    admissionFee = json['admission_fee'];
    withdrawalFee = json['withdrawal_fee'];
    eventDuration = json['event_duration'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    rate = json['rate'];
    status = json['status'];
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
    data['is_full'] = isFull;
    data['capacity'] = capacity;
    data['admission_fee'] = admissionFee;
    data['withdrawal_fee'] = withdrawalFee;
    data['event_duration'] = eventDuration;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['rate'] = rate;
    data['status'] = status;
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
