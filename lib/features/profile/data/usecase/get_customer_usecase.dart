import 'package:centro/features/auth/data/model/sign_in_model.dart';
import 'package:centro/features/profile/data/profile_repository/profile_repository.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class GetCustomerParams extends BaseParams {

  GetCustomerParams();
}

class GetCustomerUseCase extends UseCase<SignInModel, GetCustomerParams> {
  final ProfileRepository repository;

  GetCustomerUseCase(this.repository);

  @override
  Future<Result<SignInModel>> call({required GetCustomerParams params}) {
    return repository.getCustomer(params: params);
  }
}