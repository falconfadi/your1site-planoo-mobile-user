import 'package:centro/features/category/data/category_repository/category_repository.dart';
import '../../../../../../core/params/base_params.dart';
import '../../../../../../core/results/result.dart';
import '../../../../../../core/usecase/usecase.dart';

class CancelCourseParams extends BaseParams {

  final int courseId;

  CancelCourseParams({required this.courseId});

  Map<String, dynamic> toJson() {
    return {
      'course_id': courseId,
    };
  }
}

class CancelCourseUseCase extends UseCase<bool, CancelCourseParams> {
  final CategoryRepository repository;

  CancelCourseUseCase(this.repository);

  @override
  Future<Result<bool>> call({required CancelCourseParams params}) {
    return repository.cancelCourse(params: params);
  }
}
