import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../auth_repository/auth_repository.dart';

class RegisterParams extends BaseParams {

  final String? name,phone,email,gender,birthdate,password,confirmationPassword,firebaseToken;

  RegisterParams({
    this.name,
    this.phone,
    this.email,
    this.gender,
    this.birthdate,
    this.password,
    this.confirmationPassword,
    this.firebaseToken,
  });

  Map<String, String?> toJson() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "gender": gender,
      "birthdate": birthdate,
      "password": password,
      "password_confirmation": confirmationPassword,
      "firebase_token": firebaseToken
    };
  }
}


class RegisterUseCase extends UseCase<bool, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Result<bool>> call({required RegisterParams params}) {
    return repository.register(params: params);
  }
}
