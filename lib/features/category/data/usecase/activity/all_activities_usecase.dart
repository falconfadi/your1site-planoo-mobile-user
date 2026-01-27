import 'package:centro/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/activity/activity_details_model.dart';
import '../../../../../core/params/base_params.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/usecase/usecase.dart';

class AllActivitiesParams extends BaseParams {

  final GetListRequest request;
  final int categoryId;
  final String? price;
  final String? rate;

  AllActivitiesParams(this.request,{required this.categoryId,this.price,this.rate});

  Map<String, dynamic> toJson() {
    return {
      "pageOption": request.toJson(),
      if (rate != null || price != null) "orderBy": {
        if(rate != null) "rate": rate,
        if(price != null) "price": price
      },
      "filters":{
        "category_id": categoryId
      },
    };
  }
}

class AllActivitiesUseCase extends UseCase<List<ActivityDetailsModel>, AllActivitiesParams> {
  final CategoryRepository repository;

  AllActivitiesUseCase(this.repository);

  @override
  Future<Result<List<ActivityDetailsModel>>> call({required AllActivitiesParams params}) {
    return repository.getAllActivities(params: params);
  }
}
