import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';

class AllCoursesResponse extends ApiResponse<AllCoursesModel> {
  AllCoursesResponse({required super.errors, required super.message, required super.data});

  factory AllCoursesResponse.fromJson(Map<String, dynamic> json) {
    return AllCoursesResponse(
      errors: json["payload"]["errors"] != null
          ? AllCoursesModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: AllCoursesModel.fromJson(json["payload"]),
    );
  }
}

class AllCoursesModel extends BaseModel {

  int? page;
  int? perPage;
  List<CourseDetailsModel>? data;

  AllCoursesModel({this.data,this.page,this.perPage});

  AllCoursesModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    if (json['courses'] != null) {
      data = <CourseDetailsModel>[];
      json['courses'].forEach((v) {
        data!.add(CourseDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['perPage'] = perPage;
    if (this.data != null) {
      data['courses'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

