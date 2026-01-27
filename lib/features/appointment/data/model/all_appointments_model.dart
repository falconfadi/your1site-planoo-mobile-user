import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/appointment/data/model/appointment_details_model.dart';

class AllAppointmentsResponse extends ApiResponse<AllAppointmentsModel> {
  AllAppointmentsResponse({required super.errors, required super.message, required super.data});

  factory AllAppointmentsResponse.fromJson(Map<String, dynamic> json) {
    return AllAppointmentsResponse(
      errors: json["payload"]["errors"] != null
          ? AllAppointmentsModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: AllAppointmentsModel.fromJson(json["payload"]),
    );
  }
}

class AllAppointmentsModel extends BaseModel {

  int? page;
  int? perPage;
  List<AppointmentDetailsModel>? data;

  AllAppointmentsModel({this.data,this.page,this.perPage});

  AllAppointmentsModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    if (json['appointments'] != null) {
      data = <AppointmentDetailsModel>[];
      json['appointments'].forEach((v) {
        data!.add(AppointmentDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['page'] = page;
    data['perPage'] = perPage;
    if (this.data != null) {
      data['appointments'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}