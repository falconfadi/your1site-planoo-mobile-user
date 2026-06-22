import 'package:centro/features/appointment/data/appointment_repository/appointment_repository.dart';
import 'package:centro/features/appointment/data/model/court/court_appointments_model.dart';
import '../../../../../../core/params/base_params.dart';
import '../../../../../../core/results/result.dart';
import '../../../../../../core/usecase/usecase.dart';

class CourtAppointmentsParams extends BaseParams {

  CourtAppointmentsParams();
}

class CourtAppointmentsUseCase extends UseCase<CourtAppointmentsModel, CourtAppointmentsParams> {
  final AppointmentRepository repository;

  CourtAppointmentsUseCase(this.repository);

  @override
  Future<Result<CourtAppointmentsModel>> call({required CourtAppointmentsParams params}) {
    return repository.getCourtAppointments(params: params);
  }
}
