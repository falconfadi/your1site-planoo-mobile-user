import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/auth/data/model/customer_model.dart';

class SignInResponse extends ApiResponse<SignInModel> {

  SignInResponse({required super.errors, required super.message, required super.data});

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      errors: json["payload"]["errors"] != null
          ? SignInModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: SignInModel.fromJson(json["payload"]),
    );
  }
}

// ignore: must_be_immutable
class SignInModel extends BaseModel{

  CustomerModel? customer;
  String? token;

  SignInModel({
    this.customer,
    this.token
  });

  SignInModel.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null ? CustomerModel.fromJson(json['customer']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['token'] = token;
    return data;
  }
}


