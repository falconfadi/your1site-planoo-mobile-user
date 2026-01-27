import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';
import '../../../../../core/params/base_params.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/usecase/usecase.dart';

class CourseDetailsParams extends BaseParams {

  final int courseId;

  CourseDetailsParams({required this.courseId});
}

class CourseDetailsUseCase extends UseCase<CourseDetailsModel, CourseDetailsParams> {
  final CategoryRepository repository;

  CourseDetailsUseCase(this.repository);

  @override
  Future<Result<CourseDetailsModel>> call({required CourseDetailsParams params}) {
    return repository.getCourseDetails(params: params);
  }
}
