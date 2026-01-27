import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/category_model.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class CategoriesParams extends BaseParams {

  CategoriesParams();
}

class CategoriesUseCase extends UseCase<CategoryModel, CategoriesParams> {
  final CategoryRepository repository;

  CategoriesUseCase(this.repository);

  @override
  Future<Result<CategoryModel>> call({required CategoriesParams params}) {
    return repository.getCategories(params: params);
  }
}
