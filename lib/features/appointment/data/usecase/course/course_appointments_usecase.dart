import 'package:centro/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:centro/features/appointment/data/appointment_repository/appointment_repository.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';
import '../../../../../../core/params/base_params.dart';
import '../../../../../../core/results/result.dart';
import '../../../../../../core/usecase/usecase.dart';

class CourseAppointmentsParams extends BaseParams {

  final GetListRequest request;
  final String? date;

  CourseAppointmentsParams(this.request, {this.date});

  Map<String, dynamic> toJson() {
    return {
      "pageOption": request.toJson(),
      if (date != null) "filters": {
        "start_date":date,
      },
    };
  }
}

class CourseAppointmentsUseCase extends UseCase<List<CourseDetailsModel>, CourseAppointmentsParams> {
  final AppointmentRepository repository;

  CourseAppointmentsUseCase(this.repository);

  @override
  Future<Result<List<CourseDetailsModel>>> call({required CourseAppointmentsParams params}) {
    return repository.getCourseAppointments(params: params);
  }
}
