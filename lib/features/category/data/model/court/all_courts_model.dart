import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/category/data/model/court/court_details_model.dart';

class AllCourtsResponse extends ApiResponse<AllCourtsModel> {

  AllCourtsResponse({required super.errors, required super.message, required super.data});

  factory AllCourtsResponse.fromJson(Map<String, dynamic> json) {
    return AllCourtsResponse(
      errors: json["payload"]["errors"] != null
          ? AllCourtsModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: AllCourtsModel.fromJson(json["payload"]),
    );
  }
}

class AllCourtsModel extends BaseModel {

  int? page;
  int? perPage;
  List<CourtDetailsModel>? data;

  AllCourtsModel({this.data,this.page,this.perPage});

  AllCourtsModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    if (json['activities'] != null) {
      data = <CourtDetailsModel>[];
      json['activities'].forEach((v) {
        data!.add(CourtDetailsModel.fromJson(v));
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

