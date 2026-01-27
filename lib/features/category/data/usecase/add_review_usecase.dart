import 'package:centro/features/category/data/category_repository/category_repository.dart';
import '../../../../../core/params/base_params.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/usecase/usecase.dart';

class AddReviewParams extends BaseParams {

  final int rate;
  final String content;
  final String ownerType;
  final int ownerId;

  AddReviewParams({
    required this.rate,
    required this.content,
    required this.ownerType,
    required this.ownerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "rate": rate,
      "content": content
    };
  }

}

class AddReviewUseCase extends UseCase<bool, AddReviewParams> {
  final CategoryRepository repository;

  AddReviewUseCase(this.repository);

  @override
  Future<Result<bool>> call({required AddReviewParams params}) {
    return repository.addReview(params: params);
  }
}
