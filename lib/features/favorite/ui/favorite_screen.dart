import 'package:centro/core/boilerplate/get_model/cubits/get_model_cubit.dart';
import 'package:centro/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/features/favorite/data/favorite_repository/favorite_repository.dart';
import 'package:centro/features/favorite/data/model/favorites_model.dart';
import 'package:centro/features/favorite/data/usecase/favorites_usecase.dart';
import 'package:centro/features/favorite/widget/favorite_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteScreen extends StatefulWidget {

  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  GetModelCubit<FavoritesModel>? refreshCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: CustomHeader(title: AppLocalization.of(context).translate("favorites"),isNavBar: false),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 1.sw,
                child: GetModel<FavoritesModel>(
                  loadingHeight: 1.sh * 0.3.h,
                  onCubitCreated: (cubit) {
                    refreshCubit = cubit as GetModelCubit<FavoritesModel>;
                  },
                  useCaseCallBack: () {
                    return FavoritesUseCase(FavoriteRepository()).call(params: FavoritesParams());
                  },
                  modelBuilder: (model) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: model.favoritesList!.length,
                      itemBuilder: (context, index) {
                        return FavoriteItem(
                          favorite: model.favoritesList![index],
                          onRefresh: () {
                            refreshCubit!.getModel();
                          },
                        );
                      },
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
