import 'package:centro/core/repository/core_repository.dart';
import 'package:centro/features/auth/data/model/sign_in_model.dart';
import 'package:centro/features/profile/data/model/profile_image_model.dart';
import 'package:centro/features/profile/data/usecase/delete_profile_image_usecase.dart';
import 'package:centro/features/profile/data/usecase/edit_customer_usecase.dart';
import 'package:centro/features/profile/data/usecase/get_customer_usecase.dart';
import 'package:centro/features/profile/data/usecase/upload_profile_image_usecase.dart';
import '../../../../core/constants/end_point.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';

class ProfileRepository extends CoreRepository {

  Future<Result<SignInModel>> getCustomer({required GetCustomerParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: getCustomerUrl,
        method: HttpMethod.GET,
        responseStr: 'SignInResponse',
        converter: (json) => SignInResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<ProfileImageModel>> uploadProfileImage({required UploadProfileImageParams params}) async {
    final result = await RemoteDataSource.upload(
      withAuthentication: true,
      url: uploadProfileImageUrl,
      responseStr: 'ProfileImageModel',
      converter: (json) => ProfileImageModel.fromJson(json),
      filesMap: {
        'profile_image': [params.file],
      },
    );
    return call(result: result);
  }

  Future<Result<bool>> deleteProfileImage({required DeleteProfileImageParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: true,
      url: deleteProfileImageUrl,
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }

  Future<Result<SignInModel>> editCustomer({required EditCustomerParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: editCustomerUrl,
        data: params.toJson(),
        method: HttpMethod.POST,
        responseStr: 'SignInResponse',
        converter: (json) => SignInResponse.fromJson(json));
    return call(result: result);
  }

}