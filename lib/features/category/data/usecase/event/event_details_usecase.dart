import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';
import '../../../../../core/params/base_params.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/usecase/usecase.dart';

class EventDetailsParams extends BaseParams {

  final int eventId;

  EventDetailsParams({required this.eventId});
}

class EventDetailsUseCase extends UseCase<EventDetailsModel, EventDetailsParams> {
  final CategoryRepository repository;

  EventDetailsUseCase(this.repository);

  @override
  Future<Result<EventDetailsModel>> call({required EventDetailsParams params}) {
    return repository.getEventDetails(params: params);
  }
}
