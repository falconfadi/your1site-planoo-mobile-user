import 'package:centro/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:centro/core/boilerplate/get_model/cubits/get_model_cubit.dart';
import 'package:centro/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/custom_rating_bar.dart';
import 'package:centro/core/ui/shared_widgets/expandable_text_widget.dart';
import 'package:centro/core/ui/shared_widgets/icon_text_widget.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/ui/widgets/custom_sheet.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/project_utils/open_url.dart';
import 'package:centro/core/utils/project_utils/string_utils.dart';
import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/activity/activity_details_model.dart';
import 'package:centro/features/category/data/model/review_model.dart';
import 'package:centro/features/category/data/usecase/activity/activity_details_usecase.dart';
import 'package:centro/features/category/data/usecase/reviews_usecase.dart';
import 'package:centro/features/category/ui/booking_screen.dart';
import 'package:centro/features/category/widget/add_review_sheet.dart';
import 'package:centro/features/category/widget/images_slider_widget.dart';
import 'package:centro/features/category/widget/reviews_sheet.dart';
import 'package:centro/features/favorite/data/favorite_repository/favorite_repository.dart';
import 'package:centro/features/favorite/data/usecase/add_favorite_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityDetailsScreen extends StatefulWidget {

  final int activityId;

  const ActivityDetailsScreen({super.key,required this.activityId});

  @override
  State<ActivityDetailsScreen> createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {

  GetModelCubit<ActivityDetailsModel>? activityCubit;
  GetModelCubit<ReviewModel>? reviewCubit;
  ActivityDetailsModel? activity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: CustomHeader(title: "",isNavBar: false),
      body: GetModel<ActivityDetailsModel>(
        onCubitCreated: (cubit) {
          activityCubit = cubit as GetModelCubit<ActivityDetailsModel>;
        },
        useCaseCallBack: () {
          return ActivityDetailsUseCase(CategoryRepository()).call(
              params: ActivityDetailsParams(activityId: widget.activityId));
        },
        onSuccess: (result) {
          setState(() {
            activity = result;
          });
        },
        modelBuilder: (model) => SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ImagesSliderWidget(imgList: model.mediaList!),
                  Positioned(
                    bottom: 0,
                    right: 20.w,
                    child: Container(
                      width: 45.w,
                      height: 45.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor
                      ),
                      child: CreateModel(
                        key: ValueKey(model.isFavorite),
                        withValidation: false,
                          onTap: () async {},
                          onSuccess: (result) {
                            activityCubit!.getModel(silent: true);
                          },
                          useCaseCallBack: (data) {
                            if(model.isFavorite == false) {
                              return AddFavoriteUseCase(FavoriteRepository()).call(
                                  params: AddFavoriteParams(
                                    ownerType: "activity",
                                    ownerId: model.iD!,
                                  ));
                            }
                          },
                          child: Icon(model.isFavorite == false ? Icons.favorite_border_outlined : Icons.favorite,color: AppColors.redColor,size: 35.sp),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(model.name!,style: AppTheme.bodyLarge.copyWith(fontSize: 20.sp)),
                        ),
                        SizedBox(width: 10.w),
                        Text("${model.price} ${AppLocalization.of(context).translate("syr")}",
                            style: AppTheme.bodyLarge.copyWith(color: AppColors.primaryColor, fontSize: 20.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(AppLocalization.of(context).translate("activity"),
                              style: AppTheme.labelLarge.copyWith(fontSize: 15.sp,color: AppColors.purpleColor)),
                        ),
                        SizedBox(width: 10.w),
                        Text("/${model.category!.name}",
                          style: AppTheme.titleMedium.copyWith(color: AppColors.gray3Color),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              String activityUrl = 'https://www.google.com/maps/search/?api=1&query=${model.location!.lat!},${model.location!.long!}';
                              OpenUrl.launchUrls(Uri.parse(activityUrl));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SvgPicture.asset(location,color: AppColors.mediumGrayColor),
                                Text(AppLocalization.of(context).translate("view_map"),
                                    style: AppTheme.titleMedium.copyWith(color: AppColors.mediumGrayColor)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomRatingBar(rate: model.rate!.toDouble(),size: 20.sp),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: GetModel<ReviewModel>(
                                  useCaseCallBack: () => ReviewsUseCase(CategoryRepository()).call(
                                      params: ReviewsParams(ownerType: "activity", ownerId: model.iD!)
                                  ),
                                  onCubitCreated: (cubit) {
                                    reviewCubit = cubit as GetModelCubit<ReviewModel>;
                                  },
                                  onError: (error) {
                                    if (error.contains("Not found")) {
                                      return ReviewModel(reviewsList: []);
                                    }
                                    return null;
                                  },
                                  modelBuilder: (reviewModel) {
                                    return InkWell(
                                      onTap: () {
                                        CustomSheet.show(
                                            isDismissible: true,
                                            header: Text(AppLocalization.of(context).translate("reviews"),
                                              style: AppTheme.titleLarge.copyWith(fontSize: 18.sp),
                                            ),
                                            action: InkWell(
                                                onTap: () {
                                                  CustomSheet.show(
                                                      isDismissible: true,
                                                      header: Center(),
                                                      padding: 30.w,
                                                      context: context,
                                                      child: AddReviewSheet(ownerType: "activity", ownerId: model.iD!,
                                                        onRefresh: () async {
                                                          // todo check later
                                                          reviewCubit!.getModel(silent: true);
                                                          activityCubit!.getModel(silent: true);
                                                        },
                                                      )
                                                  );
                                                },
                                                child: Icon(Icons.add_circle_outline_outlined,color: AppColors.primaryColor)),
                                            padding: 30.w,
                                            context: context,
                                            height: reviewModel.reviewsList!.isEmpty ? null :  1.sh * 0.9.h,
                                            child: ReviewsSheet(reviews: reviewModel.reviewsList)
                                        );
                                      },
                                      child: Text("(${truncateNumber( reviewModel.reviewsList!.length,maxLength: 8)} ${AppLocalization.of(context).translate("reviews")})",
                                          maxLines: 1,overflow: TextOverflow.ellipsis,
                                          style: AppTheme.labelLarge.copyWith(color: reviewModel.reviewsList!.isEmpty ? AppColors.mediumGrayColor : AppColors.purpleColor,fontSize: 18.sp)),
                                    );
                                  }
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          flex: 1,
                          child: IconTextWidget(
                              icon: time,
                              iconSize: 20.w,
                              iconColor: AppColors.gray3Color,
                              text: model.sessionDuration!.toString() + AppLocalization.of(context).translate("minute"),
                              maxline: 1,
                              textStyle: AppTheme.titleMedium.copyWith(color: AppColors.gray3Color,overflow: TextOverflow.ellipsis)),
                        )
                      ],
                    ),
                    model.facilitiesList!.isEmpty ? Center() :
                    SizedBox(
                      height: 120.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: model.facilitiesList!.length,
                        itemBuilder: (context,index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(child: CachedImage(width: 50.w,height: 50.w,imageUrl: model.facilitiesList![index].icon!, fit: BoxFit.cover)),
                                SizedBox(height: 10.h),
                                Flexible(child: Text(model.facilitiesList![index].name!,style: AppTheme.headlineSmall)),
                              ],
                            ),
                          );
                        },
                      )
                    ),
                    SizedBox(height: model.facilitiesList!.isEmpty ? 0 : 10.h),
                    ExpandableTextWidget(
                      text: model.description!,
                      style: AppTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: activity == null
          ? const SizedBox.shrink() : Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 15.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.grayColor,
              spreadRadius: 0,
              blurRadius: 8,
            )
          ],
        ),
        child: CustomButton(
          backgroundColor: activity!.isActive == false ?
          AppColors.grayColor : AppColors.primaryColor,
          borderRadius: 30.r,
          buttonName: AppLocalization.of(context).translate("book_now"),
          function: () {
            if(activity != null) {
              if(activity!.isActive == true) {
                Navigation.push(BookingScreen(activity: activity!));
              }
            }
          },
        ),
      ),
    );
  }
}