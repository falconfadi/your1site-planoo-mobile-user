import 'package:centro/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';
import '../../../../../core/params/base_params.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/usecase/usecase.dart';

class AllEventsParams extends BaseParams {

  final GetListRequest request;
  final int categoryId;
  final String? price;
  final String? rate;

  AllEventsParams(this.request,{required this.categoryId,this.price,this.rate});

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

class AllEventsUseCase extends UseCase<List<EventDetailsModel>, AllEventsParams> {
  final CategoryRepository repository;

  AllEventsUseCase(this.repository);

  @override
  Future<Result<List<EventDetailsModel>>> call({required AllEventsParams params}) {
    return repository.getAllEvents(params: params);
  }
}
