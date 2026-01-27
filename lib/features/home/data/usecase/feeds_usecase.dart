import 'package:centro/features/home/data/home_repository/home_repository.dart';
import 'package:centro/features/home/data/model/feeds_model.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class FeedsParams extends BaseParams {

  FeedsParams();
}

class FeedsUseCase extends UseCase<FeedsModel, FeedsParams> {
  final HomeRepository repository;

  FeedsUseCase(this.repository);

  @override
  Future<Result<FeedsModel>> call({required FeedsParams params}) {
    return repository.getFeeds(params: params);
  }
}
