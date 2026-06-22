import 'package:centro/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:centro/features/appointment/data/appointment_repository/appointment_repository.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';
import '../../../../../../core/params/base_params.dart';
import '../../../../../../core/results/result.dart';
import '../../../../../../core/usecase/usecase.dart';

class EventAppointmentsParams extends BaseParams {

  final GetListRequest request;
  final String? date;

  EventAppointmentsParams(this.request, {this.date});

  Map<String, dynamic> toJson() {
    return {
      "pageOption": request.toJson(),
      if (date != null) "filters": {
        "start_date":date,
      },
    };
  }
}

class EventAppointmentsUseCase extends UseCase<List<EventDetailsModel>, EventAppointmentsParams> {
  final AppointmentRepository repository;

  EventAppointmentsUseCase(this.repository);

  @override
  Future<Result<List<EventDetailsModel>>> call({required EventAppointmentsParams params}) {
    return repository.getEventAppointments(params: params);
  }
}
