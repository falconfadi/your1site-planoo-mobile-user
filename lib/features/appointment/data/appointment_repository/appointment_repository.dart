import 'package:centro/core/constants/end_point.dart';
import 'package:centro/core/data_source/remote_data_source.dart';
import 'package:centro/core/http/http_method.dart';
import 'package:centro/core/repository/core_repository.dart';
import 'package:centro/core/results/result.dart';
import 'package:centro/features/appointment/data/model/all_appointments_model.dart';
import 'package:centro/features/appointment/data/usecase/appointment_details_usecase.dart';
import 'package:centro/features/appointment/data/usecase/cancel_activity_appointment_usecase.dart';
import 'package:centro/features/appointment/data/usecase/all_appointments_usecase.dart';
import '../model/appointment_details_model.dart';

class AppointmentRepository extends CoreRepository {

  Future<Result<List<AppointmentDetailsModel>>> getAllAppointments({required AllAppointmentsParams params}) async {
    String query = "page=${params.request.page}";
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$allAppointmentsUrl/${params.ownerType}?$query",
        method: HttpMethod.POST,
        data: params.toJson(),
        responseStr: 'AllAppointmentsResponse',
        converter: (json) => AllAppointmentsResponse.fromJson(json));
    return paginatedCall(result: result);
  }

  Future<Result<AppointmentDetailsModel>> getAppointmentDetails({required AppointmentDetailsParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$getAppointmentDetailsUrl?appointment_id=${params.appointmentId}",
        method: HttpMethod.GET,
        responseStr: 'AppointmentDetailsResponse',
        converter: (json) => AppointmentDetailsResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<bool>> cancelActivityAppointment({required CancelActivityAppointmentParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: true,
      url: cancelActivityAppointmentUrl,
      data: params.toJson(),
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }

}
