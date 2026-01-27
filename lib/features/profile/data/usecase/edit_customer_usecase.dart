import 'package:centro/features/auth/data/model/sign_in_model.dart';
import 'package:centro/features/profile/data/profile_repository/profile_repository.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class EditCustomerParams extends BaseParams {

  final String name;

  EditCustomerParams({required this.name});

  Map<String, String?> toJson() {
    return {
      "name": name,
    };
  }
}

class EditCustomerUseCase extends UseCase<SignInModel, EditCustomerParams> {
  final ProfileRepository repository;

  EditCustomerUseCase(this.repository);

  @override
  Future<Result<SignInModel>> call({required EditCustomerParams params}) {
    return repository.editCustomer(params: params);
  }
}