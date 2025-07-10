import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {

  final String? title;
  final bool isNavBar;
  Widget? leading;
  List<Widget>? actions;

  CustomHeader({this.title, required this.isNavBar,this.leading,this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!, style: AppTheme.titleSmall),
      centerTitle: true,
      elevation: 1,
      surfaceTintColor: Colors.transparent,
      shadowColor: AppColors.blackColor.withOpacity(0.5),
      backgroundColor: AppColors.whiteColor,
      leadingWidth: isNavBar ? 140.w : null,
      leading: !isNavBar ? leading ?? IconButton(
        icon: Icon(Icons.arrow_back),
        color: AppColors.blackColor,
        onPressed: () {
          if(!isNavBar) {
            Navigation.pop();
          }
        },
      ) : Image.asset(logo),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => Size(1.sw, 50);
}
