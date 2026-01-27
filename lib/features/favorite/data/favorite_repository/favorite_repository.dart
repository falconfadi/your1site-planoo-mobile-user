import 'package:centro/core/constants/end_point.dart';
import 'package:centro/core/data_source/remote_data_source.dart';
import 'package:centro/core/http/http_method.dart';
import 'package:centro/core/repository/core_repository.dart';
import 'package:centro/core/results/result.dart';
import 'package:centro/features/favorite/data/model/favorites_model.dart';
import 'package:centro/features/favorite/data/usecase/add_favorite_usecase.dart';
import 'package:centro/features/favorite/data/usecase/delete_favorite_usecase.dart';
import 'package:centro/features/favorite/data/usecase/favorites_usecase.dart';

class FavoriteRepository extends CoreRepository {

  Future<Result<FavoritesModel>> getFavorites({required FavoritesParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: getFavoritesUrl,
        method: HttpMethod.GET,
        responseStr: 'FavoritesResponse',
        converter: (json) => FavoritesResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<bool>> addFavorite({required AddFavoriteParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: true,
      url: "$addFavoriteUrl${params.ownerType}/${params.ownerId}",
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }

  Future<Result<bool>> deleteFavorite({required DeleteFavoriteParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: true,
      url: deleteFavoriteUrl,
      data: params.toJson(),
      method: HttpMethod.DELETE,
    );
    return noModelCall(result: result);
  }

}
