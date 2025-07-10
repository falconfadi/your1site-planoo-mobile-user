import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/constants/enum/partner_details_tabs.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/custom_rate_sheet.dart';
import 'package:centro/core/ui/shared_widgets/custom_rating_bar.dart';
import 'package:centro/core/ui/shared_widgets/custom_row_widget.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/ui/widgets/coustom_sheet.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/home/data/model/activity_model.dart';
import 'package:centro/features/home/ui/activities_screen.dart';
import 'package:centro/features/home/ui/reivews_screen.dart';
import 'package:centro/features/home/widget/category/category_widget.dart';
import 'package:centro/features/home/widget/open_days_widget.dart';
import 'package:centro/features/home/widget/review_widget.dart';
import 'package:centro/features/home/widget/service_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrainerDetailsScreen extends StatefulWidget {

  TrainerDetailsScreen({super.key});

  @override
  State<TrainerDetailsScreen> createState() => _TrainerDetailsScreenState();
}

class _TrainerDetailsScreenState extends State<TrainerDetailsScreen> {

  int selectedTab = 0;
  bool openDays = false;

  // todo change them from backend
  List<String> openDaysList = ['Sunday', 'Monday', 'Tuesday', 'Wednesday'];
  List<ActivityModel> services = [
    ActivityModel(
      name: "Tennis Training",
      price: 1500,
      type: "normal",
      description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc",
      times: [
        ServiceTime(day: "Monday", time: "10:00",court: "CourA"),
        ServiceTime(day: "Monday", time: "12:00",court: "CourB"),
        ServiceTime(day: "Friday", time: "10:00",court: "CourA"),
        ServiceTime(day: "Friday", time: "11:00",court: "CourA"),
      ],
    ),
    ActivityModel(
      name: "VIP Coaching",
      price: 5000,
      type: "vip",
      description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna.",
      times: [
        ServiceTime(day: "Monday", time: "15:00",court: "CourB"),
        ServiceTime(day: "Friday", time: "12:00",court: "CourC"),
      ],
    ),
    ActivityModel(
      name: "Group Fitness",
      price: 1200,
      type: "normal",
      description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus.",
      times: [
        ServiceTime(day: "Tuesday", time: "09:00",court: "CourA"),
        ServiceTime(day: "Thursday", time: "13:00",court: "CourB"),
      ],
    ),
    ActivityModel(
      name: "Private Session",
      price: 4800,
      type: "vip",
      description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero",
      times: [
        ServiceTime(day: "Wednesday", time: "14:00",court: "CourC"),
        ServiceTime(day: "Saturday", time: "10:00",court: "CourA"),
      ],
    ),
    ActivityModel(
      name: "Kids Sports Class",
      price: 900,
      type: "normal",
      description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus.",
      times: [
        ServiceTime(day: "Sunday", time: "08:00",court: "CourA"),
        ServiceTime(day: "Tuesday", time: "10:00",court: "CourA"),
      ],
    ),
    ActivityModel(
      name: "Advanced Match Prep",
      price: 5300,
      type: "vip",
      description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero",
      times: [
        ServiceTime(day: "Monday", time: "17:00",court: "CourB"),
        ServiceTime(day: "Friday", time: "15:00",court: "CourB"),
      ],
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomHeader(title: '', isNavBar: false),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImage(
                borderRadius: 0,
                imageUrl: "",
                height: 200.w,
                width: 1.sw,
                fit: BoxFit.cover,
                withCorner: false,
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Green Valley Basketball Court",
                      style: AppTheme.titleMedium.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Basketball",
                      style: AppTheme.bodyMedium.copyWith(color: AppColors.primaryColor),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "( male - 12/5/1980 - 0997845632 )",
                      style: AppTheme.labelMedium.copyWith(color: AppColors.darkGrayColor),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        CustomRatingBar(rate: 2.5,size: 20,iconData: Icons.star),
                        Text(
                          " " "(2.5)",
                          style: AppTheme.labelMedium.copyWith(color: AppColors.darkGrayColor),
                        ),
                      ],
                    ),
                  ]
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: PartnerDetailsTabs.values.length,
                  itemBuilder: (context, index) {
                    final tab = PartnerDetailsTabs.values[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedTab = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 25.w),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: selectedTab == index ?
                            AppColors.darkGrayColor : Colors.transparent),
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(tab.index == 0 ? category :
                            tab.index == 1 ? about : rate,color: selectedTab == index ?
                            AppColors.darkGrayColor : AppColors.mediumGrayColor,width: 20.w),
                            SizedBox(width: 5.w),
                            Text(AppLocalization.of(context).translate(tab.name),style: AppTheme.labelLarge.copyWith(color: selectedTab == index ?
                            AppColors.darkGrayColor : AppColors.mediumGrayColor))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              selectedTab == 0 ?
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 25.h),
                child: Center(
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: [1,2,3,4,5].map((e) {
                      return CategoryWidget(
                        size: 70,
                        textStyle: AppTheme.titleMedium.copyWith(fontSize: 12),
                      );
                    }).toList(),
                  ),
                ),
              ) : selectedTab == 1 ? Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 25.h),
                child: Text("A basketball court is a flat, rectangular playing area designed for small-sided football (soccer) matches. Commonly found outdoors, it may feature artificial turf or hard surfaces with boundary markings, goalposts, and sometimes fencing for safety. It's perfect for recreational games, training, and local competitions, offering a fast-paced, engaging environment.",
                  style: AppTheme.labelMedium.copyWith(fontWeight: FontWeight.w200)),
              ) : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 25.h),
                child: Column(
                  children: [
                    CustomButton(
                      height: 54.h,
                      backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                      borderRadius: 4.r,
                      icon: star,
                      iconColor: AppColors.primaryColor,
                      textStyle: AppTheme.bodyMedium
                          .copyWith(fontSize: 16, color: AppColors.primaryColor),
                      buttonName: AppLocalization.of(context).translate("add_review"),
                      function: () => CustomSheet.show(
                          isDismissible: true,
                          header: Text(AppLocalization.of(context).translate("add_review")),
                          headerStyle: AppTheme.bodyMedium,
                          padding: 30.w,
                          context: context,
                          child: CustomRateSheet())
                    ),
                    SizedBox(height: 15.h),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context,ratingIndex) {
                        return ReviewWidget();
                      },
                    ),
                    InkWell(
                      onTap: () => Navigation.push(ReviewsScreen()),
                      child: Text(AppLocalization.of(context).translate("see_all"),
                          style: AppTheme.labelMedium.copyWith(color: AppColors.primaryColor)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: CustomRowWidget(
                      text: AppLocalization.of(context).translate("activities"),
                      seeAllText: true,
                      seeAllOnTap: () => Navigation.push(ActivitiesScreen(
                        partnerType: "trainer",
                        allServices: services,
                      ))
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: services.take(6).toList().length,
                      itemBuilder: (context,index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: ServiceWidget(
                              name: services[index].name,
                              onTap: () async {
                                Navigation.push(ActivitiesScreen(
                                  partnerType: "trainer",
                                  allServices: services,
                                  initiallySelected: services[index],
                                ));
                              },
                            )
                          );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100.h),
            ],
          )
      ),
    );
  }
}