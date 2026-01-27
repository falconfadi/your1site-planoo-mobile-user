import 'package:centro/features/category/data/category_repository/category_repository.dart';
import '../../../../../../core/params/base_params.dart';
import '../../../../../../core/results/result.dart';
import '../../../../../../core/usecase/usecase.dart';

class AttendCourseParams extends BaseParams {

  final int courseId;

  AttendCourseParams({required this.courseId});
}

class AttendCourseUseCase extends UseCase<bool, AttendCourseParams> {
  final CategoryRepository repository;

  AttendCourseUseCase(this.repository);

  @override
  Future<Result<bool>> call({required AttendCourseParams params}) {
    return repository.attendCourse(params: params);
  }
}
