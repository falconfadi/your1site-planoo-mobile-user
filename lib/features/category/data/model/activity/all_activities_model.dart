import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/category/data/model/activity/activity_details_model.dart';

class AllActivitiesResponse extends ApiResponse<AllActivitiesModel> {

  AllActivitiesResponse({required super.errors, required super.message, required super.data});

  factory AllActivitiesResponse.fromJson(Map<String, dynamic> json) {
    return AllActivitiesResponse(
      errors: json["payload"]["errors"] != null
          ? AllActivitiesModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: AllActivitiesModel.fromJson(json["payload"]),
    );
  }
}

class AllActivitiesModel extends BaseModel {

  int? page;
  int? perPage;
  List<ActivityDetailsModel>? data;

  AllActivitiesModel({this.data,this.page,this.perPage});

  AllActivitiesModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    if (json['activities'] != null) {
      data = <ActivityDetailsModel>[];
      json['activities'].forEach((v) {
        data!.add(ActivityDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['perPage'] = perPage;
    if (this.data != null) {
      data['activities'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

