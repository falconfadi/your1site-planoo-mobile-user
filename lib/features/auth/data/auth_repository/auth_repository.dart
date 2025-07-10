import 'package:centro/core/repository/core_repository.dart';


class AuthRepository extends CoreRepository {

  // Future<Result<bool>> register({required RegisterParams params}) async {
  //   final result = await RemoteDataSource.noModelRequest(
  //       withAuthentication: false,
  //       url: registerUrl,
  //       data: params.toJson(),
  //       method: HttpMethod.POST
  //   );
  //   return noModelCall(result: result);
  // }
  //
  // Future<Result<bool>> verify({required VerifyCodeParams params}) async {
  //   final result = await RemoteDataSource.noModelRequest(
  //     data: params.toJson(),
  //     withAuthentication: false,
  //     url: verifyUrl,
  //     method: HttpMethod.POST,
  //   );
  //   return noModelCall(result: result);
  // }
  //
  // Future<Result<LoginModel>> login({required LoginParams params}) async {
  //   final result = await RemoteDataSource.request(
  //       withAuthentication: false,
  //       url: loginUrl,
  //       data: params.toJson(),
  //       method: HttpMethod.POST,
  //       responseStr: 'LoginResponse',
  //       converter: (json) => LoginResponse.fromJson(json));
  //   return call(result: result);
  // }
  //
  // Future<Result<bool>> resendCode({required ResendCodeParams params}) async {
  //   final result = await RemoteDataSource.noModelRequest(
  //     withAuthentication: false,
  //     url: resendCodeUrl,
  //     data: params.toJson(),
  //     method: HttpMethod.POST,
  //   );
  //   return noModelCall(result: result);
  // }
  //
  // Future<Result<bool>> forgetPassword({required ForgetPasswordParams params}) async {
  //   final result = await RemoteDataSource.noModelRequest(
  //       withAuthentication: false,
  //       url: forgetPasswordUrl,
  //       data: params.toJson(),
  //       method: HttpMethod.POST,
  //   );
  //   return noModelCall(result: result);
  // }
  //
  // Future<Result<bool>> resetPassword({required ResetPasswordParams params}) async {
  //   final result = await RemoteDataSource.noModelRequest(
  //     data: params.toJson(),
  //     withAuthentication: false,
  //     url: resetPasswordUrl,
  //     method: HttpMethod.POST,
  //   );
  //   return noModelCall(result: result);
  // }
  //
  // Future<Result<bool>> logout({required LogoutParams params}) async {
  //   final result = await RemoteDataSource.noModelRequest(
  //     withAuthentication: true,
  //     url: logoutUrl,
  //     method: HttpMethod.POST,
  //   );
  //   return noModelCall(result: result);
  // }
  //
  // Future<Result<bool>> changePassword({required ChangePasswordParams params}) async {
  //   final result = await RemoteDataSource.noModelRequest(
  //     data: params.toJson(),
  //     withAuthentication: true,
  //     url: changePasswordUrl,
  //     method: HttpMethod.POST,
  //   );
  //   return noModelCall(result: result);
  // }

}