import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';

class EventAppointmentsResponse extends ApiResponse<EventAppointmentsModel> {

  EventAppointmentsResponse({required super.errors, required super.message, required super.data});

  factory EventAppointmentsResponse.fromJson(Map<String, dynamic> json) {
    return EventAppointmentsResponse(
      errors: json["payload"]["errors"] != null
          ? EventAppointmentsModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: EventAppointmentsModel.fromJson(json["payload"]),
    );
  }
}

class EventAppointmentsModel extends BaseModel {

  int? page;
  int? perPage;
  List<EventDetailsModel>? data;

  EventAppointmentsModel({this.data,this.page,this.perPage});

  EventAppointmentsModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    if (json['events'] != null) {
      data = <EventDetailsModel>[];
      json['events'].forEach((v) {
        data!.add(EventDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['page'] = page;
    data['perPage'] = perPage;
    if (this.data != null) {
      data['events'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}