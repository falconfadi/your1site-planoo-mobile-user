import 'package:centro/features/home/data/home_repository/home_repository.dart';
import 'package:centro/features/home/data/model/featured_model.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class FeaturedParams extends BaseParams {

  FeaturedParams();
}

class FeaturedUseCase extends UseCase<FeaturedModel, FeaturedParams> {
  final HomeRepository repository;

  FeaturedUseCase(this.repository);

  @override
  Future<Result<FeaturedModel>> call({required FeaturedParams params}) {
    return repository.getFeatured(params: params);
  }
}
