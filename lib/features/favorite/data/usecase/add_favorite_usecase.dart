import 'package:centro/features/favorite/data/favorite_repository/favorite_repository.dart';
import '../../../../../core/params/base_params.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/usecase/usecase.dart';

class AddFavoriteParams extends BaseParams {

  final String ownerType;
  final int ownerId;

  AddFavoriteParams({
    required this.ownerType,
    required this.ownerId,
  });
}

class AddFavoriteUseCase extends UseCase<bool, AddFavoriteParams> {
  final FavoriteRepository repository;

  AddFavoriteUseCase(this.repository);

  @override
  Future<Result<bool>> call({required AddFavoriteParams params}) {
    return repository.addFavorite(params: params);
  }
}
