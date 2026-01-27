
import 'package:centro/features/profile/data/model/profile_image_model.dart';

class CustomerModel {

  int? id;
  String? name;
  int? status;
  String? isVerified;
  bool? isNotifiable;
  int? isActive;
  ImageModel? profileImage;

  CustomerModel({
    this.id,
    this.name,
    this.status,
    this.isVerified,
    this.isNotifiable,
    this.isActive,
    // this.profileImage
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    isVerified = json['is_verified'];
    isNotifiable = json['is_notifiable'];
    isActive = json['is_active'];
    profileImage = json['profile_image'] != null ? ImageModel.fromJson(json['profile_image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['is_verified'] = isVerified;
    data['is_notifiable'] = isNotifiable;
    data['is_active'] = isActive;
    if (profileImage != null) {
      data['profile_image'] = profileImage!.toJson();
    }
    return data;
  }
}