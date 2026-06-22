import 'package:centro/features/appointment/data/appointment_repository/appointment_repository.dart';
import 'package:centro/features/appointment/data/model/court/court_appointment_details_model.dart';
import '../../../../../core/params/base_params.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/usecase/usecase.dart';

class CourtAppointmentDetailsParams extends BaseParams {

  final int appointmentId;

  CourtAppointmentDetailsParams({required this.appointmentId});
}

class CourtAppointmentDetailsUseCase extends UseCase<CourtAppointmentDetailsModel, CourtAppointmentDetailsParams> {
  final AppointmentRepository repository;

  CourtAppointmentDetailsUseCase(this.repository);

  @override
  Future<Result<CourtAppointmentDetailsModel>> call({required CourtAppointmentDetailsParams params}) {
    return repository.getCourtAppointmentDetails(params: params);
  }
}
