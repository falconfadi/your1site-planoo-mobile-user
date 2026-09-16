import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';

class ProfileImageResponse extends ApiResponse<ProfileImageModel> {

  ProfileImageResponse({required super.errors, required super.message, required super.data});

  factory ProfileImageResponse.fromJson(Map<String, dynamic> json) {
    return ProfileImageResponse(
      errors: json["payload"]["errors"] != null
          ? ProfileImageModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: ProfileImageModel.fromJson(json["payload"]),
    );
  }
}

// ignore: must_be_immutable
class ProfileImageModel extends BaseModel {

  ImageModel? profileImageModel;

  ProfileImageModel({
    this.profileImageModel,
  });

  ProfileImageModel.fromJson(Map<String, dynamic> json) {
    profileImageModel = json['profile_image'] != null ? ImageModel.fromJson(json['profile_image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileImageModel != null) {
      data['profile_image'] = profileImageModel!.toJson();
    }
    return data;
  }
}

class ImageModel {

  int? id;
  String? belongToType;
  String? belongToId;
  String? url;
  String? type;
  String? name;
  String? createdAt;
  String? updatedAt;

  ImageModel({
    this.id,
    this.belongToType,
    this.belongToId,
    this.url,
    this.type,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    belongToType = json['belongTo_type'];
    belongToId = json['belongTo_id'];
    url = json['url'];
    type = json['type'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['belongTo_type'] = belongToType;
    data['belongTo_id'] = belongToId;
    data['url'] = url;
    data['type'] = type;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}