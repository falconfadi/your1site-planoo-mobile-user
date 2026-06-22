import 'package:centro/core/classes/Keys.dart';
import 'package:centro/core/classes/firebase_api.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/responsive/responsive.dart';
import 'package:centro/features/favorite/ui/favorite_screen.dart';
import 'package:centro/features/notification/data/notification_repository/notification_repository.dart';
import 'package:centro/features/notification/data/usecase/check_new_notifications_usecase.dart';
import 'package:centro/features/notification/ui/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {

  final String? title;
  final bool isNavBar;
  final Widget? leading;

  const CustomHeader({super.key, this.title, required this.isNavBar,this.leading});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Text(title!, style: AppTheme.bodyLarge.copyWith(fontSize: 22.sp)),
      ),
      centerTitle: true,
      elevation: 1,
      toolbarHeight: 200.h,
      surfaceTintColor: Colors.transparent,
      shadowColor: AppColors.blackColor.withOpacity(0.5),
      backgroundColor: AppColors.whiteColor,
      leadingWidth: isNavBar == true ? 1.sw : null,
      leading: isNavBar ? Row(
        children: [
          SizedBox(
            width: 150.w,
            child: Image.asset(logo, fit: BoxFit.contain),
          ),
        ],
      ) :
      leading ?? IconButton(
        icon: Icon(Icons.arrow_back,size: isTablet ? 20.sp : null),
        color: AppColors.blackColor,
        onPressed: () {
          Navigation.pop();
        },
      ),
      actions: !isNavBar ? [] : [
        ValueListenableBuilder<bool>(
          valueListenable: FirebaseApi.instance.hasNewNotificationsNotifier,
          builder: (_, hasNewNotifications, __) {
            return IconButton(
              onPressed: () async {
                await Navigation.push(
                  NotificationScreen(
                    onNotificationsUpdated: () async {
                      final result = await CheckNewNotificationsUseCase(NotificationRepository())
                          .call(params: CheckNewNotificationsParams());

                      if (result.hasDataOnly) {
                        FirebaseApi.instance.hasNewNotificationsNotifier.value =
                        result.data!.newNotifications!;
                      }
                    },
                  ),
                );
                final result = await CheckNewNotificationsUseCase(NotificationRepository()
                ).call(params: CheckNewNotificationsParams());
                if (result.hasDataOnly) {
                  FirebaseApi.instance.hasNewNotificationsNotifier.value =
                  result.data!.newNotifications!;
                }
              },
              icon: SizedBox(
                width: 24.w,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        notifications,
                        width: isTablet ? 20.w : 23.w,
                      ),
                    ),
                    if (hasNewNotifications)
                      Positioned(
                        top: 5.h,
                        right: 3.h,
                        child: Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: BoxDecoration(
                            color: AppColors.redColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.favorite_border,size: isTablet ? 20.sp : null),
          color: AppColors.blackColor,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          onPressed: () => Navigation.push(FavoriteScreen()),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(
    1.sw,
    Responsive.isTablet(
        Keys.navigatorKey.currentContext!) ? 100 : 50,
  );
}

