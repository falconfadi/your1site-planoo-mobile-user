import 'package:centro/features/category/data/category_repository/category_repository.dart';
import '../../../../../../core/params/base_params.dart';
import '../../../../../../core/results/result.dart';
import '../../../../../../core/usecase/usecase.dart';

class AttendEventParams extends BaseParams {

  final int eventId;

  AttendEventParams({required this.eventId});
}

class AttendEventUseCase extends UseCase<bool, AttendEventParams> {
  final CategoryRepository repository;

  AttendEventUseCase(this.repository);

  @override
  Future<Result<bool>> call({required AttendEventParams params}) {
    return repository.attendEvent(params: params);
  }
}
