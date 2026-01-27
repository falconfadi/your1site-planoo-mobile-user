import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';

class AllEventsResponse extends ApiResponse<AllEventsModel> {
  AllEventsResponse({required super.errors, required super.message, required super.data});

  factory AllEventsResponse.fromJson(Map<String, dynamic> json) {
    return AllEventsResponse(
      errors: json["payload"]["errors"] != null
          ? AllEventsModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: AllEventsModel.fromJson(json["payload"]),
    );
  }
}

class AllEventsModel extends BaseModel {

  int? page;
  int? perPage;
  List<EventDetailsModel>? data;

  AllEventsModel({this.data,this.page,this.perPage});

  AllEventsModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['perPage'] = perPage;
    if (this.data != null) {
      data['events'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

