import 'package:centro/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:centro/core/boilerplate/get_model/cubits/get_model_cubit.dart';
import 'package:centro/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/classes/app_storage.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/dialogs/dialogs.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/custom_info_widget.dart';
import 'package:centro/core/ui/shared_widgets/custom_rating_bar.dart';
import 'package:centro/core/ui/shared_widgets/expandable_text_widget.dart';
import 'package:centro/core/ui/shared_widgets/icon_text_widget.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/ui/widgets/custom_sheet.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/project_utils/open_url.dart';
import 'package:centro/core/utils/project_utils/string_utils.dart';
import 'package:centro/core/utils/responsive/responsive.dart';
import 'package:centro/core/utils/validators/convert_date_time.dart';
import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';
import 'package:centro/features/category/data/model/review_model.dart';
import 'package:centro/features/category/data/usecase/event/cancel_event_usecase.dart';
import 'package:centro/features/category/data/usecase/event/event_details_usecase.dart';
import 'package:centro/features/category/data/usecase/reviews_usecase.dart';
import 'package:centro/features/category/ui/confirm_booking_screen.dart';
import 'package:centro/features/category/widget/add_review_sheet.dart';
import 'package:centro/features/category/widget/facilities_preview_widget.dart';
import 'package:centro/features/category/widget/images_slider_widget.dart';
import 'package:centro/features/category/widget/reviews_sheet.dart';
import 'package:centro/features/category/widget/workdays_preview_widget.dart';
import 'package:centro/features/favorite/data/favorite_repository/favorite_repository.dart';
import 'package:centro/features/favorite/data/usecase/add_favorite_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventDetailsScreen extends StatefulWidget {

  final int eventId;

  const EventDetailsScreen({super.key,required this.eventId});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen>  with TickerProviderStateMixin {

  GetModelCubit<EventDetailsModel>? eventCubit;
  GetModelCubit<ReviewModel>? reviewCubit;
  EventDetailsModel? event;
  bool isExpanded = false;
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 150,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: CustomHeader(title: "",isNavBar: false),
      body: GetModel<EventDetailsModel>(
        onCubitCreated: (cubit) {
          eventCubit = cubit as GetModelCubit<EventDetailsModel>;
        },
        useCaseCallBack: () {
          return EventDetailsUseCase(CategoryRepository()).call(
              params: EventDetailsParams(eventId: widget.eventId));
        },
        onSuccess: (result) {
          setState(() {
            event = result;
          });
        },
        modelBuilder: (model) => SingleChildScrollView(
          controller: scrollController,
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
                          eventCubit!.getModel(silent: true);
                        },
                        useCaseCallBack: (data) {
                          if(model.isFavorite == false) {
                            return AddFavoriteUseCase(FavoriteRepository()).call(
                                params: AddFavoriteParams(
                                  ownerType: "event",
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
                        Text("${model.admissionFee} ${AppLocalization.of(context).translate("syr")}",
                          style: AppTheme.bodyLarge.copyWith(color: AppColors.primaryColor, fontSize: 20.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(AppLocalization.of(context).translate("event"),
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
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                                SvgPicture.asset(location,color: AppColors.mediumGrayColor,width: 24.w),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRatingBar(rate: model.rate!.toDouble(),size: 20.sp),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: GetModel<ReviewModel>(
                              useCaseCallBack: () => ReviewsUseCase(CategoryRepository()).call(
                                  params: ReviewsParams(ownerType: "event", ownerId: model.iD!)
                              ),
                              onCubitCreated: (cubit) {
                                reviewCubit = cubit as GetModelCubit<ReviewModel>;
                              },
                              onError: (error) {
                                if ((AppStorage.languageCode == "en" && error.contains("reviews not found")) ||
                                    AppStorage.languageCode == "ar" && error.contains("التعليقات غير موجود")
                                ) {
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
                                                  child: AddReviewSheet(ownerType: "event", ownerId: model.iD!,
                                                    onRefresh: () async {
                                                      reviewCubit!.getModel(silent: true);
                                                      eventCubit!.getModel(silent: true);
                                                    },
                                                  )
                                              );
                                            },
                                            child: Icon(Icons.add_circle_outline_outlined,color: AppColors.primaryColor,size: isTablet ? 25.sp : null)),
                                        padding: 30.w,
                                        context: context,
                                        height: reviewModel.reviewsList!.isEmpty ? null :  1.sh * 0.9,
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
                    SizedBox(height: 15.h),
                    ExpandableTextWidget(
                      text: model.description!,
                      style: AppTheme.labelLarge,
                    ),
                    SizedBox(height: 15.h),
                    WorkdaysPreviewWidget(workdaysList: model.workdaysList!),
                    SizedBox(height: model.facilitiesList!.isEmpty ? 0 : 15.h),
                    model.facilitiesList!.isEmpty ? Center() :
                    FacilitiesPreviewWidget(facilitiesList: model.facilitiesList!),
                    SizedBox(height: 15.h),
                    Card(
                      color: AppColors.extraLightGrayColor,
                      elevation: 3,
                      shadowColor: AppColors.gray2Color,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                                if(isExpanded) {
                                  Future.delayed(const Duration(milliseconds: 300), () {
                                    _scrollToBottom();
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 5.h),
                                      child: Text(AppLocalization.of(context).translate("details"),
                                        style: AppTheme.headlineSmall,
                                      ),
                                    ),
                                  ),
                                  Icon(isExpanded ? Icons.arrow_circle_down_outlined :
                                  AppStorage.languageCode == "ar" ?
                                  Icons.arrow_circle_left_outlined :
                                  Icons.arrow_circle_right_outlined,color: AppColors.purpleColor,
                                    size: isTablet ? 22.sp : null,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: !isExpanded ? 0 : 20.h),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: isExpanded
                                  ? Column(
                                children: [
                                  CustomInfoWidget(
                                      title: AppLocalization.of(context).translate("event_duration"),
                                      subTitle: model.eventDuration.toString() + AppLocalization.of(context).translate("day")
                                  ),
                                  CustomInfoWidget(
                                    title: AppLocalization.of(context).translate("admission_fee"),
                                    subTitle: "${model.admissionFee} ${AppLocalization.of(context).translate("syr")}",
                                  ),
                                  CustomInfoWidget(
                                    title: AppLocalization.of(context).translate("cancellation_fee"),
                                    subTitle: "${model.withdrawalFee} ${AppLocalization.of(context).translate("syr")}",
                                  ),
                                  CustomInfoWidget(
                                      title: AppLocalization.of(context).translate("start_date"),
                                      subTitle: convertDate(date: model.startDate!,format: "dd/MM/yyyy")
                                  ),
                                  CustomInfoWidget(
                                      title: AppLocalization.of(context).translate("end_date"),
                                      subTitle: convertDate(date: model.endDate!,format: "dd/MM/yyyy")
                                  ),
                                  CustomInfoWidget(title: AppLocalization.of(context).translate("status"),
                                    subTitle: model.status!,
                                  ),
                                  CustomInfoWidget(
                                      title: AppLocalization.of(context).translate("capacity"),
                                      subTitle: model.capacity.toString()
                                  ),
                                  IconTextWidget(
                                      icon: model.isFull == true ? close : check,
                                      iconSize: 20.w,
                                      iconColor: model.isFull == true ? AppColors.redColor : AppColors.darkGreenColor,
                                      text: AppLocalization.of(context).translate(model.isFull == true ? "full" : "available"),
                                      textStyle: AppTheme.bodyLarge.copyWith(fontSize: 18.sp)),
                                  IconTextWidget(
                                      icon: model.isActive == false ? close : check,
                                      iconSize: 20.w,
                                      iconColor: model.isActive == false ? AppColors.redColor : AppColors.darkGreenColor,
                                      text: AppLocalization.of(context).translate(model.isActive == false ? "unactive" : "active"),
                                      textStyle: AppTheme.bodyLarge.copyWith(fontSize: 18.sp)),
                                ],
                              ) : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: (event == null || event!.status != "pending")
          ? const SizedBox.shrink()
          : Container(
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
          backgroundColor: event!.isActive == false ?
          AppColors.grayColor :
          event!.isAttending == false ? AppColors.primaryColor : AppColors.redColor,
          borderRadius: 30.r,
          buttonName: AppLocalization.of(context).translate(event!.isAttending == false ? "attend" : "cancel"),
          function: () {
            if(event!.isActive == true ) {
              if(event!.isAttending == false) {
                Navigation.push(ConfirmBookingScreen(
                  type: AppLocalization.of(context).translate("event"),
                  event: event,
                  onRefresh: () => eventCubit!.getModel(silent: true),
                ));
              } else {
                Dialogs.showQuestion(
                  context,
                  title: "",
                  content: Column(
                    children: [
                      ListTile(
                        title: Text(AppLocalization.of(context).translate("are_you_sure") +
                            AppLocalization.of(context).translate("?"),
                          textAlign: TextAlign.center,
                          style: AppTheme.headlineSmall.copyWith(color: AppColors.mediumGrayColor),
                        ),
                      ),
                    ],
                  ),
                  btnOk: CreateModel(
                    withValidation: false,
                    onTap: () {},
                    onSuccess: (data) {
                      Navigation.pop();
                      eventCubit!.getModel(silent: true);
                    },
                    useCaseCallBack: (model) {
                      return CancelEventUseCase(CategoryRepository()).call(
                          params: CancelEventParams(eventId: event!.iD!));
                    },
                    child: CustomButton(
                      height: 40.h,
                      width: 1.sw,
                      backgroundColor: AppColors.redColor,
                      borderRadius: 8.r,
                      buttonName: AppLocalization.of(context).translate("ok"),
                      textStyle: AppTheme.headlineSmall.copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
