import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/activity/activity_details_model.dart';
import '../../../../../core/params/base_params.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/usecase/usecase.dart';

class ActivityDetailsParams extends BaseParams {

  final int activityId;

  ActivityDetailsParams({required this.activityId});
}

class ActivityDetailsUseCase extends UseCase<ActivityDetailsModel, ActivityDetailsParams> {
  final CategoryRepository repository;

  ActivityDetailsUseCase(this.repository);

  @override
  Future<Result<ActivityDetailsModel>> call({required ActivityDetailsParams params}) {
    return repository.getActivityDetails(params: params);
  }
}
