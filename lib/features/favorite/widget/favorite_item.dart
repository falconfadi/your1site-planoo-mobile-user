import 'package:centro/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/category/ui/activity_details_screen.dart';
import 'package:centro/features/category/ui/course_details_screen.dart';
import 'package:centro/features/category/ui/event_details_screen.dart';
import 'package:centro/features/favorite/data/favorite_repository/favorite_repository.dart';
import 'package:centro/features/favorite/data/model/favorites_model.dart';
import 'package:centro/features/favorite/data/usecase/delete_favorite_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteItem extends StatelessWidget {

  final FavoriteItemModel favorite;
  final VoidCallback? onRefresh;

  const FavoriteItem({super.key, required this.favorite,this.onRefresh});

  Holder get holder => favorite.holder!;

  String? get imageUrl {
    if (holder is EventHolderModel) {
      return (holder as EventHolderModel).mediaList!.first.url;
    }
    if (holder is CourseHolderModel) {
      return (holder as CourseHolderModel).mediaList!.first.url;
    }
    return (holder as ActivityHolderModel).mediaList!.first.url;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (holder is ActivityHolderModel) {
          Navigation.push(
            ActivityDetailsScreen(activityId: holder.id),
          );
        } else if (holder is CourseHolderModel) {
          Navigation.push(CourseDetailsScreen(courseId: holder.id));
        } else if (holder is EventHolderModel) {
          Navigation.push(EventDetailsScreen(eventId: holder.id));
        }
      },
      child: Container(
        width: 1.sw,
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    bottomLeft: Radius.circular(15.r),
                  ),
                ),
                child: CachedImage(
                  imageUrl: imageUrl ?? "",
                  fit: BoxFit.fill,
                  height: 85.h,
                  borderRadius: 10.r,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r),
                  ),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(holder.name, style: AppTheme.bodyMedium.copyWith(color: AppColors.darkGrayColor),maxLines: 1,overflow: TextOverflow.ellipsis),
                        SizedBox(width: 10.w),
                        CreateModel(
                          key: ValueKey(favorite.id),
                            withValidation: false,
                            onTap: () async {},
                            onSuccess: (result) {
                              onRefresh!.call();
                            },
                            useCaseCallBack: (data) {
                              return DeleteFavoriteUseCase(FavoriteRepository()).call(
                                  params: DeleteFavoriteParams(
                                    favoriteId: favorite.id!,
                                  ));
                            },
                            child: Icon(Icons.favorite,color: AppColors.redColor)
                        ),
                      ],
                    ),
                    SizedBox(height: 5.w),
                    Text(holder.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.labelMedium.copyWith(color: AppColors.mediumGrayColor),
                    ),
                    SizedBox(height: 5.w),
                    Text(AppLocalization.of(context).translate(
                        (holder is ActivityHolderModel) ? "activity" : (holder is CourseHolderModel) ? "course" : "event"),
                        style: AppTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

