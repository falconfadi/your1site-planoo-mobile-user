import 'package:centro/features/favorite/data/favorite_repository/favorite_repository.dart';
import '../../../../../core/params/base_params.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/usecase/usecase.dart';

class DeleteFavoriteParams extends BaseParams {

  final int favoriteId;

  DeleteFavoriteParams({
    required this.favoriteId
  });

  Map<String, dynamic> toJson() {
    return {
      "favorite_id": favoriteId,
    };
  }
}

class DeleteFavoriteUseCase extends UseCase<bool, DeleteFavoriteParams> {
  final FavoriteRepository repository;

  DeleteFavoriteUseCase(this.repository);

  @override
  Future<Result<bool>> call({required DeleteFavoriteParams params}) {
    return repository.deleteFavorite(params: params);
  }
}
