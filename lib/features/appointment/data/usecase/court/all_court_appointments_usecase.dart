import 'package:centro/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:centro/features/appointment/data/appointment_repository/appointment_repository.dart';
import 'package:centro/features/appointment/data/model/court/court_appointment_details_model.dart';
import '../../../../../../core/params/base_params.dart';
import '../../../../../../core/results/result.dart';
import '../../../../../../core/usecase/usecase.dart';

class AllCourtAppointmentsParams extends BaseParams {

  final GetListRequest request;
  final String? date;

  AllCourtAppointmentsParams(this.request, {this.date});

  Map<String, dynamic> toJson() {
    return {
      "pageOption": request.toJson(),
      if (date != null) "filters": {
        "date":date,
      },
    };
  }
}

class AllCourtAppointmentsUseCase extends UseCase<List<CourtAppointmentDetailsModel>, AllCourtAppointmentsParams> {
  final AppointmentRepository repository;

  AllCourtAppointmentsUseCase(this.repository);

  @override
  Future<Result<List<CourtAppointmentDetailsModel>>> call({required AllCourtAppointmentsParams params}) {
    return repository.getAllCourtAppointments(params: params);
  }
}
