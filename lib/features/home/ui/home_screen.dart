import 'package:centro/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/tabs_widget.dart';
import 'package:centro/features/home/data/home_repository/home_repository.dart';
import 'package:centro/features/home/data/model/featured_model.dart';
import 'package:centro/features/home/data/model/feeds_model.dart';
import 'package:centro/features/home/data/usecase/featured_usecase.dart';
import 'package:centro/features/home/data/usecase/feeds_usecase.dart';
import 'package:centro/features/home/widget/featured_item.dart';
import 'package:centro/features/home/widget/home_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: CustomHeader(title: "",isNavBar: true),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabsWidget(
                inCenter: true,
                selectedTab: selectedTab,
                onTabChanged: (index) {
                  setState(() {
                    selectedTab = index;
                  });
                },
              ),
              SizedBox(height: 10.h),
              Text(AppLocalization.of(context).translate("featured"),
                style: AppTheme.titleLarge.copyWith(fontSize: 20.sp),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                child: GetModel<FeaturedModel>(
                  loadingHeight: 1.sh * 0.3.h,
                  useCaseCallBack: () {
                    return FeaturedUseCase(HomeRepository()).call(params: FeaturedParams());
                  },
                  modelBuilder: (model) => FeaturedItem(
                    court: selectedTab == 0 ? model.featuredInfoModel!.courts!.first : null,
                    course: selectedTab == 1 ? model.featuredInfoModel!.courses!.first : null,
                    event: selectedTab == 2 ? model.featuredInfoModel!.events!.first : null,
                  ),
                ),
              ),
              SizedBox(height: 35.h),
              Text(AppLocalization.of(context).translate("feeds"),
                style: AppTheme.titleLarge.copyWith(fontSize: 20.sp),
              ),
              SizedBox(height: 5.h),
              GetModel<FeedsModel>(
                loadingHeight: 1.sh * 0.3.h,
                useCaseCallBack: () {
                  return FeedsUseCase(HomeRepository()).call(params: FeedsParams());
                },
                modelBuilder: (model) => ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:  selectedTab == 0 ? model.feedsList!.courts!.length :
                  selectedTab == 1 ?  model.feedsList!.courses!.length : model.feedsList!.events!.length,
                  itemBuilder: (context,index) {
                    return HomeItem(
                      court: selectedTab == 0 ? model.feedsList!.courts![index] : null,
                      course: selectedTab == 1 ? model.feedsList!.courses![index] : null,
                      event: selectedTab == 2 ? model.feedsList!.events![index] : null,
                    );
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}