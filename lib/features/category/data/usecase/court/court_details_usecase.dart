import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/court/court_details_model.dart';
import '../../../../../core/params/base_params.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/usecase/usecase.dart';

class CourtDetailsParams extends BaseParams {

  final int courtId;

  CourtDetailsParams({required this.courtId});
}

class CourtDetailsUseCase extends UseCase<CourtDetailsModel, CourtDetailsParams> {
  final CategoryRepository repository;

  CourtDetailsUseCase(this.repository);

  @override
  Future<Result<CourtDetailsModel>> call({required CourtDetailsParams params}) {
    return repository.getCourtDetails(params: params);
  }
}
