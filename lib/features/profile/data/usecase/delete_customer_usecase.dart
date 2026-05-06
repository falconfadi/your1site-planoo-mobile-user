import 'package:centro/features/profile/data/profile_repository/profile_repository.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class DeleteCustomerParams extends BaseParams {

  DeleteCustomerParams();

}

class DeleteCustomerUseCase extends UseCase<bool, DeleteCustomerParams> {
  final ProfileRepository repository;

  DeleteCustomerUseCase(this.repository);

  @override
  Future<Result<bool>> call({required DeleteCustomerParams params}) {
    return repository.deleteCustomer(params: params);
  }
}
