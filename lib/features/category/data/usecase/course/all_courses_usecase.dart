import 'package:centro/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';
import '../../../../../core/params/base_params.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/usecase/usecase.dart';

class AllCoursesParams extends BaseParams {

  final GetListRequest request;
  final int categoryId;
  final String? price;
  final String? rate;

  AllCoursesParams(this.request,{required this.categoryId,this.price,this.rate});

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

class AllCoursesUseCase extends UseCase<List<CourseDetailsModel>, AllCoursesParams> {
  final CategoryRepository repository;

  AllCoursesUseCase(this.repository);

  @override
  Future<Result<List<CourseDetailsModel>>> call({required AllCoursesParams params}) {
    return repository.getAllCourses(params: params);
  }
}
