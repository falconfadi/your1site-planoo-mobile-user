import 'package:centro/features/category/data/category_repository/category_repository.dart';
import '../../../../../../core/params/base_params.dart';
import '../../../../../../core/results/result.dart';
import '../../../../../../core/usecase/usecase.dart';

class BookCourtParams extends BaseParams {

  final int courtId;
  final String code;
  final int dayId;
  final String date;
  final int sessionDuration;
  final String time;
  final String? note;

  BookCourtParams({
    required this.courtId,
    required this.code,
    required this.dayId,
    required this.date,
    required this.sessionDuration,
    required this.time,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'activity_id': courtId,
      'code': code,
      'day_id': dayId,
      'date': date,
      'session_duration': sessionDuration,
      'time': time,
      'notes': note,
    };
  }
}

class BookCourtUseCase extends UseCase<bool, BookCourtParams> {
  final CategoryRepository repository;

  BookCourtUseCase(this.repository);

  @override
  Future<Result<bool>> call({required BookCourtParams params}) {
    return repository.bookCourt(params: params);
  }
}
