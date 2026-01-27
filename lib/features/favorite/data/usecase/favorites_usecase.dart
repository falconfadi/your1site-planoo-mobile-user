import 'package:centro/features/favorite/data/favorite_repository/favorite_repository.dart';
import 'package:centro/features/favorite/data/model/favorites_model.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class FavoritesParams extends BaseParams {

  FavoritesParams();
}

class FavoritesUseCase extends UseCase<FavoritesModel, FavoritesParams> {

  final FavoriteRepository repository;

  FavoritesUseCase(this.repository);

  @override
  Future<Result<FavoritesModel>> call({required FavoritesParams params}) {
    return repository.getFavorites(params: params);
  }
}
