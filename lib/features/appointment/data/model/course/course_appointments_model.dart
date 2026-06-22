import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';

class CourseAppointmentsResponse extends ApiResponse<CourseAppointmentsModel> {

  CourseAppointmentsResponse({required super.errors, required super.message, required super.data});

  factory CourseAppointmentsResponse.fromJson(Map<String, dynamic> json) {
    return CourseAppointmentsResponse(
      errors: json["payload"]["errors"] != null
          ? CourseAppointmentsModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: CourseAppointmentsModel.fromJson(json["payload"]),
    );
  }
}

class CourseAppointmentsModel extends BaseModel {

  int? page;
  int? perPage;
  List<CourseDetailsModel>? data;

  CourseAppointmentsModel({this.data,this.page,this.perPage});

  CourseAppointmentsModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = {};
    data['page'] = page;
    data['perPage'] = perPage;
    if (this.data != null) {
      data['courses'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}