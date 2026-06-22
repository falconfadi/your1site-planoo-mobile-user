import 'package:centro/core/data_source/model.dart';
import 'package:centro/core/responses/api_response.dart';
import 'package:centro/features/profile/data/model/profile_image_model.dart';

class FavoritesResponse extends ApiResponse<FavoritesModel> {

  FavoritesResponse({required super.errors, required super.message, required super.data});

  factory FavoritesResponse.fromJson(Map<String, dynamic> json) {
    return FavoritesResponse(
      errors: json["payload"]["errors"] != null
          ? FavoritesModel.fromJson(json["payload"]["errors"])
          : null,
      message: json["message"],
      data: FavoritesModel.fromJson(json["payload"]),
    );
  }
}

class FavoritesModel extends BaseModel {

  List<FavoriteItemModel>? favoritesList;

  FavoritesModel({this.favoritesList});

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    if (json['favorites'] != null) {
      favoritesList = <FavoriteItemModel>[];
      json['favorites'].forEach((v) {
        favoritesList!.add(FavoriteItemModel.fromJson(v));
      });
    }
  }
}

class FavoriteItemModel {

  int? id;
  int? customerId;
  String? favoritableType;
  int? favoritableId;
  String? createdAt;
  String? updatedAt;
  Holder? holder;

  FavoriteItemModel({
   this.id,
   this.customerId,
   this.favoritableType,
   this.favoritableId,
   this.createdAt,
   this.updatedAt,
   this.holder,
  });

  FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    Holder parsedHolder;
    switch (json['favoritable_type']) {
      case 'App\\Models\\Event':
        parsedHolder = EventHolderModel.fromJson(json['holder']);
        break;
      case 'App\\Models\\Course':
        parsedHolder = CourseHolderModel.fromJson(json['holder']);
        break;
      case 'App\\Models\\Activity':
        parsedHolder = CourtHolderModel.fromJson(json['holder']);
        break;
      default:
        throw "";
    }
    id = json['id'];
    customerId = json['customer_id'];
    favoritableType = json['favoritable_type'];
    favoritableId = json['favoritable_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    holder = parsedHolder;
  }
}

abstract class Holder {
  final int id;
  final int userId;
  final int categoryId;
  final String name;
  final String description;

  Holder({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.name,
    required this.description,
  });
}

class EventHolderModel extends Holder {
  bool? isActive;
  bool? isFull;
  int? eventDuration;
  int? capacity;
  int? rate;
  int? admissionFee;
  int? withdrawalFee;
  int? status;
  String? startDate;
  String? endDate;
  List<ImageModel>? mediaList;

  EventHolderModel({
    required super.id,
    required super.userId,
    required super.categoryId,
    required super.name,
    required super.description,
    this.isActive,
    this.isFull,
    this.eventDuration,
    this.capacity,
    this.rate,
    this.admissionFee,
    this.withdrawalFee,
    this.status,
    this.startDate,
    this.endDate,
    this.mediaList,
  });

  EventHolderModel.fromJson(Map<String, dynamic> json)  : super(
    id: json['id'],
    userId: json['user_id'],
    categoryId: json['category_id'],
    name: json['name'],
    description: json['description'],
  ) {
    isActive = json['is_active'];
    isFull = json['is_full'];
    eventDuration = json['event_duration'];
    capacity = json['capacity'];
    rate = json['rate'];
    admissionFee = json['admission_fee'];
    withdrawalFee = json['withdrawal_fee'];
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    if (json['medias'] != null) {
      mediaList = <ImageModel>[];
      json['medias'].forEach((v) {
        mediaList!.add(ImageModel.fromJson(v));
      });
    }
  }
}

class CourseHolderModel extends Holder {
  bool? isActive;
  bool? isFull;
  int? price;
  int? sessionDuration;
  int? courseDuration;
  int? capacity;
  int? rate;
  int? cancellationFee;
  List<ImageModel>? mediaList;

  CourseHolderModel({
    required super.id,
    required super.userId,
    required super.categoryId,
    required super.name,
    required super.description,
    this.isActive,
    this.isFull,
    this.price,
    this.sessionDuration,
    this.courseDuration,
    this.capacity,
    this.rate,
    this.cancellationFee,
    this.mediaList,
  });

  CourseHolderModel.fromJson(Map<String, dynamic> json)  : super(
    id: json['id'],
    userId: json['user_id'],
    categoryId: json['category_id'],
    name: json['name'],
    description: json['description'],
  ) {
    isActive = json['is_active'];
    isFull = json['is_full'];
    price = json['price'];
    sessionDuration = json['session_duration'];
    courseDuration = json['course_duration'];
    capacity = json['capacity'];
    rate = json['rate'];
    cancellationFee = json['cancellation_fee'];
    if (json['medias'] != null) {
      mediaList = <ImageModel>[];
      json['medias'].forEach((v) {
        mediaList!.add(ImageModel.fromJson(v));
      });
    }
  }
}

class CourtHolderModel extends Holder {
  int? price;
  int? sessionDuration;
  bool? isActive;
  int? rate;
  List<ImageModel>? mediaList;

  CourtHolderModel({
    required super.id,
    required super.userId,
    required super.categoryId,
    required super.name,
    required super.description,
    this.price,
    this.sessionDuration,
    this.isActive,
    this.rate,
    this.mediaList,
  });

  CourtHolderModel.fromJson(Map<String, dynamic> json)  : super(
    id: json['id'],
    userId: json['user_id'],
    categoryId: json['category_id'],
    name: json['name'],
    description: json['description'],
  ) {
    isActive = json['is_active'];
    price = json['price'];
    sessionDuration = json['session_duration'];
    rate = json['rate'];
    if (json['medias'] != null) {
      mediaList = <ImageModel>[];
      json['medias'].forEach((v) {
        mediaList!.add(ImageModel.fromJson(v));
      });
    }
  }
}

