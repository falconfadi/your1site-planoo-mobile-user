import 'package:centro/core/constants/end_point.dart';
import 'package:centro/core/data_source/remote_data_source.dart';
import 'package:centro/core/http/http_method.dart';
import 'package:centro/core/repository/core_repository.dart';
import 'package:centro/core/results/result.dart';
import 'package:centro/features/home/data/model/featured_model.dart';
import 'package:centro/features/home/data/model/feeds_model.dart';
import 'package:centro/features/home/data/usecase/featured_usecase.dart';
import 'package:centro/features/home/data/usecase/feeds_usecase.dart';

class HomeRepository extends CoreRepository {

  Future<Result<FeaturedModel>> getFeatured({required FeaturedParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: getFeaturedUrl,
        method: HttpMethod.GET,
        responseStr: 'FeaturedResponse',
        converter: (json) => FeaturedResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<FeedsModel>> getFeeds({required FeedsParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: getFeedsUrl,
        method: HttpMethod.GET,
        responseStr: 'FeedsResponse',
        converter: (json) => FeedsResponse.fromJson(json));
    return call(result: result);
  }

}
