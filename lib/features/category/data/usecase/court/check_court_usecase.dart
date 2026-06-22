import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/court/slots_model.dart';
import '../../../../../../core/params/base_params.dart';
import '../../../../../../core/results/result.dart';
import '../../../../../../core/usecase/usecase.dart';

class CheckCourtParams extends BaseParams {

  final int courtId;
  final int dayId;
  final String date;
  final int sessionDuration;

  CheckCourtParams({
    required this.courtId,
    required this.dayId,
    required this.date,
    required this.sessionDuration,
  });

  Map<String, dynamic> toJson() {
    return {
      'activity_id': courtId,
      'day_id': dayId,
      'date': date,
      'session_duration': sessionDuration,
    };
  }
}

class CheckCourtUseCase extends UseCase<SlotsModel, CheckCourtParams> {
  final CategoryRepository repository;

  CheckCourtUseCase(this.repository);

  @override
  Future<Result<SlotsModel>> call({required CheckCourtParams params}) {
    return repository.checkCourt(params: params);
  }
}
