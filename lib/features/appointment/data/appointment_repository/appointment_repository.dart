import 'package:centro/core/constants/end_point.dart';
import 'package:centro/core/data_source/remote_data_source.dart';
import 'package:centro/core/http/http_method.dart';
import 'package:centro/core/repository/core_repository.dart';
import 'package:centro/core/results/result.dart';
import 'package:centro/features/appointment/data/model/course/course_appointments_model.dart';
import 'package:centro/features/appointment/data/model/court/court_appointments_model.dart';
import 'package:centro/features/appointment/data/model/court/all_court_appointments_model.dart';
import 'package:centro/features/appointment/data/model/event/event_appointments_model.dart';
import 'package:centro/features/appointment/data/usecase/course/course_appointments_usecase.dart';
import 'package:centro/features/appointment/data/usecase/court/court_appointments_usecase.dart';
import 'package:centro/features/appointment/data/usecase/court/court_appointment_details_usecase.dart';
import 'package:centro/features/appointment/data/usecase/court/cancel_court_appointment_usecase.dart';
import 'package:centro/features/appointment/data/usecase/court/all_court_appointments_usecase.dart';
import 'package:centro/features/appointment/data/usecase/event/event_appointments_usecase.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';
import '../model/court/court_appointment_details_model.dart';

class AppointmentRepository extends CoreRepository {

  Future<Result<List<CourtAppointmentDetailsModel>>> getAllCourtAppointments({required AllCourtAppointmentsParams params}) async {
    String query = "page=${params.request.page}";
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$allAppointmentsUrl/activity?$query",
        method: HttpMethod.POST,
        data: params.toJson(),
        responseStr: 'AllCourtAppointmentsResponse',
        converter: (json) => AllCourtAppointmentsResponse.fromJson(json));
    return paginatedCall(result: result);
  }

  Future<Result<CourtAppointmentDetailsModel>> getCourtAppointmentDetails({required CourtAppointmentDetailsParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$getAppointmentDetailsUrl?appointment_id=${params.appointmentId}",
        method: HttpMethod.GET,
        responseStr: 'CourtAppointmentDetailsResponse',
        converter: (json) => CourtAppointmentDetailsResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<bool>> cancelCourtAppointment({required CancelCourtAppointmentParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: true,
      url: cancelActivityAppointmentUrl,
      data: params.toJson(),
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }

  Future<Result<CourtAppointmentsModel>> getCourtAppointments({required CourtAppointmentsParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$acceptedAppointmentsUrl/activity",
        method: HttpMethod.POST,
        responseStr: 'CourtAppointmentsResponse',
        converter: (json) => CourtAppointmentsResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<List<CourseDetailsModel>>> getCourseAppointments({required CourseAppointmentsParams params}) async {
    String query = "page=${params.request.page}";
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$attendedCourseUrl?$query",
        method: HttpMethod.POST,
        data: params.toJson(),
        responseStr: 'CourseAppointmentsResponse',
        converter: (json) => CourseAppointmentsResponse.fromJson(json));
    return paginatedCall(result: result);
  }

  Future<Result<List<EventDetailsModel>>> getEventAppointments({required EventAppointmentsParams params}) async {
    String query = "page=${params.request.page}";
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$attendedEventUrl?$query",
        method: HttpMethod.POST,
        data: params.toJson(),
        responseStr: 'EventAppointmentsResponse',
        converter: (json) => EventAppointmentsResponse.fromJson(json));
    return paginatedCall(result: result);
  }

}
