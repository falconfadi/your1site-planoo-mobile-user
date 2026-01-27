import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/activity/slots_model.dart';
import '../../../../../../core/params/base_params.dart';
import '../../../../../../core/results/result.dart';
import '../../../../../../core/usecase/usecase.dart';

class CheckActivityParams extends BaseParams {

  final int activityId;
  final int dayId;
  final String date;
  final int sessionDuration;

  CheckActivityParams({
    required this.activityId,
    required this.dayId,
    required this.date,
    required this.sessionDuration,
  });

  Map<String, dynamic> toJson() {
    return {
      'activity_id': activityId,
      'day_id': dayId,
      'date': date,
      'session_duration': sessionDuration,
    };
  }
}

class CheckActivityUseCase extends UseCase<SlotsModel, CheckActivityParams> {
  final CategoryRepository repository;

  CheckActivityUseCase(this.repository);

  @override
  Future<Result<SlotsModel>> call({required CheckActivityParams params}) {
    return repository.checkActivity(params: params);
  }
}
