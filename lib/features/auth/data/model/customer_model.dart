import 'package:centro/features/profile/data/model/profile_image_model.dart';

class CustomerModel {

  int? id;
  String? name;
  String? email;
  String? gender;
  String? birthdate;
  int? status;
  String? isVerified;
  bool? isNotifiable;
  int? isActive;
  ImageModel? profileImage;
  int? remainingSessions;
  int? isComplete;

  CustomerModel({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.birthdate,
    this.status,
    this.isVerified,
    this.isNotifiable,
    this.isActive,
    this.profileImage,
    this.remainingSessions,
    this.isComplete,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    status = json['status'];
    isVerified = json['is_verified'];
    isNotifiable = json['is_notifiable'];
    isActive = json['is_active'];
    profileImage = json['profile_image'] != null ? ImageModel.fromJson(json['profile_image']) : null;
    remainingSessions = json['remaining_sessions'];
    isComplete = json['is_complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['birthdate'] = birthdate;
    data['status'] = status;
    data['is_verified'] = isVerified;
    data['is_notifiable'] = isNotifiable;
    data['is_active'] = isActive;
    if (profileImage != null) {
      data['profile_image'] = profileImage!.toJson();
    }
    data['remaining_sessions'] = remainingSessions;
    data['is_complete'] = isComplete;
    return data;
  }
}