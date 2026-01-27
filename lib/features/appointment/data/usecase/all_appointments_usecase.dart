import 'package:centro/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:centro/features/appointment/data/appointment_repository/appointment_repository.dart';
import 'package:centro/features/appointment/data/model/appointment_details_model.dart';
import '../../../../../core/params/base_params.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/usecase/usecase.dart';

class AllAppointmentsParams extends BaseParams {

  final GetListRequest request;
  final String ownerType;
  final String? date;

  AllAppointmentsParams(this.request, {
    required this.ownerType,
    this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      "pageOption": request.toJson(),
      if (date != null) "filters": {
        "date":date,
      },
    };
  }
}

class AllAppointmentsUseCase extends UseCase<List<AppointmentDetailsModel>, AllAppointmentsParams> {
  final AppointmentRepository repository;

  AllAppointmentsUseCase(this.repository);

  @override
  Future<Result<List<AppointmentDetailsModel>>> call({required AllAppointmentsParams params}) {
    return repository.getAllAppointments(params: params);
  }
}
