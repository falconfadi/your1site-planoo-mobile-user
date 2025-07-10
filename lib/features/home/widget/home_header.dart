import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatefulWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();

  @override
  Size get preferredSize => Size(1.sw, 50);
}

class _HomeHeaderState extends State<HomeHeader> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      surfaceTintColor: Colors.transparent,
      shadowColor: AppColors.blackColor.withOpacity(0.5),
      backgroundColor: AppColors.whiteColor,
      leading: isSearching ?
      IconButton(
        icon: Icon(Icons.close, color: AppColors.blackColor),
        onPressed: () {
          setState(() {
            isSearching = false;
            _searchController.clear();
          });
        },
      ) : null,
      title: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SizeTransition(sizeFactor: animation, child: child),
        ),
        child: isSearching ?
        CustomTextField(
          autoFocus: false,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          borderColor: Colors.transparent,
          labelText: AppLocalization.of(context).translate("search"),
          onFieldSubmitted: (value) {
            // todo pass the value to api
          },
        ) : Row(
          key: ValueKey("logo"),
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(logo, height: 50),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: AppColors.primaryColor),
          onPressed: () {
            setState(() {
              isSearching = true;
            });
          },
        ),
      ],
    );
  }
}

