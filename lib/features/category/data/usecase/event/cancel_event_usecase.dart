import 'package:centro/features/category/data/category_repository/category_repository.dart';
import '../../../../../../core/params/base_params.dart';
import '../../../../../../core/results/result.dart';
import '../../../../../../core/usecase/usecase.dart';

class CancelEventParams extends BaseParams {

  final int eventId;

  CancelEventParams({required this.eventId});

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
    };
  }
}

class CancelEventUseCase extends UseCase<bool, CancelEventParams> {
  final CategoryRepository repository;

  CancelEventUseCase(this.repository);

  @override
  Future<Result<bool>> call({required CancelEventParams params}) {
    return repository.cancelEvent(params: params);
  }
}
