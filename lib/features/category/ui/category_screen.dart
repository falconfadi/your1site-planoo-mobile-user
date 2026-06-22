import 'package:centro/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:centro/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/constants/end_point.dart';
import 'package:centro/core/constants/enum/sort_enum.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/tabs_widget.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/ui/widgets/custom_sheet.dart';
import 'package:centro/core/utils/responsive/responsive.dart';
import 'package:centro/features/category/data/model/filter_result_model.dart';
import 'package:centro/features/category/widget/filter_sheet.dart';
import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/court/court_details_model.dart';
import 'package:centro/features/category/data/model/category_model.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';
import 'package:centro/features/category/data/usecase/court/all_courts_usecase.dart';
import 'package:centro/features/category/data/usecase/categories_usecase.dart';
import 'package:centro/features/category/data/usecase/course/all_courses_usecase.dart';
import 'package:centro/features/category/data/usecase/event/all_events_usecase.dart';
import 'package:centro/features/home/widget/home_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:centro/core/boilerplate/pagination/widgets/pagination_list.dart' as pagination;
import 'package:flutter_svg/flutter_svg.dart';

class CategoryScreen extends StatefulWidget {

  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  int? selectedCategory;
  int? categoryId;
  int selectedTab = 0;
  late PaginationCubit cubit;
  SortOrder? priceOrder;
  SortOrder? rateOrder;

  Widget _buildPaginatedTab<T>({
    required pagination.CreatedCallback onCubitCreated,
    required RepositoryCallBack repositoryCallBack,
    required Widget Function(T item) itemBuilder,
  }) {
    return pagination.PaginationList<T>(
      key: ValueKey("$priceOrder-$rateOrder"),
      scrollDirection: Axis.vertical,
      withPagination: true,
      onCubitCreated: onCubitCreated,
      repositoryCallBack: repositoryCallBack,
      listBuilder: (list) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return itemBuilder(list[index]);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: CustomHeader(title: "",isNavBar: true),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              SizedBox(
                height: 55.h,
                child: GetModel<CategoryModel>(
                  useCaseCallBack: () {
                    return CategoriesUseCase(CategoryRepository()).call(params: CategoriesParams());
                  },
                  onSuccess: (result) {
                    if (categoryId == null && result.categoriesList!.isNotEmpty) {
                      setState(() {
                        selectedCategory = 0;
                        categoryId = result.categoriesList!.first.id;
                      });
                    }
                  },
                  modelBuilder: (model) => ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: model.categoriesList!.length,
                    itemBuilder: (context,index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedCategory = index;
                            categoryId = model.categoriesList![index].id!;
                            cubit.getList();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: selectedCategory == index ? AppColors.primaryColor.withOpacity(0.5) : AppColors.whiteColor,
                            border: Border.all(color: selectedCategory == index ? Colors.transparent : AppColors.primaryColor.withOpacity(0.5))
                          ),
                          child: Row(
                            children: [
                              if (model.categoriesList![index].icon != null) ...[
                                CachedImage(
                                  width: isTablet ? null : 45.w,
                                  height: 45.w,
                                  imageUrl: serverUrl + model.categoriesList![index].icon!,
                                  fit: BoxFit.contain,
                                  borderRadius: 10.r,
                                ),
                              ],
                              Padding(
                                padding: EdgeInsets.only(top: 5.h,left: 8.w,right: 8.w),
                                child: Text(model.categoriesList![index].name!, style: AppTheme.bodyLarge.copyWith(fontSize: 18.sp)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () async {
                        final result = await CustomSheet.show<FilterResultModel>(
                          context: context,
                          isDismissible: true,
                          padding: 30.w,
                          header: Text(
                            AppLocalization.of(context).translate("filter"),
                            style: AppTheme.titleLarge.copyWith(fontSize: 18.sp),
                          ),
                          child: FilterSheet(
                            initialPriceOrder: priceOrder,
                            initialRateOrder: rateOrder,
                          ),
                        );

                        if (result != null) {
                          setState(() {
                            priceOrder = result.priceOrder;
                            rateOrder = result.rateOrder;
                          });
                        }
                      },
                      child: SvgPicture.asset(filter,color: AppColors.purpleColor,width: 20.w)
                  ),
                  Expanded(
                    child: TabsWidget(
                      selectedTab: selectedTab,
                      inCenter: true,
                      onTabChanged: (index) {
                        setState(() {
                          selectedTab = index;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              if (categoryId != null)
                Expanded(
                  child: selectedTab == 0 ?
                  _buildPaginatedTab<CourtDetailsModel>(
                    onCubitCreated: (cub) => cubit = cub,
                    repositoryCallBack: (model) {
                      return AllCourtsUseCase(CategoryRepository())
                          .call(params: AllCourtsParams(model,
                        categoryId: categoryId!,price: priceOrder?.value,rate: rateOrder?.value));
                    },
                    itemBuilder: (item) => HomeItem(court: item)
                  ) : selectedTab == 1 ? _buildPaginatedTab<CourseDetailsModel>(
                    onCubitCreated: (cub) => cubit = cub,
                    repositoryCallBack: (model) {
                      return AllCoursesUseCase(CategoryRepository())
                          .call(params: AllCoursesParams(model, categoryId: categoryId!,price: priceOrder?.value,rate: rateOrder?.value));
                    },
                    itemBuilder: (item) => HomeItem(course: item),
                  ) : _buildPaginatedTab<EventDetailsModel>(
                    onCubitCreated: (cub) => cubit = cub,
                    repositoryCallBack: (model) {
                      return AllEventsUseCase(CategoryRepository())
                          .call(params: AllEventsParams(model, categoryId: categoryId!,price: priceOrder?.value,rate: rateOrder?.value));
                    },
                    itemBuilder: (item) => HomeItem(event: item),
                  ),
                ),
              SizedBox(height: 15.h),
            ],
          ),
        )
    );
  }
}