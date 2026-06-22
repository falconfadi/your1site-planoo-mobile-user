import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/appointment/data/model/court/court_appointment_details_model.dart';

class AllCourtAppointmentsResponse extends ApiResponse<AllCourtAppointmentsModel> {
  AllCourtAppointmentsResponse({required super.errors, required super.message, required super.data});

  factory AllCourtAppointmentsResponse.fromJson(Map<String, dynamic> json) {
    return AllCourtAppointmentsResponse(
      errors: json["payload"]["errors"] != null
          ? AllCourtAppointmentsModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: AllCourtAppointmentsModel.fromJson(json["payload"]),
    );
  }
}

class AllCourtAppointmentsModel extends BaseModel {

  int? page;
  int? perPage;
  List<CourtAppointmentDetailsModel>? data;

  AllCourtAppointmentsModel({this.data,this.page,this.perPage});

  AllCourtAppointmentsModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    if (json['appointments'] != null) {
      data = <CourtAppointmentDetailsModel>[];
      json['appointments'].forEach((v) {
        data!.add(CourtAppointmentDetailsModel.fromJson(v));
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