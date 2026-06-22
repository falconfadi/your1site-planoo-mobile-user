import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/appointment/data/model/court/court_appointment_details_model.dart';

class CourtAppointmentsResponse extends ApiResponse<CourtAppointmentsModel> {
  CourtAppointmentsResponse({required super.errors, required super.message, required super.data});

  factory CourtAppointmentsResponse.fromJson(Map<String, dynamic> json) {
    return CourtAppointmentsResponse(
      errors: json["payload"]["errors"] != null
          ? CourtAppointmentsModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: CourtAppointmentsModel.fromJson(json["payload"]),
    );
  }
}

class CourtAppointmentsModel extends BaseModel {

  List<CourtAppointmentDetailsModel>? appointmentsList;

  CourtAppointmentsModel({this.appointmentsList});

  CourtAppointmentsModel.fromJson(Map<String, dynamic> json) {
    if (json['appointments'] != null) {
      appointmentsList = <CourtAppointmentDetailsModel>[];
      json['appointments'].forEach((v) {
        appointmentsList!.add(CourtAppointmentDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (appointmentsList != null) {
      data['appointments'] = appointmentsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}