import 'package:centro/features/category/data/category_repository/category_repository.dart';
import '../../../../../../core/params/base_params.dart';
import '../../../../../../core/results/result.dart';
import '../../../../../../core/usecase/usecase.dart';

class BookActivityParams extends BaseParams {

  final int activityId;
  final String code;
  final int dayId;
  final String date;
  final int sessionDuration;
  final String time;
  final String? note;

  BookActivityParams({
    required this.activityId,
    required this.code,
    required this.dayId,
    required this.date,
    required this.sessionDuration,
    required this.time,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'activity_id': activityId,
      'code': code,
      'day_id': dayId,
      'date': date,
      'session_duration': sessionDuration,
      'time': time,
      'notes': note,
    };
  }
}

class BookActivityUseCase extends UseCase<bool, BookActivityParams> {
  final CategoryRepository repository;

  BookActivityUseCase(this.repository);

  @override
  Future<Result<bool>> call({required BookActivityParams params}) {
    return repository.bookActivity(params: params);
  }
}
